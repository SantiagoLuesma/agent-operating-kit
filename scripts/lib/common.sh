#!/usr/bin/env bash
# Shared helpers for kit scripts. Source from other scripts; do not execute.
# shellcheck shell=bash

kit_root() {
  local here
  here="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  printf '%s\n' "$here"
}

kit_log() {
  printf '%s\n' "$*"
}

kit_ok() {
  printf 'OK: %s\n' "$*"
}

kit_fail() {
  printf 'FAIL: %s\n' "$*" >&2
}

kit_warn() {
  printf 'WARN: %s\n' "$*" >&2
}

kit_info() {
  printf 'INFO: %s\n' "$*"
}

# Exit codes for kit scripts (contract)
# 0 = success
# 1 = check failed
# 2 = not configured (only where allowed; verify treats as failure if STRICT=1)
readonly KIT_EXIT_OK=0
readonly KIT_EXIT_FAIL=1
readonly KIT_EXIT_NOT_CONFIGURED=2

require_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    kit_ok "found $path"
    return 0
  fi
  kit_fail "missing required file: $path"
  return 1
}

require_dir() {
  local path="$1"
  if [[ -d "$path" ]]; then
    kit_ok "found dir $path"
    return 0
  fi
  kit_fail "missing required directory: $path"
  return 1
}

require_exec() {
  local path="$1"
  if [[ -f "$path" && -x "$path" ]]; then
    kit_ok "executable $path"
    return 0
  fi
  if [[ -f "$path" ]]; then
    kit_fail "not executable: $path"
    return 1
  fi
  kit_fail "missing script: $path"
  return 1
}

# Extract YAML frontmatter field (simple line match: name: value or description: >)
frontmatter_field() {
  local file="$1"
  local field="$2"
  awk -v field="$field" '
    BEGIN { in_fm=0; want=0; multi=0 }
    NR==1 && $0=="---" { in_fm=1; next }
    in_fm && $0=="---" { exit }
    in_fm && multi {
      if ($0 ~ /^[a-zA-Z0-9_-]+:/) { multi=0 }
      else {
        gsub(/^[ \t]+/, "")
        if (length($0)) print
        next
      }
    }
    in_fm && $0 ~ ("^" field ":") {
      rest=$0
      sub("^" field ":[ \t]*", "", rest)
      if (rest==">" || rest=="|") { multi=1; next }
      gsub(/^["'\'']|["'\'']$/, "", rest)
      print rest
      exit
    }
  ' "$file"
}

semver_ok() {
  local v="$1"
  [[ "$v" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][A-Za-z0-9.-]+)?$ ]]
}
