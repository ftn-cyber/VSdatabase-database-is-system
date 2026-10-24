#!/usr/bin/env bash
# VSDB installer
#
# Pasang langsung lewat curl (clone repo GitHub + chmod +x otomatis):
#   curl -fsSL https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/install.sh | bash
#
# Atau dari folder hasil clone:
#   bash install.sh
#
# Variabel opsional:
#   VSDB_HOME    folder tujuan clone (default: ~/.vsdb)
#   VSDB_BIN     folder untuk perintah VSDB, VSdatabase, VSpm
#   VSDB_REPO    URL repo
#   VSDB_BRANCH  branch (default: main)

REPO_URL="${VSDB_REPO:-https://github.com/ftn-cyber/VSdatabase-database-is-system.git}"
BRANCH="${VSDB_BRANCH:-main}"
INSTALL_DIR="${VSDB_HOME:-$HOME/.vsdb}"

say() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

fetch_repo() {
  export GIT_TERMINAL_PROMPT=0
  if command -v git >/dev/null 2>&1; then
    if [ -d "$INSTALL_DIR/.git" ]; then
      say "Memperbarui $INSTALL_DIR ..."
      git -C "$INSTALL_DIR" pull --ff-only -q origin "$BRANCH" \
        || die "gagal git pull di $INSTALL_DIR (ada perubahan lokal?)."
    else
      [ -e "$INSTALL_DIR" ] && [ -n "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ] \
        && die "$INSTALL_DIR sudah ada dan bukan hasil clone. Pindahkan dulu atau set VSDB_HOME ke folder lain."
      say "Clone $REPO_URL ..."
      git clone --depth 1 -q -b "$BRANCH" "$REPO_URL" "$INSTALL_DIR" \
        || die "gagal clone. Pastikan repo publik dan branch '$BRANCH' ada."
    fi
  else
    command -v curl >/dev/null 2>&1 && command -v tar >/dev/null 2>&1 \
      || die "butuh git, atau curl dan tar."
    say "git tidak ada, mengunduh arsip ..."
    mkdir -p "$INSTALL_DIR"
    curl -fsSL "${REPO_URL%.git}/archive/refs/heads/$BRANCH.tar.gz" \
      | tar -xz -C "$INSTALL_DIR" --strip-components=1 \
      || die "gagal mengunduh arsip repo."
  fi
}

# chmod +x semua file skrip (file berawalan #!) di dalam folder
make_exec() {
  local f n=0
  while IFS= read -r f; do
    if [ "$(head -c 2 "$f" 2>/dev/null)" = "#!" ]; then chmod +x "$f" && n=$((n + 1)); fi
  done < <(find "$1" -type f -not -path '*/.git/*')
  say "chmod +x: $n file skrip."
}

main() {
  local SELF="" TOOL BIN_DIR c rc

  if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    SELF="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  fi

  if [ -n "$SELF" ] && [ -f "$SELF/VSdatabase" ]; then
    TOOL="$SELF"; ROOT="$SELF"
    say "Memakai folder lokal: $TOOL"
  else
    fetch_repo
    ROOT="$INSTALL_DIR"
    TOOL="$(find "$INSTALL_DIR" -maxdepth 3 -type f -name VSdatabase -not -path '*/.git/*' | head -n1)"
    [ -n "$TOOL" ] || die "file VSdatabase tidak ditemukan di repo."
    TOOL="$(dirname "$TOOL")"
  fi

  make_exec "$ROOT"

  BIN_DIR="${VSDB_BIN:-}"
  if [ -z "$BIN_DIR" ]; then
    if [ -w /usr/local/bin ]; then BIN_DIR=/usr/local/bin; else BIN_DIR="$HOME/.local/bin"; fi
  fi
  mkdir -p "$BIN_DIR" || die "tidak bisa membuat $BIN_DIR"
  for c in VSDB VSdatabase VSpm; do
    [ -f "$TOOL/$c" ] && ln -sf "$TOOL/$c" "$BIN_DIR/$c"
  done
  say "Perintah terpasang di $BIN_DIR: VSDB, VSdatabase, VSpm"

  case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *)
      case "${SHELL:-}" in */zsh) rc="$HOME/.zshrc" ;; *) rc="$HOME/.bashrc" ;; esac
      if ! grep -qs "# vsdb-path" "$rc" 2>/dev/null; then
        printf '\nexport PATH="%s:$PATH"  # vsdb-path\n' "$BIN_DIR" >> "$rc"
        say "PATH ditambahkan ke $rc. Buka terminal baru atau jalankan: source $rc"
      fi
      export PATH="$BIN_DIR:$PATH" ;;
  esac

  say ""
  bash "$TOOL/VSDB" -v || die "instalasi selesai tapi VSDB -v gagal dijalankan."
  say ""
  say "Selesai. Langkah berikutnya:"
  say "  VSpm init"
  say "  VSdatabase"
}

main "$@"
