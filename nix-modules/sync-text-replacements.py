#!/usr/bin/env python3
"""Manage macOS Keyboard text replacements from a nix-declared desired set.

Upserts entries present in the desired JSON and removes any DB rows whose
shortcut is not declared, so nix is the source of truth.
"""
from __future__ import annotations

import argparse
import subprocess
import json
import sqlite3
import time
import uuid
from pathlib import Path


def core_data_now() -> float:
    return time.time() - 978307200


def ensure_schema(conn: sqlite3.Connection) -> None:
    conn.executescript(
        """
        CREATE TABLE IF NOT EXISTS ZTEXTREPLACEMENTENTRY (
          Z_PK INTEGER PRIMARY KEY,
          Z_ENT INTEGER,
          Z_OPT INTEGER,
          ZNEEDSSAVETOCLOUD INTEGER,
          ZWASDELETED INTEGER,
          ZTIMESTAMP TIMESTAMP,
          ZPHRASE VARCHAR,
          ZSHORTCUT VARCHAR,
          ZUNIQUENAME VARCHAR,
          ZREMOTERECORDINFO BLOB
        );
        CREATE TABLE IF NOT EXISTS Z_PRIMARYKEY (
          Z_ENT INTEGER PRIMARY KEY,
          Z_NAME VARCHAR,
          Z_SUPER INTEGER,
          Z_MAX INTEGER
        );
        INSERT OR IGNORE INTO Z_PRIMARYKEY (Z_ENT, Z_NAME, Z_SUPER, Z_MAX)
          VALUES (1, 'TextReplacementEntry', 0, 0);
        """
    )


def sync(db_path: Path, desired: list[dict[str, str]]) -> tuple[int, int, int]:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(str(db_path))
    ensure_schema(conn)
    added = updated = removed = 0
    now = core_data_now()

    desired_map = {item["shortcut"]: item["phrase"] for item in desired}

    existing = {
        row[0]: (row[1], row[2], row[3])
        for row in conn.execute(
            "SELECT ZSHORTCUT, Z_PK, ZPHRASE, ZWASDELETED FROM ZTEXTREPLACEMENTENTRY"
        )
    }

    max_pk = conn.execute(
        "SELECT COALESCE(MAX(Z_PK), 0) FROM ZTEXTREPLACEMENTENTRY"
    ).fetchone()[0]

    for shortcut, phrase in desired_map.items():
        if shortcut in existing:
            pk, old_phrase, was_deleted = existing[shortcut]
            if was_deleted or old_phrase != phrase:
                conn.execute(
                    """
                    UPDATE ZTEXTREPLACEMENTENTRY
                       SET ZPHRASE = ?,
                           ZWASDELETED = 0,
                           ZNEEDSSAVETOCLOUD = 1,
                           ZTIMESTAMP = ?,
                           Z_OPT = Z_OPT + 1
                     WHERE Z_PK = ?
                    """,
                    (phrase, now, pk),
                )
                updated += 1
            continue

        max_pk += 1
        conn.execute(
            """
            INSERT INTO ZTEXTREPLACEMENTENTRY (
              Z_PK, Z_ENT, Z_OPT, ZNEEDSSAVETOCLOUD, ZWASDELETED,
              ZTIMESTAMP, ZPHRASE, ZSHORTCUT, ZUNIQUENAME
            ) VALUES (?, 1, 1, 1, 0, ?, ?, ?, ?)
            """,
            (max_pk, now, phrase, shortcut, str(uuid.uuid4()).upper()),
        )
        added += 1

    # Remove anything that isn't declared in nix.
    # Soft-delete first (iCloud tombstone), then hard-delete locally so the
    # Keyboard Settings UI does not keep showing the shortcut.
    for shortcut, (pk, _phrase, was_deleted) in list(existing.items()):
        if shortcut in desired_map:
            continue
        if not was_deleted:
            conn.execute(
                """
                UPDATE ZTEXTREPLACEMENTENTRY
                   SET ZWASDELETED = 1,
                       ZNEEDSSAVETOCLOUD = 1,
                       ZTIMESTAMP = ?,
                       Z_OPT = Z_OPT + 1
                 WHERE Z_PK = ?
                """,
                (now, pk),
            )
            removed += 1
        conn.execute("DELETE FROM ZTEXTREPLACEMENTENTRY WHERE Z_PK = ?", (pk,))
        existing.pop(shortcut, None)

    # Also purge any leftover tombstones for shortcuts not in nix.
    for row in conn.execute(
        "SELECT Z_PK, ZSHORTCUT FROM ZTEXTREPLACEMENTENTRY WHERE ZWASDELETED = 1"
    ).fetchall():
        pk, shortcut = row
        if shortcut in desired_map:
            continue
        conn.execute("DELETE FROM ZTEXTREPLACEMENTENTRY WHERE Z_PK = ?", (pk,))
        removed += 1

    conn.execute(
        "UPDATE Z_PRIMARYKEY SET Z_MAX = ? WHERE Z_ENT = 1",
        (max_pk,),
    )
    conn.commit()
    conn.close()
    return added, updated, removed


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", required=True, type=Path)
    parser.add_argument("--json", required=True, type=Path)
    args = parser.parse_args()
    desired = json.loads(args.json.read_text())
    added, updated, removed = sync(args.db, desired)
    print(
        f"text-replacements: added {added}, updated {updated}, removed {removed}"
    )
    # Reload text-input stack so in-memory caches drop removed shortcuts.
    for proc in (
        "keyboardservicesd",
        "TextInputMenuAgent",
        "TextInputSwitcher",
    ):
        subprocess.run(
            ["/usr/bin/killall", proc],
            check=False,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


if __name__ == "__main__":
    main()
