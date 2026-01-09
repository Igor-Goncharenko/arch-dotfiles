import i3ipc
import argparse
import time
from enum import Enum
from typing import List, Optional, Self


def argparser_init() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
            prog="Workspace manager for i3wm")

    parser.add_argument(
            "--ws",
            nargs="+",
            default=[],
            help="Workspaces to use",
            required=True
            )
    parser.add_argument(
            "--cmd",
            nargs=1,
            required=True
            )

    return parser


class WorkspaceMode(Enum):
    PRIMARY_MAIN = 0
    PRIMARY_SEC = 1
    SPLIT_SEC_PRIMARY = 2
    SPLIT_MAIN_PRIMARY = 3

    @classmethod
    def from_str(cls, s: str) -> Optional[Self]:
        MODE_STR = {
                "primary-main": WorkspaceMode.PRIMARY_MAIN,
                "primary-secondary": WorkspaceMode.PRIMARY_SEC,
                "split-main-primary": WorkspaceMode.SPLIT_MAIN_PRIMARY,
                "split-secondary-primary": WorkspaceMode.SPLIT_SEC_PRIMARY,
        }
        mode = MODE_STR.get(s)
        return cls(mode) if mode is not None else None


class WorkspaceManager:
    def __init__(self, workspaces: List[str]) -> None:
        self.i3 = i3ipc.Connection()
        self.workspaces = workspaces
        self.n_ws = len(workspaces)
        self.primary = "eDP-1"
        self.secondary = "HDMI-1"

    def get_active_workspace(self) -> Optional[str]:
        workspaces = self.i3.get_workspaces()
        for workspace in workspaces:
            if workspace.focused:
                return workspace.name
        return None
    
    def move_workspace(self, workspace: str, output: str) -> None:
        self.i3.command(f"workspace \"{workspace}\"")
        self.i3.command(f"move workspace to output {output}")
        time.sleep(0.01)

    def move_primary_main(self) -> None:
        for w in self.workspaces:
            self.move_workspace(w, self.primary)

    def move_primary_sec(self) -> None:
        for w in self.workspaces:
            self.move_workspace(w, self.secondary)

    def move_split_main_primary(self) -> None:
        for w in self.workspaces[:self.n_ws // 2]:
            self.move_workspace(w, self.primary)
        for w in self.workspaces[self.n_ws // 2:]:
            self.move_workspace(w, self.secondary)

    def move_split_sec_primary(self) -> None:
        for w in self.workspaces[:self.n_ws // 2]:
            self.move_workspace(w, self.secondary)
        for w in self.workspaces[self.n_ws // 2:]:
            self.move_workspace(w, self.primary)

    def update_workspaces(self, mode: WorkspaceMode) -> None:
        active_workspace = self.get_active_workspace()

        match mode:
            case WorkspaceMode.PRIMARY_MAIN:
                self.move_primary_main()
            case WorkspaceMode.PRIMARY_SEC:
                self.move_primary_sec()
            case WorkspaceMode.SPLIT_MAIN_PRIMARY:
                self.move_split_main_primary()
            case WorkspaceMode.SPLIT_SEC_PRIMARY:
                self.move_split_sec_primary()

        self.i3.command(f"workspace \"{active_workspace}\"")

        time.sleep(0.3)


def main() -> None:
    parser = argparser_init()
    args = parser.parse_args()
    manager = WorkspaceManager(args.ws)

    command = WorkspaceMode.from_str(args.cmd[0])
    if command is not None:
        manager.update_workspaces(command)
    else:
        print("Incorrect command")


if __name__ == "__main__":
    main()

