from typing import Any, Dict
from kitty.boss import Boss
from kitty.fast_data_types import cocoa_hide_other_apps, os_window_focus_counters
from kitty.window import Window

_handled: Dict[int, int] = {}


def on_load(boss: Boss, data: Dict[str, Any]) -> None:
    cocoa_hide_other_apps()


def on_focus_change(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
    if not data.get("focused", False):
        return
    os_window_id = window.os_window_id
    counter = os_window_focus_counters().get(os_window_id, 0)
    if _handled.get(os_window_id) == counter:
        return
    _handled[os_window_id] = counter
    cocoa_hide_other_apps()
