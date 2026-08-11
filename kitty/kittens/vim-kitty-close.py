import os
from kitty.boss import Boss
from kittens.tui.handler import result_handler


def main(args: list[str]) -> str:
    pass


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    for process in window.child.foreground_processes:
        cmdline = process.get("cmdline")
        if not cmdline:
            continue
        name = os.path.basename(cmdline[0])
        if name == "nvim":
            window.write_to_child(b"\x1bZZ")
            return
        if name == "kitten":
            return

    boss.close_window_with_confirmation(window)
