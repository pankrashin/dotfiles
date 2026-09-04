import re
from functools import lru_cache

from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, apply_title_template, as_rgb
from kitty.utils import color_as_int

LEFT_CAP = ""
RIGHT_CAP = ""
SEPARATOR = "│"

# cursor.bg == 0 means "the default background", the only background kitty keeps
# translucent under background_opacity/background_blur. Any explicit color is
# painted opaque, even when it is identical to the default background.
DEFAULT_BG = 0
DEFAULT_FG = 0

INACTIVE_TEXT_BLEND = 0.65
SEPARATOR_BLEND = 0.30

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
def _palette(bar_bg: int, ref_fg: int) -> tuple[int, int]:
    return (
        as_rgb(_blend(bar_bg, ref_fg, INACTIVE_TEXT_BLEND)),
        as_rgb(_blend(bar_bg, ref_fg, SEPARATOR_BLEND)),
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

    inactive_fg, sep_fg = _palette(
        color_as_int(draw_data.default_bg), color_as_int(draw_data.inactive_fg)
    )
    active_bg = as_rgb(draw_data.tab_bg(tab))
    bold, italic = screen.cursor.bold, screen.cursor.italic

    def put(
        x: int, text: str, fg: int, bg: int, b: bool = False, i: bool = False
    ) -> None:
        screen.cursor.x = x
        screen.cursor.fg, screen.cursor.bg = fg, bg
        screen.cursor.bold, screen.cursor.italic = b, i
        screen.draw(text)

    if tab.is_active:
        fill = active_bg
        text_fg = as_rgb(draw_data.tab_fg(tab))
    else:
        fill = DEFAULT_BG
        text_fg = inactive_fg

    put(x0, " " * width, text_fg, fill)

    inner = width - 2
    if inner > 0:
        title = _SGR.sub("", apply_title_template(draw_data, tab, index, inner))
        title = _fit(title.strip(), inner)
        put(x0 + 1 + (inner - wcswidth(title)) // 2, title, text_fg, fill, bold, italic)

    if tab.is_active:
        # Round the pill off by painting the caps as foreground glyphs on the
        # default background, so the bar stays transparent around them.
        if width >= 2:
            put(x0, LEFT_CAP, active_bg, DEFAULT_BG)
            put(x1 - 1, RIGHT_CAP, active_bg, DEFAULT_BG)
    elif extra_data.next_tab is not None and not extra_data.next_tab.is_active:
        put(x1 - 1, SEPARATOR, sep_fg, DEFAULT_BG)

    screen.cursor.bold, screen.cursor.italic = bold, italic
    screen.cursor.fg, screen.cursor.bg = DEFAULT_FG, DEFAULT_BG
    screen.cursor.x = x1
    return x1
