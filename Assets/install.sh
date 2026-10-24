#!/usr/bin/env bash
# Pasang perintah VSDB, VSdatabase, dan VSpm ke PATH
D="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
chmod +x "$D/VSDB" "$D/VSdatabase" "$D/VSpm" "$D/runtime.sh" "$D/VSPackage_manager" "$D"/execute/*
if [ -w /usr/local/bin ]; then T=/usr/local/bin; else T="$HOME/.local/bin"; mkdir -p "$T"; fi
for c in VSDB VSdatabase VSpm; do ln -sf "$D/$c" "$T/$c"; done
echo "Terpasang di $T: VSDB, VSdatabase, VSpm"
case ":$PATH:" in *":$T:"*) ;; *) echo "Tambahkan ke PATH: export PATH=\"$T:\$PATH\"" ;; esac
echo "Coba: VSDB -v"
