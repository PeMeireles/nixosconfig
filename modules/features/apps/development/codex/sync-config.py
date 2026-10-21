"""Merge Home Manager settings without losing Codex's writable state."""

from collections.abc import Mapping
import os
from pathlib import Path
import sys
import tempfile

import tomlkit


def merge(target, settings):
    for key, value in settings.items():
        if isinstance(value, Mapping) and isinstance(target.get(key), Mapping):
            merge(target[key], value)
        else:
            target[key] = value


def sync(source, target):
    original = target.read_text() if target.exists() else ""
    document = tomlkit.parse(original)
    merge(document, tomlkit.parse(source.read_text()))
    updated = tomlkit.dumps(document)
    if updated == original and not target.is_symlink():
        return

    target.parent.mkdir(parents=True, exist_ok=True)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(
            mode="w", dir=target.parent, delete=False
        ) as output:
            temporary = Path(output.name)
            output.write(updated)
        os.replace(temporary, target)
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


if __name__ == "__main__":
    sync(Path(sys.argv[1]), Path(sys.argv[2]))
