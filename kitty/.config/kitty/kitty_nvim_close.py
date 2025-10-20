#!/usr/bin/env python3
"""
Smart close kitten for kitty terminal.
Closes Neovim buffer if Neovim is running, otherwise closes kitty window.
"""

from typing import List
from kitty.boss import Boss

def main(args: List[str]) -> str:
    pass

def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    """Handle the result and perform the appropriate action."""
    window = boss.window_id_map.get(target_window_id)
    
    if not window:
        return
    
    # Get the foreground process name
    fg_processes = window.child.foreground_processes
    
    # Check if Neovim is running
    is_nvim = any(
        proc.get('cmdline') and any('nvim' in cmd or 'vim' in cmd for cmd in proc['cmdline'])
        for proc in fg_processes
    )
    
    if is_nvim:
        # Send command to close current buffer in Neovim
        # Using :bd (buffer delete) which closes the current buffer
        # If it's the last buffer, it will close the window
        window.write_to_child('\x1b:q\r'.encode('utf-8'))
    else:
        # Close the kitty window
        boss.close_window_with_confirmation(window)

handle_result.no_ui = True
