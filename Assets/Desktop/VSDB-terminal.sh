#!/usr/bin/env bash
# ======================================================================
# VSDB-terminal.sh — TERMINAL VSDB (dipakai oleh VSDB.desktop)
# ----------------------------------------------------------------------
# Fungsi  : membuka satu terminal yang sudah berisi semuanya: runtime,
#           package manager (VSpm), dan perintah VSDB, langsung siap pakai.
# Alur    : 1) masuk ke folder kerja (default: ~/VSDB-project)
#           2) jika belum ada package.json, jalankan formulir VSpm init
#           3) otomatis masuk terminal VSDB> (VSdatabase)
#           4) setelah keluar dari VSDB>, kamu tetap di terminal ini dan
#              bisa memakai VSdatabase, VSpm, dan VSDB kapan saja
# Contoh  : bash VSDB-terminal.sh
#           VSDB_WORKDIR=/jalur/lain bash VSDB-terminal.sh
# ======================================================================

# --- Cari lokasi asli file ini (ikuti symlink) -------------------------
SOURCE="${BASH_SOURCE[0]:-$0}"
while [ -h "$SOURCE" ]; do
  D="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$D/$SOURCE"
done
HOME_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
WORKDIR="${VSDB_WORKDIR:-$HOME/VSDB-project}"

# --- Tampilkan error lalu tahan jendela agar pesannya sempat terbaca ----
stop() {
  printf '\nError: %s\n' "$1" >&2
  read -r -p "Tekan Enter untuk menutup... " _
  exit 1
}

# --- Cari skrip di folder ini, folder induk, atau 3 tingkat di bawahnya --
find_file() {
  local n d f
  for n in "$@"; do
    for d in "$HOME_DIR" "$HOME_DIR/.."; do
      [ -f "$d/$n" ] && { printf '%s' "$d/$n"; return 0; }
    done
  done
  for n in "$@"; do
    f="$(find "$HOME_DIR/.." -maxdepth 3 -type f -name "$n" -not -path '*/.git/*' 2>/dev/null | head -n1)"
    [ -n "$f" ] && { printf '%s' "$f"; return 0; }
  done
  return 1
}

RT="$(find_file VSdatabase.sh)" || stop "VSdatabase.sh tidak ditemukan. Jalankan ulang perintah curl pemasangan."
PM="$(find_file VSpm.sh)"       || stop "VSpm.sh tidak ditemukan. Jalankan ulang perintah curl pemasangan."
DB="$(find_file VSDB.sh)"       || stop "VSDB.sh tidak ditemukan. Jalankan ulang perintah curl pemasangan."

# --- Siapkan folder kerja ------------------------------------------------
mkdir -p "$WORKDIR" || stop "tidak bisa membuat folder kerja: $WORKDIR"
cd "$WORKDIR"       || stop "tidak bisa masuk ke folder kerja: $WORKDIR"

# --- Tulis file konfigurasi sementara untuk shell interaktif --------------
RC="$(mktemp)"
{
  echo 'rm -f "${BASH_SOURCE[0]}"'                      # hapus file ini setelah dibaca
  echo '[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"'     # tetap pakai konfigurasi bash biasa
  printf 'VSdatabase() { bash %q "$@"; }\n' "$RT"        # perintah runtime
  printf 'VSpm() { bash %q "$@"; }\n' "$PM"              # perintah package manager
  printf 'VSDB() { bash %q "$@"; }\n' "$DB"              # perintah bantu
  cat <<'RCEOF'
export PS1='\[\e[1;36m\]VSDB\[\e[0m\]:\w\$ '
vsdb-help() {
  cat <<'H'
Perintah yang siap dipakai:
  VSpm init          Formulir package.json (wajib sebelum memakai database)
  VSdatabase         Masuk terminal VSDB>
  VSdatabase file    Jalankan file .VSDB
  VSpm install nama  Tambah dependency
  VSDB -v            Versi runtime dan package manager
  vsdb-help          Tampilkan bantuan ini
H
}
[ -t 1 ] && clear
VSDB -v
echo "Folder kerja: $PWD"
echo
vsdb-help
echo
if [ ! -f package.json ]; then
  echo "package.json belum ada. Isi formulir dulu:"
  VSpm init
  echo
fi
[ -f package.json ] && VSdatabase
echo
echo "Kembali ke terminal VSDB. Ketik VSdatabase untuk masuk lagi, atau exit untuk menutup."
RCEOF
} > "$RC"

# --- Ganti proses ini dengan shell interaktif -----------------------------
exec bash --rcfile "$RC" -i
