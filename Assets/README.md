# VSDB — Virtual Stack Database

VSDB (Virtual Stack Database) adalah database berbasis file `.VSDB` yang dijalankan lewat terminal interaktif berprompt `VSDB>`. Datanya ditulis dalam satu "stack" dengan sintaks sederhana, dan seluruh alatnya (runtime, package manager, perintah execute) berupa shell script.

| Komponen | Perintah | Versi |
|---|---|---|
| Runtime (`runtime.sh`) | `VSdatabase` | 1.0.0 LTS |
| Package manager (`VSPackage_manager`) | `VSpm` | 1.2.2 LTS |

Panduan perancangan lengkap ada di [PRD.md](PRD.md).

## Daftar isi

1. [Fitur](#fitur)
2. [Syarat](#syarat)
3. [Pemasangan](#pemasangan)
4. [Mulai cepat](#mulai-cepat)
5. [VSpm: package manager](#vspm-package-manager)
6. [Terminal VSDB>](#terminal-vsdb)
7. [Tabel bawaan](#tabel-bawaan)
8. [Format file .VSDB](#format-file-vsdb)
9. [Perintah execute dan versi](#perintah-execute-dan-versi)
10. [Struktur folder](#struktur-folder)
11. [Pesan error dan solusinya](#pesan-error-dan-solusinya)
12. [Batasan](#batasan)

## Fitur

- Terminal interaktif `VSDB>` untuk membuat, membuka, dan menghapus database.
- Tabel dibuat lewat isian `Name`, `Title`, dan `Description-<kolom>`.
- Setiap database baru otomatis punya 3 tabel bawaan.
- `VSpm init` membuat `package.json` lewat formulir; tanpa file ini database tidak terbaca.
- Kerangka kode `.VSDB` dijaga ketat: kalau diubah, runtime menampilkan syntax error beserta nomor barisnya.
- Setiap perubahan tabel divalidasi ulang; kalau hasilnya tidak valid, perubahan dibatalkan dan file dikembalikan.
- `database.VSDB` disertakan sebagai contoh kode nyata yang bisa dijalankan.

## Syarat

- `bash` dan `awk` (bawaan Linux dan macOS).
- Windows: jalankan lewat WSL atau Git Bash.

## Pemasangan

Dari folder VSDB ini:

```
bash install.sh
```

Skrip ini membuat symlink `VSDB`, `VSdatabase`, dan `VSpm` di `/usr/local/bin` (jika bisa ditulis) atau `~/.local/bin`. Kalau muncul peringatan PATH, tambahkan baris yang ditampilkan ke `~/.bashrc` atau `~/.zshrc`, lalu buka terminal baru.

Cek hasilnya:

```
VSDB -v
```

Keluaran yang diharapkan:

```
VSDB Runtime v1.0.0 LTS
VSPackage_manager v1.2.2 LTS
```

Tanpa memasang ke PATH, semua perintah tetap bisa dijalankan langsung, misalnya `bash /jalur/ke/VSDB/VSdatabase`.

## Mulai cepat

Buat folder proyek baru, lalu:

```
VSpm init
VSdatabase
```

Contoh sesi:

```
VSDB> create database toko_db
VSDB> use open database toko_db
VSDB:toko_db> create data table
  > Name:warung baju
  > Title:baju kaos
  > Description-harga: 10.000
  >
Tabel 'warung baju' dibuat.
VSDB:toko_db> check table
VSDB:toko_db> run toko_db
```

Hasil `run` untuk tabel buatanmu:

```
[warung baju]
+-----------+--------+
| title     | harga  |
+-----------+--------+
| baju kaos | 10.000 |
+-----------+--------+
```

## VSpm: package manager

### VSpm init (wajib dijalankan lebih dulu)

`VSpm init` membuka formulir. Semua isian wajib, dan ditanya ulang kalau kosong atau salah format:

1. **Nama project**: huruf, angka, `.`, `_`, `-` (tanpa spasi).
2. **Versi project**: format `angka.angka.angka`, contoh `1.0.0`.
3. **Nama file/database yang akan dipakai**: huruf, angka, `_`, `-` (tanpa spasi dan tanpa ekstensi).

Hasilnya:

- `package.json` di folder kerja.
- File database `vsdb_data/<nama>.VSDB` yang langsung berisi 3 tabel bawaan.

Contoh `package.json`:

```json
{
  "name": "toko",
  "version": "1.0.0",
  "database": "toko_db",
  "main": "vsdb_data/toko_db.VSDB",
  "scripts": { "start": "VSdatabase" },
  "vsdb": { "runtime": "1.0.0 LTS", "package_manager": "1.2.2 LTS" },
  "dependencies": {}
}
```

**Tanpa `package.json`, `VSdatabase` menolak berjalan** dan file database tidak dibaca. Kalau `package.json` sudah ada, `VSpm init` menanyakan dulu apakah mau ditimpa.

### Perintah VSpm lainnya

| Perintah | Fungsi |
|---|---|
| `VSpm install <nama[@versi]>` | Menambah dependency ke `package.json` |
| `VSpm install ./folder` | Menyalin modul lokal ke `vsdb_modules/` |
| `VSpm remove <nama>` | Menghapus dependency |
| `VSpm list` | Menampilkan dependency |
| `VSpm -v` | Menampilkan versi (1.2.2 LTS) |

Catatan: package manager belum terhubung ke registry online. `install nama@versi` hanya mencatat dependency dan membuat folder modul.

## Terminal VSDB>

Jalankan dengan `VSdatabase` di dalam folder yang punya `package.json`. Saat masuk, terminal menampilkan nama proyek, versi, dan database dari `package.json`.

### Di luar database

| Perintah | Fungsi |
|---|---|
| `create database <nama>` | Membuat database baru (otomatis ada 3 tabel bawaan) |
| `use open database <nama>` | Membuka database |
| `rm database <nama>` | Menghapus database (minta konfirmasi y/n) |
| `check database` | Melihat daftar database |
| `help` | Menampilkan bantuan |
| `clear` | Membersihkan layar |
| `exit` | Keluar dari VSDB |

Nama database hanya boleh huruf, angka, `_`, dan `-`. Tanda kutip di sekitar nama diabaikan.

### Di dalam database

Setelah `use open database <nama>`, prompt berubah menjadi `VSDB:<nama>>`. Perintah berikut **hanya bisa dipakai di dalam database**; kalau dipakai di luar, muncul pesan agar membuka database dulu.

| Perintah | Fungsi |
|---|---|
| `create data table` | Membuat tabel lewat isian bertahap |
| `rm table <nama_table>` | Menghapus tabel (minta konfirmasi y/n) |
| `check table` | Melihat daftar tabel |
| `check table <nama_table>` | Melihat isi satu tabel |
| `run [nama_database]` | Menjalankan database dan menampilkan semua tabel; tanpa nama berarti database yang sedang terbuka |
| `close` | Menutup database dan kembali ke `VSDB>` |

### Membuat tabel

Setelah `create data table`, ketik satu isian per baris dengan format `kunci:isi`. Baris kosong mengakhiri isian.

| Kunci | Wajib | Keterangan |
|---|---|---|
| `Name` | Ya | Nama tabel |
| `Title` | Tidak | Judul/isi utama tabel |
| `Description-<kolom>` | Tidak | Kolom tambahan, boleh lebih dari satu (contoh `Description-harga`, `Description-stok`) |

Aturan:

- Nama kolom hanya huruf, angka, dan `_`.
- Kunci ditulis tanpa memperhatikan huruf besar/kecil. Penulisan `Descriotion-` (typo) juga diterima.
- Kolom yang diisi dua kali memakai isian terakhir.
- Tabel gagal dibuat kalau `Name` kosong, namanya sudah ada, atau sama dengan nama tabel bawaan.

### Menghapus tabel

`rm table <nama_table>` menghapus satu tabel (nama boleh mengandung spasi, misalnya `rm table warung baju`). Tabel bawaan tidak bisa dihapus.

## Tabel bawaan

Setiap database baru otomatis punya tiga tabel ini. Ketiganya tidak bisa dihapus dan namanya tidak bisa dipakai untuk tabel baru.

| Tabel | Isi |
|---|---|
| `Virtual_stack_database_schema` | Info engine, format file, dan versi package manager |
| `Stack_database_schema` | Kerangka wajib stack dan jumlah tabel bawaan |
| `Virtual_schema` | Nama database, tanggal dibuat, dan lokasi file |

## Format file .VSDB

Terminal menulis file ini otomatis di folder `vsdb_data/`, tapi formatnya bisa dibaca dan dijalankan langsung.

### Kerangka wajib (tidak boleh diganti)

```
@database
input database-stack
@stack
...isi...
@end database
```

Empat baris ini harus persis seperti di atas dan berurutan. Kalau diganti, runtime menampilkan `VSDB SyntaxError` beserta nomor barisnya dan berhenti. Tidak boleh ada kode setelah `@end database`.

### Isi stack

| Baris | Fungsi |
|---|---|
| `input-table` | Membuka definisi tabel |
| `@table <nama>` | Nama tabel (harus tepat setelah `input-table`) |
| `input-data:<title>` | Title tabel |
| `input-description-<kolom>:<isi>` | Kolom dan isinya |
| `output-table` | Tabel ikut ditampilkan saat dijalankan |
| `@end table` | Menutup tabel |
| `all input request-output` | Menampilkan semua tabel |

Baris kosong dan baris berawalan `#` diabaikan.

### Contoh (database.VSDB)

```
@database

input database-stack


@stack

input-table
@table warung baju
input-data:baju kaos
input-description-harga:10.000
output-table
@end table

all input request-output

@end database
```

### Menjalankan file langsung

Di dalam folder yang punya `package.json`:

```
VSdatabase database.VSDB      # jalankan file
VSdatabase toko_db            # jalankan database di vsdb_data/
VSdatabase --check database.VSDB   # cek sintaks saja
```

## Perintah execute dan versi

Folder `execute/` berisi empat file execute:

| File | Fungsi |
|---|---|
| `execute/runtime` | Menjalankan runtime (dipakai `VSdatabase`) |
| `execute/package_manager` | Menjalankan package manager (dipakai `VSpm`) |
| `execute/version_runtime` | Menampilkan versi runtime |
| `execute/version_package_manager` | Menampilkan versi package manager |

Versi:

| Perintah | Hasil |
|---|---|
| `VSDB -v` | `VSDB Runtime v1.0.0 LTS` dan `VSPackage_manager v1.2.2 LTS` |
| `VSDB --version-runtime` | Versi runtime saja |
| `VSDB --version-package-manager` | Versi package manager saja |
| `VSdatabase -v` | Versi runtime |
| `VSpm -v` | Versi package manager |

## Struktur folder

Folder alat VSDB:

```
VSDB/
├── VSdatabase                 execute: buka terminal VSDB>
├── VSpm                       execute: package manager
├── VSDB                       perintah bantu (VSDB -v)
├── runtime.sh                 runtime (shell)
├── VSPackage_manager          package manager (shell)
├── install.sh                 pasang perintah ke PATH
├── database.VSDB              contoh kode nyata
├── execute/                   4 file execute
├── website/index.html         website
├── README.md                  dokumen ini
└── PRD.md                     panduan lengkap pembuatan
```

Folder proyekmu (tempat menjalankan perintah) akan berisi:

```
package.json       dibuat oleh VSpm init
vsdb_data/         semua file database (*.VSDB)
vsdb_modules/      dependency
```

## Pesan error dan solusinya

| Pesan | Penyebab dan solusi |
|---|---|
| `package.json tidak ditemukan, database tidak bisa dibaca` | Jalankan `VSpm init` di folder proyek, lalu ulangi |
| `package.json tidak punya field "database"` | Jalankan lagi `VSpm init` |
| `Perintah ini hanya bisa dipakai di dalam database` | Buka dulu dengan `use open database <nama>` |
| `VSDB SyntaxError (... baris N): ...` | Kerangka atau isi file salah di baris N; perbaiki sesuai pesan. Empat baris kerangka wajib tidak boleh diubah |
| `Database '<nama>' tidak ditemukan` | Cek nama dengan `check database` atau buat dengan `create database <nama>` |
| `Permission denied` saat menjalankan | Jalankan `bash install.sh` (mengatur izin eksekusi), atau panggil dengan `bash VSdatabase` |
| `command not found: VSdatabase` | Folder tujuan symlink belum ada di PATH; tambahkan baris `export PATH=...` yang ditampilkan `install.sh` |

## Batasan

- Package manager belum punya registry online.
- Satu tabel menyimpan satu baris data (Title dan kolom-kolomnya).
- Belum ada perintah ubah tabel; untuk mengubah, hapus lalu buat ulang.
- Belum ada query atau filter.

Ide pengembangan ada di bagian akhir [PRD.md](PRD.md).
