<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>VSDB — Virtual Stack Database</title>
<meta name="description" content="Dokumentasi VSDB (Virtual Stack Database) dan VSpm (Virtual Stack Package Manager).">
<link rel="icon" href="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827554896.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@500;800&family=JetBrains+Mono:wght@400;600&family=Source+Serif+4:wght@400;600&display=swap" rel="stylesheet">
<style>
:root{--bg:#F3F8FC;--panel:#fff;--ink:#0B2A6F;--text:#1B2B3F;--mute:#5B6E82;--line:#D3E0EB;--a:#1E6FD9;--a2:#10B5B5;--code:#0E1C30;--codeink:#DCE8F5;--lock:#F2C14E;--lockink:#3A2A00;--chip:#E2EEFB;--hl:#FFF1B8}
[data-theme=dark]{--bg:#09131F;--panel:#0F1D2E;--ink:#A9C8FF;--text:#D5E1ED;--mute:#8AA1B6;--line:#21364B;--a:#6FA8FF;--a2:#3DD6D0;--code:#050E18;--chip:#16314F;--hl:#5A4A10}
*{box-sizing:border-box}
@media(prefers-reduced-motion:no-preference){html{scroll-behavior:smooth}}
html{scroll-padding-top:20px}
body{margin:0;background:var(--bg);color:var(--text);font:400 1.02rem/1.7 "Source Serif 4",Georgia,serif}
h1,h2,h3,.top,.chips span,button,.ng b{font-family:"Bricolage Grotesque","Segoe UI",sans-serif}
code,pre,.sub,input{font-family:"JetBrains Mono",ui-monospace,Menlo,monospace}
a{color:var(--a)}
:focus-visible{outline:3px solid var(--a);outline-offset:2px}
.shell{display:grid;grid-template-columns:300px minmax(0,1fr)}
aside{position:sticky;top:0;height:100vh;overflow:auto;padding:18px 16px 28px;background:var(--panel);border-right:1px solid var(--line)}
.brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--ink);font:800 1.35rem "Bricolage Grotesque",sans-serif;margin-bottom:14px}
.brand .ic{width:40px;height:40px;overflow:hidden;border-radius:6px;background:#fff;position:relative;flex:none;border:1px solid var(--line)}
.brand .ic img{position:absolute;width:150%;max-width:none;left:-27%;top:-5%}
.tools{display:flex;gap:8px;margin-bottom:12px}
input[type=search]{flex:1;min-width:0;padding:8px 10px;border:1px solid var(--line);border-radius:6px;background:var(--bg);color:var(--text);font-size:.85rem}
button{cursor:pointer;border:1px solid var(--line);background:var(--bg);color:var(--ink);border-radius:6px;padding:7px 11px;font-weight:600;font-size:.82rem}
button:hover{border-color:var(--a)}
.ng{margin-bottom:4px}
.top{display:flex;gap:9px;align-items:baseline;padding:6px 8px;border-radius:6px;color:var(--text);text-decoration:none;font-weight:600;font-size:.93rem}
.top b{color:var(--mute);font-size:.78rem;min-width:1.2em}
.top:hover,.top.on{background:var(--chip);color:var(--ink)}
.sub{display:block;padding:3px 8px 3px 36px;color:var(--mute);text-decoration:none;font-size:.72rem;line-height:1.5}
.sub:hover{color:var(--a)}
.none{display:none;color:var(--mute);font-size:.85rem;padding:8px}
main{padding:0 clamp(18px,4vw,56px) 60px;max-width:1000px;width:100%}
.topbar{display:none}
.hero{padding:clamp(28px,6vw,60px) 0 18px;display:grid;grid-template-columns:1.1fr 1fr;gap:28px;align-items:center}
.hero h1{font-size:clamp(3rem,9vw,5.2rem);font-weight:800;letter-spacing:-.035em;line-height:1;margin:0;color:var(--ink)}
.tag{font-size:1.15rem;color:var(--mute);margin:.7rem 0 1rem;max-width:34ch}
.chips{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:16px}
.chips span{background:var(--chip);color:var(--ink);border-radius:999px;padding:4px 13px;font-size:.82rem;font-weight:600}
.cmd{display:flex;gap:8px;align-items:center;background:var(--code);color:var(--codeink);border-radius:8px;padding:8px 8px 8px 14px;max-width:100%}
.cmd code{font-size:.78rem;white-space:nowrap;overflow-x:auto;min-width:0}
.logos{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.logos a{background:#fff;border:1px solid var(--line);border-radius:10px;padding:10px;display:block;text-align:center;text-decoration:none}
.logos a:hover{border-color:var(--a)}
.logos img{width:100%;height:auto;display:block;border-radius:6px}
.logos small{display:block;color:#4D5F6D;font:600 .74rem "Bricolage Grotesque",sans-serif;margin-top:6px}
.intro{margin-top:18px}
section{margin-top:52px}
h2{font-size:1.8rem;font-weight:800;line-height:1.1;margin:0 0 .8rem;color:var(--ink);letter-spacing:-.015em;position:relative;padding-bottom:.45rem;border-bottom:2px solid var(--line)}
h3{font-size:1.15rem;margin:1.7rem 0 .5rem;color:var(--ink)}
.anc{position:absolute;left:-1.1em;color:var(--line);text-decoration:none;opacity:0}
h2:hover .anc{opacity:1;color:var(--a)}
p{max-width:68ch}
:not(pre)>code{background:var(--chip);color:var(--ink);padding:1px 6px;border-radius:4px;font-size:.84em}
.cb{position:relative;margin:14px 0}
pre{margin:0;background:var(--code);color:var(--codeink);border-radius:8px;padding:16px 18px;overflow-x:auto;font-size:.82rem;line-height:1.7}
.cb .cp{position:absolute;top:8px;right:8px;background:#1b2e47;color:#cfe0f5;border-color:#2c4666;padding:3px 9px;font-size:.72rem;opacity:.85}
.lock{background:var(--lock);color:var(--lockink);padding:1px 5px;border-radius:3px;font-weight:600}
.pr{color:var(--a2);font-weight:600}
.tw{overflow-x:auto;margin:14px 0;border:1px solid var(--line);border-radius:8px;background:var(--panel)}
table{border-collapse:collapse;width:100%;font-size:.92rem}
th,td{text-align:left;padding:9px 13px;border-bottom:1px solid var(--line);vertical-align:top}
th{font-size:.85rem;background:var(--chip);color:var(--ink)}
tr:last-child td{border-bottom:0}
li{margin:.25rem 0}
.tocgrid ol{columns:2;column-gap:36px;padding-left:1.4em}
.tocgrid li{break-inside:avoid}
.logo-row{float:right;margin:0 0 12px 18px}
.sec-logo{width:190px;max-width:42vw;background:#fff;border:1px solid var(--line);border-radius:10px;padding:6px;display:block}
mark{background:var(--hl);color:inherit;border-radius:2px}
.empty{display:none;padding:30px;text-align:center;color:var(--mute)}
footer{margin-top:64px;padding-top:22px;border-top:1px solid var(--line);display:flex;gap:18px;align-items:center;flex-wrap:wrap;color:var(--mute);font-size:.9rem}
footer img{height:54px;width:auto;background:#fff;border-radius:6px;border:1px solid var(--line);padding:3px}
#up{position:fixed;right:18px;bottom:18px;display:none;box-shadow:0 2px 10px rgba(0,0,0,.2)}
@media(max-width:900px){
 .shell{display:block}
 aside{position:fixed;inset:0 auto 0 0;width:290px;max-width:86vw;height:100%;z-index:30;transform:translateX(-102%);transition:transform .2s}
 aside.open{transform:none;box-shadow:6px 0 24px rgba(0,0,0,.3)}
 .topbar{display:flex;position:sticky;top:0;z-index:20;align-items:center;gap:10px;padding:10px 16px;background:var(--panel);border-bottom:1px solid var(--line)}
 .topbar .brand{margin:0;flex:1;font-size:1.15rem}
 .hero{grid-template-columns:1fr}
 .tocgrid ol{columns:1}
 .anc{display:none}
 .logo-row{float:none;margin:0 0 12px}
}
@media(max-width:480px){.logos{grid-template-columns:1fr 1fr;gap:8px}.cmd code{font-size:.74rem}}
@media print{aside,.topbar,#up,.cp{display:none}.shell{display:block}pre{white-space:pre-wrap}}
</style>
</head>
<body>
<div class="topbar">
  <a class="brand" href="#top"><span class="ic"><img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827554896.png" alt=""></span>VSDB</a>
  <button type="button" id="menu" aria-label="Buka daftar isi">Daftar isi</button>
  <button type="button" class="theme" aria-label="Ganti tema">Tema</button>
</div>
<div class="shell">
<aside id="side" aria-label="Daftar isi">
  <a class="brand" href="#top"><span class="ic"><img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827554896.png" alt=""></span>VSDB</a>
  <div class="tools">
    <input type="search" id="q" placeholder="Cari di dokumen" aria-label="Cari di dokumen">
    <button type="button" class="theme" aria-label="Ganti tema">Tema</button>
  </div>
  <nav id="nav"><div class="ng"><a class="top" href="#fitur"><b>1</b>Fitur</a></div><div class="ng"><a class="top" href="#syarat"><b>2</b>Syarat</a></div><div class="ng"><a class="top" href="#pemasangan"><b>3</b>Pemasangan</a><a class="sub" href="#lewat-curl-otomatis-clone-dari-github">Lewat curl (otomatis clone dari GitHub)</a><a class="sub" href="#dari-folder-hasil-clone">Dari folder hasil clone</a></div><div class="ng"><a class="top" href="#mulai-cepat"><b>4</b>Mulai cepat</a></div><div class="ng"><a class="top" href="#vspm-package-manager"><b>5</b>VSpm: package manager</a><a class="sub" href="#vspm-init-wajib-dijalankan-lebih-dulu">VSpm init (wajib dijalankan lebih dulu)</a><a class="sub" href="#perintah-vspm-lainnya">Perintah VSpm lainnya</a></div><div class="ng"><a class="top" href="#terminal-vsdb"><b>6</b>Terminal VSDB&gt;</a><a class="sub" href="#di-luar-database">Di luar database</a><a class="sub" href="#di-dalam-database">Di dalam database</a><a class="sub" href="#membuat-tabel">Membuat tabel</a><a class="sub" href="#menghapus-tabel">Menghapus tabel</a></div><div class="ng"><a class="top" href="#tabel-bawaan"><b>7</b>Tabel bawaan</a></div><div class="ng"><a class="top" href="#format-file-vsdb"><b>8</b>Format file .VSDB</a><a class="sub" href="#kerangka-wajib-tidak-boleh-diganti">Kerangka wajib (tidak boleh diganti)</a><a class="sub" href="#isi-stack">Isi stack</a><a class="sub" href="#contoh-databasevsdb">Contoh (database.VSDB)</a><a class="sub" href="#menjalankan-file-langsung">Menjalankan file langsung</a></div><div class="ng"><a class="top" href="#perintah-execute-dan-versi"><b>9</b>Perintah execute dan versi</a></div><div class="ng"><a class="top" href="#struktur-folder"><b>10</b>Struktur folder</a></div><div class="ng"><a class="top" href="#pesan-error-dan-solusinya"><b>11</b>Pesan error dan solusinya</a></div><div class="ng"><a class="top" href="#batasan"><b>12</b>Batasan</a></div><div class="none" id="none">Tidak ada hasil.</div></nav>
</aside>
<main id="top">
  <header class="hero">
    <div>
      <h1>VSDB</h1>
      <p class="tag">Virtual Stack Database. Database berbasis file .VSDB dengan terminal VSDB&gt; dan package manager VSpm.</p>
      <div class="chips"><span>Runtime 1.0.0 LTS</span><span>VSpm 1.2.2 LTS</span></div>
      <div class="cmd"><code>curl -fsSL https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/refs/heads/main/Assets/install.sh | bash</code><button class="cp" type="button" data-copy="curl -fsSL https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/refs/heads/main/Assets/install.sh | bash">Salin</button></div>
    </div>
    <div class="logos">
      <a href="#terminal-vsdb"><img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827554896.png" alt="Logo VSdatabase (virtual stack database)"><small>VSdatabase</small></a>
      <a href="#vspm-package-manager"><img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827545920.png" alt="Logo VSpm (virtual stack package manager)"><small>VSpm</small></a>
    </div>
  </header>
  <div id="content"><div class="intro"><p>VSDB (Virtual Stack Database) adalah database berbasis file <code>.VSDB</code> yang dijalankan lewat terminal interaktif berprompt <code>VSDB&gt;</code>. Datanya ditulis dalam satu "stack" dengan sintaks sederhana, dan seluruh alatnya (runtime, package manager, perintah execute) berupa shell script.</p><div class="tw"><table><thead><tr><th>Komponen</th><th>Perintah</th><th>Versi</th></tr></thead><tbody><tr><td>Runtime (<code>runtime.sh</code>)</td><td><code>VSdatabase</code></td><td>1.0.0 LTS</td></tr><tr><td>Package manager (<code>VSPackage_manager</code>)</td><td><code>VSpm</code></td><td>1.2.2 LTS</td></tr></tbody></table></div><p>Panduan perancangan lengkap ada di <a href="../PRD.md">PRD.md</a>.</p></div><section id="daftar-isi" class="tocgrid"><h2><a class="anc" href="#daftar-isi" aria-label="Tautan bagian">#</a>Daftar isi</h2><ol><li><a href="#fitur">Fitur</a></li><li><a href="#syarat">Syarat</a></li><li><a href="#pemasangan">Pemasangan</a></li><li><a href="#mulai-cepat">Mulai cepat</a></li><li><a href="#vspm-package-manager">VSpm: package manager</a></li><li><a href="#terminal-vsdb">Terminal VSDB&gt;</a></li><li><a href="#tabel-bawaan">Tabel bawaan</a></li><li><a href="#format-file-vsdb">Format file .VSDB</a></li><li><a href="#perintah-execute-dan-versi">Perintah execute dan versi</a></li><li><a href="#struktur-folder">Struktur folder</a></li><li><a href="#pesan-error-dan-solusinya">Pesan error dan solusinya</a></li><li><a href="#batasan">Batasan</a></li></ol></section><section id="fitur"><h2><a class="anc" href="#fitur" aria-label="Tautan bagian">#</a>Fitur</h2><ul><li>Terminal interaktif <code>VSDB&gt;</code> untuk membuat, membuka, dan menghapus database.</li><li>Tabel dibuat lewat isian <code>Name</code>, <code>Title</code>, dan <code>Description-&lt;kolom&gt;</code>.</li><li>Setiap database baru otomatis punya 3 tabel bawaan.</li><li><code>VSpm init</code> membuat <code>package.json</code> lewat formulir; tanpa file ini database tidak terbaca.</li><li>Kerangka kode <code>.VSDB</code> dijaga ketat: kalau diubah, runtime menampilkan syntax error beserta nomor barisnya.</li><li>Setiap perubahan tabel divalidasi ulang; kalau hasilnya tidak valid, perubahan dibatalkan dan file dikembalikan.</li><li><code>database.VSDB</code> disertakan sebagai contoh kode nyata yang bisa dijalankan.</li></ul></section><section id="syarat"><h2><a class="anc" href="#syarat" aria-label="Tautan bagian">#</a>Syarat</h2><ul><li><code>bash</code> dan <code>awk</code> (bawaan Linux dan macOS).</li><li>Windows: jalankan lewat WSL atau Git Bash.</li></ul></section><section id="pemasangan"><h2><a class="anc" href="#pemasangan" aria-label="Tautan bagian">#</a>Pemasangan</h2><h3 id="lewat-curl-otomatis-clone-dari-github">Lewat curl (otomatis clone dari GitHub)</h3><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>curl -fsSL https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/refs/heads/main/Assets/install.sh | bash</code></pre></div><p>Skrip ini meng-clone repo ke <code>~/.vsdb</code> (atau update kalau sudah ada), menjalankan <code>chmod +x</code> pada semua file skrip, memasang perintah <code>VSDB</code>, <code>VSdatabase</code>, dan <code>VSpm</code>, lalu menambahkan folder perintah ke PATH di <code>~/.bashrc</code> atau <code>~/.zshrc</code> bila belum ada. Butuh <code>git</code> (atau <code>curl</code> dan <code>tar</code>). Folder tujuan bisa diganti dengan <code>VSDB_HOME=/jalur/lain</code>.</p><h3 id="dari-folder-hasil-clone">Dari folder hasil clone</h3><p>Dari folder VSDB ini:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>bash install.sh</code></pre></div><p>Skrip ini membuat symlink <code>VSDB</code>, <code>VSdatabase</code>, dan <code>VSpm</code> di <code>/usr/local/bin</code> (jika bisa ditulis) atau <code>~/.local/bin</code>. Kalau muncul peringatan PATH, tambahkan baris yang ditampilkan ke <code>~/.bashrc</code> atau <code>~/.zshrc</code>, lalu buka terminal baru.</p><p>Cek hasilnya:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>VSDB -v</code></pre></div><p>Keluaran yang diharapkan:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>VSDB Runtime v1.0.0 LTS
VSPackage_manager v1.2.2 LTS</code></pre></div><p>Tanpa memasang ke PATH, semua perintah tetap bisa dijalankan langsung, misalnya <code>bash /jalur/ke/VSDB/VSdatabase</code>.</p></section><section id="mulai-cepat"><h2><a class="anc" href="#mulai-cepat" aria-label="Tautan bagian">#</a>Mulai cepat</h2><p>Buat folder proyek baru, lalu:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>VSpm init
VSdatabase</code></pre></div><p>Contoh sesi:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code><span class="pr">VSDB&gt;</span> create database toko_db
<span class="pr">VSDB&gt;</span> use open database toko_db
<span class="pr">VSDB:toko_db&gt;</span> create data table
  &gt; Name:warung baju
  &gt; Title:baju kaos
  &gt; Description-harga: 10.000
  &gt;
Tabel 'warung baju' dibuat.
<span class="pr">VSDB:toko_db&gt;</span> check table
<span class="pr">VSDB:toko_db&gt;</span> run toko_db</code></pre></div><p>Hasil <code>run</code> untuk tabel buatanmu:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>[warung baju]
+-----------+--------+
| title     | harga  |
+-----------+--------+
| baju kaos | 10.000 |
+-----------+--------+</code></pre></div></section><section id="vspm-package-manager"><h2><a class="anc" href="#vspm-package-manager" aria-label="Tautan bagian">#</a>VSpm: package manager</h2><div class="logo-row"> <img class="sec-logo" src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827545920.png" alt="Logo VSpm"></div><h3 id="vspm-init-wajib-dijalankan-lebih-dulu">VSpm init (wajib dijalankan lebih dulu)</h3><p><code>VSpm init</code> membuka formulir. Semua isian wajib, dan ditanya ulang kalau kosong atau salah format:</p><ol><li><strong>Nama project</strong>: huruf, angka, <code>.</code>, <code>_</code>, <code>-</code> (tanpa spasi).</li><li><strong>Versi project</strong>: format <code>angka.angka.angka</code>, contoh <code>1.0.0</code>.</li><li><strong>Nama file/database yang akan dipakai</strong>: huruf, angka, <code>_</code>, <code>-</code> (tanpa spasi dan tanpa ekstensi).</li></ol><p>Hasilnya:</p><ul><li><code>package.json</code> di folder kerja.</li><li>File database <code>vsdb_data/&lt;nama&gt;.VSDB</code> yang langsung berisi 3 tabel bawaan.</li></ul><p>Contoh <code>package.json</code>:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>{
  "name": "toko",
  "version": "1.0.0",
  "database": "toko_db",
  "main": "vsdb_data/toko_db.VSDB",
  "scripts": { "start": "VSdatabase" },
  "vsdb": { "runtime": "1.0.0 LTS", "package_manager": "1.2.2 LTS" },
  "dependencies": {}
}</code></pre></div><p><strong>Tanpa <code>package.json</code>, <code>VSdatabase</code> menolak berjalan</strong> dan file database tidak dibaca. Kalau <code>package.json</code> sudah ada, <code>VSpm init</code> menanyakan dulu apakah mau ditimpa.</p><h3 id="perintah-vspm-lainnya">Perintah VSpm lainnya</h3><div class="tw"><table><thead><tr><th>Perintah</th><th>Fungsi</th></tr></thead><tbody><tr><td><code>VSpm install &lt;nama[@versi]&gt;</code></td><td>Menambah dependency ke <code>package.json</code></td></tr><tr><td><code>VSpm install ./folder</code></td><td>Menyalin modul lokal ke <code>vsdb_modules/</code></td></tr><tr><td><code>VSpm remove &lt;nama&gt;</code></td><td>Menghapus dependency</td></tr><tr><td><code>VSpm list</code></td><td>Menampilkan dependency</td></tr><tr><td><code>VSpm -v</code></td><td>Menampilkan versi (1.2.2 LTS)</td></tr></tbody></table></div><p>Catatan: package manager belum terhubung ke registry online. <code>install nama@versi</code> hanya mencatat dependency dan membuat folder modul.</p></section><section id="terminal-vsdb"><h2><a class="anc" href="#terminal-vsdb" aria-label="Tautan bagian">#</a>Terminal VSDB&gt;</h2><p>Jalankan dengan <code>VSdatabase</code> di dalam folder yang punya <code>package.json</code>. Saat masuk, terminal menampilkan nama proyek, versi, dan database dari <code>package.json</code>.</p><h3 id="di-luar-database">Di luar database</h3><div class="tw"><table><thead><tr><th>Perintah</th><th>Fungsi</th></tr></thead><tbody><tr><td><code>create database &lt;nama&gt;</code></td><td>Membuat database baru (otomatis ada 3 tabel bawaan)</td></tr><tr><td><code>use open database &lt;nama&gt;</code></td><td>Membuka database</td></tr><tr><td><code>rm database &lt;nama&gt;</code></td><td>Menghapus database (minta konfirmasi y/n)</td></tr><tr><td><code>check database</code></td><td>Melihat daftar database</td></tr><tr><td><code>help</code></td><td>Menampilkan bantuan</td></tr><tr><td><code>clear</code></td><td>Membersihkan layar</td></tr><tr><td><code>exit</code></td><td>Keluar dari VSDB</td></tr></tbody></table></div><p>Nama database hanya boleh huruf, angka, <code>_</code>, dan <code>-</code>. Tanda kutip di sekitar nama diabaikan.</p><h3 id="di-dalam-database">Di dalam database</h3><p>Setelah <code>use open database &lt;nama&gt;</code>, prompt berubah menjadi <code>VSDB:&lt;nama&gt;&gt;</code>. Perintah berikut <strong>hanya bisa dipakai di dalam database</strong>; kalau dipakai di luar, muncul pesan agar membuka database dulu.</p><div class="tw"><table><thead><tr><th>Perintah</th><th>Fungsi</th></tr></thead><tbody><tr><td><code>create data table</code></td><td>Membuat tabel lewat isian bertahap</td></tr><tr><td><code>rm table &lt;nama_table&gt;</code></td><td>Menghapus tabel (minta konfirmasi y/n)</td></tr><tr><td><code>check table</code></td><td>Melihat daftar tabel</td></tr><tr><td><code>check table &lt;nama_table&gt;</code></td><td>Melihat isi satu tabel</td></tr><tr><td><code>run [nama_database]</code></td><td>Menjalankan database dan menampilkan semua tabel; tanpa nama berarti database yang sedang terbuka</td></tr><tr><td><code>close</code></td><td>Menutup database dan kembali ke <code>VSDB&gt;</code></td></tr></tbody></table></div><h3 id="membuat-tabel">Membuat tabel</h3><p>Setelah <code>create data table</code>, ketik satu isian per baris dengan format <code>kunci:isi</code>. Baris kosong mengakhiri isian.</p><div class="tw"><table><thead><tr><th>Kunci</th><th>Wajib</th><th>Keterangan</th></tr></thead><tbody><tr><td><code>Name</code></td><td>Ya</td><td>Nama tabel</td></tr><tr><td><code>Title</code></td><td>Tidak</td><td>Judul/isi utama tabel</td></tr><tr><td><code>Description-&lt;kolom&gt;</code></td><td>Tidak</td><td>Kolom tambahan, boleh lebih dari satu (contoh <code>Description-harga</code>, <code>Description-stok</code>)</td></tr></tbody></table></div><p>Aturan:</p><ul><li>Nama kolom hanya huruf, angka, dan <code>_</code>.</li><li>Kunci ditulis tanpa memperhatikan huruf besar/kecil. Penulisan <code>Descriotion-</code> (typo) juga diterima.</li><li>Kolom yang diisi dua kali memakai isian terakhir.</li><li>Tabel gagal dibuat kalau <code>Name</code> kosong, namanya sudah ada, atau sama dengan nama tabel bawaan.</li></ul><h3 id="menghapus-tabel">Menghapus tabel</h3><p><code>rm table &lt;nama_table&gt;</code> menghapus satu tabel (nama boleh mengandung spasi, misalnya <code>rm table warung baju</code>). Tabel bawaan tidak bisa dihapus.</p></section><section id="tabel-bawaan"><h2><a class="anc" href="#tabel-bawaan" aria-label="Tautan bagian">#</a>Tabel bawaan</h2><p>Setiap database baru otomatis punya tiga tabel ini. Ketiganya tidak bisa dihapus dan namanya tidak bisa dipakai untuk tabel baru.</p><div class="tw"><table><thead><tr><th>Tabel</th><th>Isi</th></tr></thead><tbody><tr><td><code>Virtual_stack_database_schema</code></td><td>Info engine, format file, dan versi package manager</td></tr><tr><td><code>Stack_database_schema</code></td><td>Kerangka wajib stack dan jumlah tabel bawaan</td></tr><tr><td><code>Virtual_schema</code></td><td>Nama database, tanggal dibuat, dan lokasi file</td></tr></tbody></table></div></section><section id="format-file-vsdb"><h2><a class="anc" href="#format-file-vsdb" aria-label="Tautan bagian">#</a>Format file .VSDB</h2><p>Terminal menulis file ini otomatis di folder <code>vsdb_data/</code>, tapi formatnya bisa dibaca dan dijalankan langsung.</p><h3 id="kerangka-wajib-tidak-boleh-diganti">Kerangka wajib (tidak boleh diganti)</h3><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code><span class="lock">@database</span>
<span class="lock">input database-stack</span>
<span class="lock">@stack</span>
...isi...
<span class="lock">@end database</span></code></pre></div><p>Empat baris ini harus persis seperti di atas dan berurutan. Kalau diganti, runtime menampilkan <code>VSDB SyntaxError</code> beserta nomor barisnya dan berhenti. Tidak boleh ada kode setelah <code>@end database</code>.</p><h3 id="isi-stack">Isi stack</h3><div class="tw"><table><thead><tr><th>Baris</th><th>Fungsi</th></tr></thead><tbody><tr><td><code>input-table</code></td><td>Membuka definisi tabel</td></tr><tr><td><code>@table &lt;nama&gt;</code></td><td>Nama tabel (harus tepat setelah <code>input-table</code>)</td></tr><tr><td><code>input-data:&lt;title&gt;</code></td><td>Title tabel</td></tr><tr><td><code>input-description-&lt;kolom&gt;:&lt;isi&gt;</code></td><td>Kolom dan isinya</td></tr><tr><td><code>output-table</code></td><td>Tabel ikut ditampilkan saat dijalankan</td></tr><tr><td><code>@end table</code></td><td>Menutup tabel</td></tr><tr><td><code>all input request-output</code></td><td>Menampilkan semua tabel</td></tr></tbody></table></div><p>Baris kosong dan baris berawalan <code>#</code> diabaikan.</p><h3 id="contoh-databasevsdb">Contoh (database.VSDB)</h3><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code><span class="lock">@database</span>

<span class="lock">input database-stack</span>


<span class="lock">@stack</span>

input-table
@table warung baju
input-data:baju kaos
input-description-harga:10.000
output-table
@end table

all input request-output

<span class="lock">@end database</span></code></pre></div><h3 id="menjalankan-file-langsung">Menjalankan file langsung</h3><p>Di dalam folder yang punya <code>package.json</code>:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>VSdatabase database.VSDB      # jalankan file
VSdatabase toko_db            # jalankan database di vsdb_data/
VSdatabase --check database.VSDB   # cek sintaks saja</code></pre></div></section><section id="perintah-execute-dan-versi"><h2><a class="anc" href="#perintah-execute-dan-versi" aria-label="Tautan bagian">#</a>Perintah execute dan versi</h2><p>Folder <code>execute/</code> berisi empat file execute:</p><div class="tw"><table><thead><tr><th>File</th><th>Fungsi</th></tr></thead><tbody><tr><td><code>execute/runtime</code></td><td>Menjalankan runtime (dipakai <code>VSdatabase</code>)</td></tr><tr><td><code>execute/package_manager</code></td><td>Menjalankan package manager (dipakai <code>VSpm</code>)</td></tr><tr><td><code>execute/version_runtime</code></td><td>Menampilkan versi runtime</td></tr><tr><td><code>execute/version_package_manager</code></td><td>Menampilkan versi package manager</td></tr></tbody></table></div><p>Versi:</p><div class="tw"><table><thead><tr><th>Perintah</th><th>Hasil</th></tr></thead><tbody><tr><td><code>VSDB -v</code></td><td><code>VSDB Runtime v1.0.0 LTS</code> dan <code>VSPackage_manager v1.2.2 LTS</code></td></tr><tr><td><code>VSDB --version-runtime</code></td><td>Versi runtime saja</td></tr><tr><td><code>VSDB --version-package-manager</code></td><td>Versi package manager saja</td></tr><tr><td><code>VSdatabase -v</code></td><td>Versi runtime</td></tr><tr><td><code>VSpm -v</code></td><td>Versi package manager</td></tr></tbody></table></div></section><section id="struktur-folder"><h2><a class="anc" href="#struktur-folder" aria-label="Tautan bagian">#</a>Struktur folder</h2><p>Folder alat VSDB:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>VSDB/
├── VSdatabase                 execute: buka terminal VSDB&gt;
├── VSpm                       execute: package manager
├── VSDB                       perintah bantu (VSDB -v)
├── runtime.sh                 runtime (shell)
├── VSPackage_manager          package manager (shell)
├── install.sh                 pasang perintah ke PATH
├── database.VSDB              contoh kode nyata
├── execute/                   4 file execute
├── website/index.html         website
├── README.md                  dokumen ini
└── PRD.md                     panduan lengkap pembuatan</code></pre></div><p>Folder proyekmu (tempat menjalankan perintah) akan berisi:</p><div class="cb"><button class="cp" type="button" aria-label="Salin kode">Salin</button><pre><code>package.json       dibuat oleh VSpm init
vsdb_data/         semua file database (*.VSDB)
vsdb_modules/      dependency</code></pre></div></section><section id="pesan-error-dan-solusinya"><h2><a class="anc" href="#pesan-error-dan-solusinya" aria-label="Tautan bagian">#</a>Pesan error dan solusinya</h2><div class="tw"><table><thead><tr><th>Pesan</th><th>Penyebab dan solusi</th></tr></thead><tbody><tr><td><code>package.json tidak ditemukan, database tidak bisa dibaca</code></td><td>Jalankan <code>VSpm init</code> di folder proyek, lalu ulangi</td></tr><tr><td><code>package.json tidak punya field "database"</code></td><td>Jalankan lagi <code>VSpm init</code></td></tr><tr><td><code>Perintah ini hanya bisa dipakai di dalam database</code></td><td>Buka dulu dengan <code>use open database &lt;nama&gt;</code></td></tr><tr><td><code>VSDB SyntaxError (... baris N): ...</code></td><td>Kerangka atau isi file salah di baris N; perbaiki sesuai pesan. Empat baris kerangka wajib tidak boleh diubah</td></tr><tr><td><code>Database '&lt;nama&gt;' tidak ditemukan</code></td><td>Cek nama dengan <code>check database</code> atau buat dengan <code>create database &lt;nama&gt;</code></td></tr><tr><td><code>Permission denied</code> saat menjalankan</td><td>Jalankan <code>bash install.sh</code> (mengatur izin eksekusi), atau panggil dengan <code>bash VSdatabase</code></td></tr><tr><td><code>command not found: VSdatabase</code></td><td>Folder tujuan symlink belum ada di PATH; tambahkan baris <code>export PATH=...</code> yang ditampilkan <code>install.sh</code></td></tr></tbody></table></div></section><section id="batasan"><h2><a class="anc" href="#batasan" aria-label="Tautan bagian">#</a>Batasan</h2><ul><li>Package manager belum punya registry online.</li><li>Satu tabel menyimpan satu baris data (Title dan kolom-kolomnya).</li><li>Belum ada perintah ubah tabel; untuk mengubah, hapus lalu buat ulang.</li><li>Belum ada query atau filter.</li></ul><p>Ide pengembangan ada di bagian akhir <a href="../PRD.md">PRD.md</a>.</p></section></div>
  <div class="empty" id="empty">Tidak ada bagian yang cocok dengan pencarianmu.</div>
  <footer>
    <img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827554896.png" alt="Logo VSdatabase"><img src="https://raw.githubusercontent.com/ftn-cyber/VSdatabase-database-is-system/main/Assets/Img/1792827545920.png" alt="Logo VSpm">
    <span>VSDB Runtime v1.0.0 LTS &nbsp;|&nbsp; VSPackage_manager v1.2.2 LTS<br>Panduan perancangan lengkap ada di <a href="../PRD.md">PRD.md</a>.</span>
  </footer>
</main>
</div>
<button type="button" id="up" aria-label="Kembali ke atas">Ke atas</button>
<script>
(function(){
var d=document,root=d.documentElement,$=function(s,c){return(c||d).querySelector(s)},$$=function(s,c){return[].slice.call((c||d).querySelectorAll(s))};
/* tema */
var saved=null;try{saved=localStorage.getItem("vsdb-theme")}catch(e){}
root.setAttribute("data-theme",saved||(matchMedia("(prefers-color-scheme:dark)").matches?"dark":"light"));
$$(".theme").forEach(function(b){b.onclick=function(){var t=root.getAttribute("data-theme")==="dark"?"light":"dark";root.setAttribute("data-theme",t);try{localStorage.setItem("vsdb-theme",t)}catch(e){}}});
/* menu mobile */
var side=$("#side");$("#menu").onclick=function(){side.classList.toggle("open")};
$$("#nav a").forEach(function(a){a.addEventListener("click",function(){side.classList.remove("open")})});
/* salin kode */
function copy(txt,btn){var ok=function(){var o=btn.textContent;btn.textContent="Tersalin";setTimeout(function(){btn.textContent=o},1400)};
 if(navigator.clipboard&&navigator.clipboard.writeText){navigator.clipboard.writeText(txt).then(ok,function(){})}
 else{var t=d.createElement("textarea");t.value=txt;d.body.appendChild(t);t.select();try{d.execCommand("copy");ok()}catch(e){}d.body.removeChild(t)}}
$$(".cp").forEach(function(b){b.onclick=function(){var t=b.getAttribute("data-copy");if(t===null){t=$("code",b.parentNode).innerText}copy(t,b)}});
/* scroll-spy */
var secs=$$("#content section"),links={};
$$("#nav a.top").forEach(function(a){links[a.getAttribute("href").slice(1)]=a});
if("IntersectionObserver" in window){var io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting&&links[e.target.id]){$$("#nav a.top").forEach(function(x){x.classList.remove("on")});links[e.target.id].classList.add("on")}})},{rootMargin:"-10% 0px -80% 0px"});secs.forEach(function(s){io.observe(s)})}
/* cari */
var q=$("#q"),orig=secs.map(function(s){return s.innerHTML});
function clearMarks(s,i){s.innerHTML=orig[i]}
function esc(x){return x.replace(/[.*+?^${}()|[\]\\]/g,"\\$&")}
q.addEventListener("input",function(){
 var v=q.value.trim().toLowerCase(),shown=0;
 secs.forEach(function(s,i){
  clearMarks(s,i);
  var hit=!v||s.textContent.toLowerCase().indexOf(v)>-1;
  s.style.display=hit?"":"none";
  var g=links[s.id]&&links[s.id].parentNode;if(g)g.style.display=hit?"":"none";
  if(hit)shown++;
  if(v&&hit){var re=new RegExp("("+esc(v)+")","gi"),w=d.createTreeWalker(s,NodeFilter.SHOW_TEXT,null),n=[],x;while(x=w.nextNode()){if(!/^(SCRIPT|STYLE|BUTTON)$/.test(x.parentNode.nodeName)&&re.test(x.nodeValue))n.push(x);re.lastIndex=0}
   n.forEach(function(t){var span=d.createElement("span");span.innerHTML=t.nodeValue.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(re,"<mark>$1</mark>");t.parentNode.replaceChild(span,t)})}
 });
 $("#empty").style.display=shown?"none":"block";$("#none").style.display=shown?"none":"block";
 $$(".cp",$("#content")).forEach(function(b){b.onclick=function(){copy($("code",b.parentNode).innerText,b)}});
});
/* ke atas */
var up=$("#up");addEventListener("scroll",function(){up.style.display=scrollY>600?"block":"none"},{passive:true});
up.onclick=function(){scrollTo({top:0})};
})();
</script>
</body>
</html>
