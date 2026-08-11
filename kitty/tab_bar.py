import re
from functools import lru_cache

from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, apply_title_template, as_rgb
from kitty.utils import color_as_int

LEFT_CAP = ""
RIGHT_CAP = ""
SEPARATOR = "│"

TROUGH_BLEND = 0.10
INACTIVE_TEXT_BLEND = 0.55
SEPARATOR_BLEND = 0.25

_SGR = re.compile("\x1b\\[[0-9:;]*m")

_counted: dict[int, int] = {}
_final: dict[int, int] = {}


def _blend(a: int, b: int, f: float) -> int:
    out = 0
    for shift in (16, 8, 0):
        x, y = (a >> shift) & 255, (b >> shift) & 255
        out |= round(x + (y - x) * f) << shift
    return out


@lru_cache(maxsize=8)
def _palette(bar_bg: int, ref_fg: int) -> tuple[int, int, int, int]:
    trough = _blend(bar_bg, ref_fg, TROUGH_BLEND)
    return (
        as_rgb(bar_bg),
        as_rgb(trough),
        as_rgb(_blend(trough, ref_fg, INACTIVE_TEXT_BLEND)),
        as_rgb(_blend(trough, ref_fg, SEPARATOR_BLEND)),
    )


def _fit(text: str, width: int) -> str:
    if width <= 0:
        return ""
    if wcswidth(text) <= width:
        return text
    if width == 1:
        return "…"
    out, w = "", 0
    for ch in text:
        cw = wcswidth(ch)
        if w + cw > width - 1:
            break
        out += ch
        w += cw
    return out + "…"


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    os_window_id = draw_data.os_window_id

    if extra_data.for_layout:
        _counted[os_window_id] = 1 if index == 1 else _counted.get(os_window_id, 0) + 1
        if is_last:
            _final[os_window_id] = _counted[os_window_id]
        screen.cursor.x = screen.columns
        return screen.cursor.x

    cols = screen.columns
    ntabs = max(_final.get(os_window_id, index), index)
    x0 = ((index - 1) * cols) // ntabs
    x1 = (index * cols) // ntabs
    width = x1 - x0
    if width < 1:
        screen.cursor.x = x1
        return x1

    bar_bg, trough, inactive_fg, sep_fg = _palette(
        color_as_int(draw_data.default_bg), color_as_int(draw_data.inactive_fg)
    )
    active_bg = as_rgb(draw_data.tab_bg(tab))
    bold, italic = screen.cursor.bold, screen.cursor.italic

    def put(x: int, text: str, fg: int, bg: int, b: bool = False, i: bool = False) -> None:
        screen.cursor.x = x
        screen.cursor.fg, screen.cursor.bg = fg, bg
        screen.cursor.bold, screen.cursor.italic = b, i
        screen.draw(text)

    fill = active_bg if tab.is_active else trough
    text_fg = as_rgb(draw_data.tab_fg(tab)) if tab.is_active else inactive_fg

    put(x0, " " * width, text_fg, fill)

    inner = width - 2
    if inner > 0:
        title = _SGR.sub("", apply_title_template(draw_data, tab, index, inner))
        title = _fit(title.strip(), inner)
        put(x0 + 1 + (inner - wcswidth(title)) // 2, title, text_fg, fill, bold, italic)

    if tab.is_active:
        put(x0, LEFT_CAP, active_bg, bar_bg if index == 1 else trough)
    elif index == 1:
        put(x0, LEFT_CAP, trough, bar_bg)

    if tab.is_active:
        put(x1 - 1, RIGHT_CAP, active_bg, bar_bg if is_last else trough)
    elif is_last:
        put(x1 - 1, RIGHT_CAP, trough, bar_bg)
    elif extra_data.next_tab is not None and not extra_data.next_tab.is_active:
        put(x1 - 1, SEPARATOR, sep_fg, trough)

    screen.cursor.bold, screen.cursor.italic = bold, italic
    screen.cursor.x = x1
    return x1
