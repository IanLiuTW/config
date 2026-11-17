#!/usr/bin/env bash
# UserPromptSubmit hook: title the session "<repo>:<branch> - <latest prompt>".
# A title this hook did not set (from -n or /rename) is left alone. The last
# title set per session is kept in the cache dir to tell the two apart.
set -euo pipefail

input=$(cat)
session_id=$(jq -r '.session_id' <<<"$input")
cwd=$(jq -r '.cwd' <<<"$input")
current=$(jq -r '.session_title // ""' <<<"$input")
prompt=$(jq -r '.prompt // ""' <<<"$input" | tr -s '[:space:]' ' ' | sed 's/^ //; s/ $//')

[[ -n $prompt ]] || exit 0

state_dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude/session-title"
state="$state_dir/$session_id"
if [[ -n $current ]] && [[ $current != "$(cat "$state" 2>/dev/null)" ]]; then
  exit 0
fi

if common=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir 2>/dev/null); then
  repo=$(basename "$(dirname "$common")")
  branch=$(git -C "$cwd" branch --show-current)
  [[ -n $branch ]] || branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null || echo detached)
  where="$repo:$branch"
else
  where=$(basename "$cwd")
fi

max=60
(( ${#prompt} <= max )) || prompt="${prompt:0:max}..."
title="$where - $prompt"

mkdir -p "$state_dir"
printf '%s' "$title" >| "$state"
jq -n --arg t "$title" '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", sessionTitle: $t}}'
