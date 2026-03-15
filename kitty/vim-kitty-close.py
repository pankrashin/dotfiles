from typing import List
from kitty.boss import Boss


def main(args: List[str]) -> str:
    pass


def _is_vim(window) -> bool:
    return any(
        "nvim" in cmd or "vim" in cmd
        for proc in window.child.foreground_processes
        for cmd in proc.get("cmdline", [])
    )


def handle_result(
    args: List[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    window = boss.window_id_map.get(target_window_id)
    if not window:
        return

    if _is_vim(window):
        window.write_to_child(b"\x1bZZ")
    else:
        boss.close_window_with_confirmation(window)


handle_result.no_ui = True
