#!/usr/bin/env bash
# VSDB Runtime — Virtual Stack Database
# Versi: 1.0.0 LTS
# Tanpa argumen: membuka terminal interaktif dengan prompt "VSDB>"

VSDB_RUNTIME_VERSION="1.0.0 LTS"
VSPM_VERSION_LABEL="1.2.2 LTS"
DATA_DIR="vsdb_data"

# ------------------------------------------------------------------
# Mesin parser/eksekutor .VSDB (awk)
# ------------------------------------------------------------------
IFS= read -r -d '' AWK_PROG <<'AWKEOF'
function err(msg) {
  printf "VSDB SyntaxError (%s, baris %d): %s\n", fname, NR, msg > "/dev/stderr"
  failed = 1
  exit 1
}
function trim(s) { sub(/^[ \t]+/, "", s); sub(/[ \t]+$/, "", s); return s }
function repeat(ch, n,   s, i) { s = ""; for (i = 0; i < n; i++) s = s ch; return s }
function is_sys(n,   l) {
  l = tolower(n)
  return (l == "virtual_stack_database_schema" || l == "stack_database_schema" || l == "virtual_schema")
}
function box(t,   i, nc, w, sep, hdr, row) {
  nc = tnf[t] + 1
  cname[1] = "title"; cval[1] = ttitle[t]
  for (i = 1; i <= tnf[t]; i++) { cname[i + 1] = tfname[t, i]; cval[i + 1] = tfval[t, i] }
  sep = "+"; hdr = "|"; row = "|"
  for (i = 1; i <= nc; i++) {
    w = length(cname[i]); if (length(cval[i]) > w) w = length(cval[i])
    sep = sep repeat("-", w + 2) "+"
    hdr = hdr sprintf(" %-" w "s |", cname[i])
    row = row sprintf(" %-" w "s |", cval[i])
  }
  print sep; print hdr; print sep; print row; print sep
}

BEGIN { state = 0; nt = 0; pending = 0; intbl = 0; req = 0 }

{
  line = $0
  sub(/\r$/, "", line)
  line = trim(line)
  if (line == "" || substr(line, 1, 1) == "#") next

  # --- kerangka wajib ---
  if (state == 0) {
    if (line != "@database") err("kode harus diawali dengan @database")
    state = 1; next
  }
  if (state == 1) {
    if (line != "input database-stack") err("setelah @database wajib: input database-stack")
    state = 2; next
  }
  if (state == 2) {
    if (line != "@stack") err("setelah input database-stack wajib: @stack")
    state = 3; next
  }
  if (state == 4) err("tidak boleh ada kode setelah @end database")

  if (line == "@end database") {
    if (intbl) err("tabel belum ditutup dengan @end table")
    state = 4; next
  }

  # --- di dalam tabel ---
  if (intbl) {
    if (line == "output-table") { tout[nt] = 1; next }
    if (line == "@end table")   { intbl = 0; next }
    if (line ~ /^input-data:/)  { ttitle[nt] = trim(substr(line, 12)); next }
    if (line ~ /^input-description-[A-Za-z0-9_]+:/) {
      p = index(line, ":")
      key = substr(line, 19, p - 19)
      val = trim(substr(line, p + 1))
      for (k = 1; k <= tnf[nt]; k++) if (tfname[nt, k] == key) err("kolom ganda: " key)
      tnf[nt]++; tfname[nt, tnf[nt]] = key; tfval[nt, tnf[nt]] = val
      next
    }
    err("perintah tidak dikenal di dalam tabel: " line)
  }

  # --- di luar tabel ---
  if (line == "input-table") { pending = 1; next }
  if (line == "@table" || line ~ /^@table[ \t]/) {
    if (!pending) err("@table harus didahului input-table")
    name = trim(substr(line, 7))
    if (name == "") err("@table butuh nama tabel")
    for (k = 1; k <= nt; k++) if (tname[k] == name) err("nama tabel ganda: " name)
    nt++; tname[nt] = name; ttitle[nt] = ""; tnf[nt] = 0; tout[nt] = 0
    pending = 0; intbl = 1
    next
  }
  if (line == "all input request-output") { req = 1; next }
  err("perintah tidak dikenal: " line)
}

END {
  if (failed) exit 1
  if (state != 4) {
    printf "VSDB SyntaxError (%s): file harus ditutup dengan @end database\n", fname > "/dev/stderr"
    exit 1
  }
  if (mode == "check") { print "OK: sintaks valid (" fname ", " nt " tabel)"; exit 0 }
  if (mode == "list") {
    print "Tabel di database '" dbname "' (" nt "):"
    for (k = 1; k <= nt; k++)
      printf "%2d. %s%s\n", k, tname[k], (is_sys(tname[k]) ? "  (bawaan)" : (ttitle[k] != "" ? "  - " ttitle[k] : ""))
    exit 0
  }
  if (mode == "show") {
    for (k = 1; k <= nt; k++) if (tname[k] == target) { print "[" tname[k] "]" (is_sys(tname[k]) ? " (bawaan)" : ""); box(k); exit 0 }
    print "Tabel tidak ditemukan: " target; exit 1
  }
  # mode run
  if (!req) { print "VSDB: database dimuat (" nt " tabel). Tidak ada request-output."; exit 0 }
  print "VSDB database-stack '" dbname "' — " nt " tabel"
  for (k = 1; k <= nt; k++) {
    if (!tout[k]) continue
    print ""
    print "[" tname[k] "]" (is_sys(tname[k]) ? " (bawaan)" : "")
    box(k)
  }
}
AWKEOF

engine() { # mode file [target]
  awk -v mode="$1" -v fname="$2" -v target="${3:-}" -v dbname="$(basename "$2" .VSDB | sed 's/\.vsdb$//')" "$AWK_PROG" "$2"
}

# ------------------------------------------------------------------
# Helper
# ------------------------------------------------------------------
trim() { local s="$1"; s="${s#"${s%%[![:space:]]*}"}"; s="${s%"${s##*[![:space:]]}"}"; printf '%s' "$s"; }
lower() { printf '%s' "$1" | tr 'A-Z' 'a-z'; }
clean_name() { trim "$(printf '%s' "$1" | tr -d "'\"")"; }
valid_db_name() { [[ "$1" =~ ^[A-Za-z0-9_-]+$ ]]; }
db_file() { printf '%s/%s.VSDB' "$DATA_DIR" "$1"; }
is_system_table() {
  case "$(lower "$1")" in
    virtual_stack_database_schema|stack_database_schema|virtual_schema) return 0 ;;
  esac
  return 1
}
confirm() { local a; printf '%s [y/n]: ' "$1"; IFS= read -r a || return 1; [ ! -t 0 ] && printf '%s\n' "$a"
  case "$a" in y|Y|yes|YES|ya|Ya|YA) return 0 ;; *) return 1 ;; esac; }

pkg_field() { sed -n "s/^[[:space:]]*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" package.json | head -n1; }

require_pkg() {
  if [ ! -f package.json ]; then
    echo "Error: package.json tidak ditemukan, database tidak bisa dibaca." >&2
    echo "Jalankan dulu: VSpm init" >&2
    exit 1
  fi
  PKG_NAME="$(pkg_field name)"; PKG_VERSION="$(pkg_field version)"; PKG_DB="$(pkg_field database)"
  if [ -z "$PKG_DB" ]; then
    echo "Error: package.json tidak punya field \"database\". Jalankan lagi: VSpm init" >&2
    exit 1
  fi
}

create_db_file() { # nama
  local path d; path="$(db_file "$1")"; d="$(date +%Y-%m-%d)"
  mkdir -p "$DATA_DIR"
  cat > "$path" <<DBEOF
@database
input database-stack

@stack

input-table
@table Virtual_stack_database_schema
input-data:VSDB
input-description-engine:VSDB Runtime $VSDB_RUNTIME_VERSION
input-description-format:.VSDB
input-description-package_manager:VSpm $VSPM_VERSION_LABEL
output-table
@end table

input-table
@table Stack_database_schema
input-data:database-stack
input-description-wajib:@database, input database-stack, @stack, @end database
input-description-tabel_bawaan:3
output-table
@end table

input-table
@table Virtual_schema
input-data:$1
input-description-dibuat:$d
input-description-file:$path
output-table
@end table

all input request-output

@end database
DBEOF
}

# ------------------------------------------------------------------
# Perintah non-interaktif
# ------------------------------------------------------------------
usage() {
  cat <<USG
VSDB Runtime v${VSDB_RUNTIME_VERSION}

Pemakaian:
  VSdatabase                  Buka terminal VSDB>
  VSdatabase <file|nama_db>   Jalankan file .VSDB atau database
  VSdatabase --check <file>   Cek sintaks saja
  VSdatabase -v | --version   Versi runtime
  VSdatabase -h | --help      Bantuan

Wajib ada package.json di folder ini (buat dengan: VSpm init).
USG
}

case "${1:-}" in
  -v|--version) echo "VSDB Runtime v${VSDB_RUNTIME_VERSION}"; exit 0 ;;
  -h|--help)    usage; exit 0 ;;
  --create-db)
    require_pkg
    n="$(clean_name "${2:-}")"
    valid_db_name "$n" || { echo "Error: nama database tidak valid." >&2; exit 2; }
    if [ -f "$(db_file "$n")" ]; then echo "Database '$n' sudah ada."; exit 0; fi
    create_db_file "$n"
    echo "Database '$n' dibuat dengan 3 tabel bawaan di $(db_file "$n")."
    exit 0 ;;
  --check)
    require_pkg
    [ -f "${2:-}" ] || { echo "VSDB Error: file tidak ditemukan: ${2:-<kosong>}" >&2; exit 2; }
    engine check "$2"; exit $? ;;
  "") ;;
  *)
    require_pkg
    if [ -f "$1" ]; then
      case "$1" in *.VSDB|*.vsdb) ;; *) echo "VSDB Error: ekstensi file harus .VSDB" >&2; exit 2 ;; esac
      engine run "$1"; exit $?
    elif [ -f "$(db_file "$(clean_name "$1")")" ]; then
      engine run "$(db_file "$(clean_name "$1")")"; exit $?
    else
      echo "VSDB Error: file atau database tidak ditemukan: $1" >&2; exit 2
    fi ;;
esac

# ------------------------------------------------------------------
# Terminal interaktif VSDB>
# ------------------------------------------------------------------
require_pkg
CUR_DB=""

read_line() { # prompt -> REPLY_LINE
  if [ -t 0 ]; then
    IFS= read -e -r -p "$1" REPLY_LINE || return 1
  else
    printf '%s' "$1"
    IFS= read -r REPLY_LINE || return 1
    printf '%s\n' "$REPLY_LINE"
  fi
  REPLY_LINE="${REPLY_LINE%$'\r'}"
  return 0
}

need_db() {
  if [ -z "$CUR_DB" ]; then
    echo "Perintah ini hanya bisa dipakai di dalam database."
    echo "Buka dulu dengan: use open database <nama>"
    return 1
  fi
  return 0
}

show_help() {
  cat <<HLP
Di luar database:
  create database <nama>         Buat database baru (otomatis ada 3 tabel bawaan)
  use open database <nama>       Buka database
  rm database <nama>             Hapus database
  check database                 Lihat daftar database
  help | clear | exit

Di dalam database:
  create data table              Buat tabel (isi Name, Title, Description-<kolom>)
  rm table <nama_table>          Hapus tabel
  check table [nama_table]       Lihat daftar tabel, atau isi satu tabel
  run [nama_database]            Jalankan database
  close                          Keluar dari database
HLP
}

cmd_create_db() {
  local n; n="$(clean_name "$1")"
  [ -z "$n" ] && { echo "Pakai: create database <nama>"; return; }
  valid_db_name "$n" || { echo "Nama database hanya boleh huruf, angka, _ dan -."; return; }
  [ -f "$(db_file "$n")" ] && { echo "Database '$n' sudah ada."; return; }
  create_db_file "$n"
  echo "Database '$n' dibuat. Tabel bawaan: Virtual_stack_database_schema, Stack_database_schema, Virtual_schema"
  echo "Buka dengan: use open database $n"
}

cmd_use_db() {
  local n f c; n="$(clean_name "$1")"
  [ -z "$n" ] && { echo "Pakai: use open database <nama>"; return; }
  f="$(db_file "$n")"
  [ -f "$f" ] || { echo "Database '$n' tidak ditemukan. Buat dengan: create database $n"; return; }
  if ! engine check "$f" >/dev/null; then echo "Database '$n' rusak (sintaks tidak valid)."; return; fi
  CUR_DB="$n"
  c="$(grep -c '^@table ' "$f")"
  echo "Database '$n' dibuka ($c tabel)."
}

cmd_rm_db() {
  local n f; n="$(clean_name "$1")"
  [ -z "$n" ] && { echo "Pakai: rm database <nama>"; return; }
  f="$(db_file "$n")"
  [ -f "$f" ] || { echo "Database '$n' tidak ditemukan."; return; }
  if confirm "Hapus database '$n' beserta semua tabelnya?"; then
    rm -f "$f"
    [ "$CUR_DB" = "$n" ] && CUR_DB=""
    echo "Database '$n' dihapus."
    [ "$n" = "$PKG_DB" ] && echo "Catatan: database ini terdaftar di package.json. Buat lagi dengan: create database $n"
  else
    echo "Dibatalkan."
  fi
}

cmd_check_db() {
  local f n found=0
  for f in "$DATA_DIR"/*.VSDB; do
    [ -e "$f" ] || continue
    n="$(basename "$f" .VSDB)"; found=1
    if [ "$n" = "$PKG_DB" ]; then echo "  $n  (dari package.json)"; else echo "  $n"; fi
  done
  [ $found -eq 0 ] && echo "(belum ada database)"
}

cmd_create_table() {
  local f tname="" ttitle="" ln key val lkey col i dup tmp
  local cols=() cvals=()
  f="$(db_file "$CUR_DB")"
  echo "Isi data tabel, satu baris satu isian:"
  echo "  Name:<nama tabel>   Title:<judul>   Description-<kolom>:<isi>"
  echo "Baris kosong = selesai."
  while true; do
    read_line "  > " || break
    ln="$(trim "$REPLY_LINE")"
    [ -z "$ln" ] && break
    case "$ln" in *:*) ;; *) echo "  Format salah, pakai kunci:isi  ($ln)"; continue ;; esac
    key="$(trim "${ln%%:*}")"; val="$(trim "${ln#*:}")"; lkey="$(lower "$key")"
    case "$lkey" in
      name)  tname="$val" ;;
      title) ttitle="$val" ;;
      description-*|descriotion-*|descripton-*)
        col="${lkey#*-}"
        if ! [[ "$col" =~ ^[A-Za-z0-9_]+$ ]]; then
          echo "  Nama kolom hanya boleh huruf, angka, dan _  ($col)"; continue
        fi
        dup=-1
        for i in "${!cols[@]}"; do [ "${cols[$i]}" = "$col" ] && dup=$i; done
        if [ $dup -ge 0 ]; then cvals[$dup]="$val"; else cols+=("$col"); cvals+=("$val"); fi ;;
      *) echo "  Kunci tidak dikenal: $key (pakai Name, Title, Description-<kolom>)" ;;
    esac
  done
  [ -z "$tname" ] && { echo "Gagal: Name wajib diisi. Tabel tidak dibuat."; return; }
  if is_system_table "$tname"; then echo "Gagal: '$tname' adalah nama tabel bawaan."; return; fi
  if grep -Fxq "@table $tname" "$f"; then echo "Gagal: tabel '$tname' sudah ada."; return; fi
  grep -q '^all input request-output' "$f" || { echo "Gagal: file database rusak (tidak ada 'all input request-output')."; return; }

  tmp="$(mktemp)"
  {
    echo "input-table"
    echo "@table $tname"
    echo "input-data:$ttitle"
    for i in "${!cols[@]}"; do echo "input-description-${cols[$i]}:${cvals[$i]}"; done
    echo "output-table"
    echo "@end table"
    echo
  } > "$tmp"
  cp "$f" "$f.bak"
  awk -v blk="$tmp" '/^all input request-output[[:space:]]*$/ { while ((getline l < blk) > 0) print l; close(blk) } { print }' "$f.bak" > "$f"
  rm -f "$tmp"
  if engine check "$f" >/dev/null 2>&1; then
    rm -f "$f.bak"
    echo "Tabel '$tname' dibuat."
  else
    mv "$f.bak" "$f"
    echo "Gagal: isian menghasilkan sintaks tidak valid. Tabel tidak dibuat."
  fi
}

cmd_rm_table() {
  local f n; n="$(trim "$1")"; f="$(db_file "$CUR_DB")"
  [ -z "$n" ] && { echo "Pakai: rm table <nama_table>"; return; }
  if is_system_table "$n"; then echo "Tabel bawaan tidak bisa dihapus: $n"; return; fi
  grep -Fxq "@table $n" "$f" || { echo "Tabel '$n' tidak ditemukan. Lihat dengan: check table"; return; }
  if confirm "Hapus tabel '$n'?"; then
    cp "$f" "$f.bak"
    awk -v target="$n" '
      function trim(s){sub(/^[ \t]+/,"",s);sub(/[ \t]+$/,"",s);return s}
      {
        sub(/\r$/, "")
        if (skipblank && $0 ~ /^[ \t]*$/) { skipblank = 0; next }
        skipblank = 0
        if (!inblk && $0 ~ /^input-table[ \t]*$/) { inblk = 1; buf = $0; drop = 0; next }
        if (inblk) {
          buf = buf "\n" $0
          if ($0 ~ /^@table([ \t]|$)/ && trim(substr($0, 7)) == target) drop = 1
          if ($0 ~ /^@end table[ \t]*$/) { inblk = 0; if (drop) skipblank = 1; else print buf; buf = "" }
          next
        }
        print
      }' "$f.bak" > "$f"
    if engine check "$f" >/dev/null 2>&1; then rm -f "$f.bak"; echo "Tabel '$n' dihapus."
    else mv "$f.bak" "$f"; echo "Gagal menghapus tabel; file dikembalikan."; fi
  else
    echo "Dibatalkan."
  fi
}

cmd_check_table() {
  local f n; n="$(trim "$1")"; f="$(db_file "$CUR_DB")"
  if [ -z "$n" ]; then engine list "$f"
  elif grep -Fxq "@table $n" "$f"; then engine show "$f" "$n"
  else echo "Tabel '$n' tidak ditemukan."; fi
}

cmd_run() {
  local n f; n="$(clean_name "$1")"; [ -z "$n" ] && n="$CUR_DB"
  f="$(db_file "$n")"
  [ -f "$f" ] || { echo "Database '$n' tidak ditemukan."; return; }
  engine run "$f"
}

echo "VSDB Runtime v${VSDB_RUNTIME_VERSION}"
echo "Proyek: ${PKG_NAME:-?} v${PKG_VERSION:-?}  |  database dari package.json: ${PKG_DB}"
[ -f "$(db_file "$PKG_DB")" ] || echo "Peringatan: database '${PKG_DB}' belum ada. Buat dengan: create database ${PKG_DB}"
echo "Ketik help untuk daftar perintah, exit untuk keluar."

while true; do
  if [ -n "$CUR_DB" ]; then PROMPT="VSDB:$CUR_DB> "; else PROMPT="VSDB> "; fi
  read_line "$PROMPT" || { echo; break; }
  line="$(trim "$REPLY_LINE")"
  [ -z "$line" ] && continue
  read -ra W <<< "$line"
  read -ra L <<< "$(lower "$line")"
  c1="${L[0]}"; c2="${L[1]:-}"; c3="${L[2]:-}"

  case "$c1" in
    help|"?") show_help ;;
    exit|quit) break ;;
    clear) clear ;;
    close) need_db && { echo "Database '$CUR_DB' ditutup."; CUR_DB=""; } ;;
    create)
      if [ "$c2" = "database" ]; then cmd_create_db "${W[*]:2}"
      elif [ "$c2 $c3" = "data table" ]; then need_db && cmd_create_table
      else echo "Perintah tidak dikenal. Ketik help."; fi ;;
    use)
      if [ "$c2 $c3" = "open database" ]; then cmd_use_db "${W[*]:3}"
      elif [ "$c2" = "database" ]; then cmd_use_db "${W[*]:2}"
      else echo "Pakai: use open database <nama>"; fi ;;
    rm)
      if [ "$c2" = "database" ]; then cmd_rm_db "${W[*]:2}"
      elif [ "$c2" = "table" ]; then need_db && cmd_rm_table "${W[*]:2}"
      else echo "Perintah tidak dikenal. Ketik help."; fi ;;
    check)
      if [ "$c2" = "table" ]; then need_db && cmd_check_table "${W[*]:2}"
      elif [ "$c2" = "database" ]; then cmd_check_db
      else echo "Perintah tidak dikenal. Ketik help."; fi ;;
    run) need_db && cmd_run "${W[*]:1}" ;;
    *) echo "Perintah tidak dikenal: ${W[0]}. Ketik help." ;;
  esac
done
