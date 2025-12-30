#!/usr/bin/env sh
set -euo pipefail

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if [ "$#" -gt 0 ]; then
  for app_name in "$@"; do
    plist_path="$script_dir/$app_name.plist"
    if [ ! -f "$plist_path" ]; then
      echo "missing plist: $plist_path" >&2
      exit 1
    fi
    defaults import -app "$app_name" "$plist_path"
  done
  exit 0
fi

find "$script_dir" -maxdepth 1 -type f -name '*.plist' -print0 |
  while IFS= read -r -d '' plist_path; do
    app_name="$(basename "$plist_path" .plist)"
    defaults import -app "$app_name" "$plist_path"
  done
