#!/usr/bin/env python3
import argparse
import json
import sys
import os
import subprocess
from typing import List, Set

def get_decrypted_content(filepath: str) -> str:
    """
    Invokes GPG to decrypt the file and returns the content as a string.
    Raises exception if GPG fails.
    """
    passphrase = os.getenv("TG_GPG_PASSPHRASE")
    cmd = ["gpg", "--quiet", "--batch", "--yes", "--decrypt", f"--passphrase={passphrase}", filepath]

    try:
        result = subprocess.run(
            cmd,
            check=True,
            capture_output=True,
            text=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"[{filepath}] 🔐 GPG Decryption Failed: {e.stderr.strip()}")
        raise e
    except FileNotFoundError:
        print("❌ Error: 'gpg' command not found. Please install GnuPG.")
        sys.exit(1)

def validate_content(filepath: str, json_content: str):
    """
    Validates the JSON string content.
    """
    data = json.loads(json_content)

    if not isinstance(data, list):
        raise Exception(f"[{filepath}] ❌ Root element must be a list")

    seen_names: Set[str] = set()
    errors: List[str] = []

    for index, item in enumerate(data):
        if not isinstance(item, dict):
            raise Exception(f"[{filepath}] ❌ Index {index}: Item is not an object")

        task_name = item.get("task_name")

        if not task_name:
            raise Exception(f"[{filepath}] ❌ Index {index}: Missing or empty 'task_name'")

        if task_name in seen_names:
            raise Exception(f"[{filepath}] ❌ Index {index}: Duplicate task_name '{task_name}'")
        else:
            seen_names.add(task_name)

def main(argv: List[str] = None) -> int:
    parser = argparse.ArgumentParser(description="Decrypt and check GPG encrypted JSON files.")
    parser.add_argument('filenames', nargs='*', help='Encrypted filenames to check')
    args = parser.parse_args(argv)

    exit_code = 0

    for filename in args.filenames:
        try:
            content = get_decrypted_content(filename)
            validate_content(filename, content)
        except Exception as exception:
            print(exception)
            exit_code = 1

    return exit_code

if __name__ == "__main__":
    sys.exit(main())
