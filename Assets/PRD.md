# PRD — VSdatabase (Virtual Stack Database)

Panduan lengkap pembuatan dan pemakaian VSDB.

## 1. Ringkasan

VSDB adalah database berbasis file `.VSDB`. Kamu bekerja lewat terminal interaktif berprompt `VSDB>` yang dibuka dengan perintah `VSdatabase`. Setiap proyek wajib punya `package.json` yang dibuat oleh `VSpm init`.

| Komponen | Perintah | Versi |
|---|---|---|
| Runtime (`runtime.sh`) | `VSdatabase` | 1.0.0 LTS |
| Package manager (`VSPackage_manager`) | `VSpm` | 1.2.2 LTS |

`VSDB -v` menampilkan kedua versi tersebut.

## 2. Struktur file

```
VSDB/
├── VSdatabase                 execute: buka terminal VSDB>
├── VSpm                       execute: package manager
├── VSDB                       perintah bantu (VSDB -v)
├── runtime.sh                 runtime (shell)
├── VSPackage_manager          package manager (shell)
├── install.sh                 pasang perintah ke PATH
├── database.VSDB              contoh kode nyata yang bisa dijalankan
├── execute/
│   ├── runtime                execute runtime
│   ├── package_manager        execute package_manager
│   ├── version_runtime        execute version runtime
│   └── version_package_manager  execute version package_manager
├── website/index.html         website
└── PRD.md                     panduan ini
```

Folder proyek milikmu (tempat kamu menjalankan perintah) akan berisi:

```
package.json        dibuat oleh VSpm init
vsdb_data/          semua file database (*.VSDB)
vsdb_modules/       dependency
```

## 3. Alur pemakaian

```
bash install.sh        # sekali saja
VSpm init              # isi formulir
VSdatabase             # masuk terminal VSDB>
```

### 3.1 VSpm init (wajib lebih dulu)

`VSpm init` membuka formulir. Semua isian wajib dan akan ditanya ulang kalau salah:

1. Nama project (huruf, angka, `.`, `_`, `-`)
2. Versi project (format `angka.angka.angka`, contoh `1.0.0`)
3. Nama file/database yang akan dipakai (huruf, angka, `_`, `-`)

Hasilnya `package.json` dan file database `vsdb_data/<nama>.VSDB` yang langsung berisi 3 tabel bawaan.

**Tanpa `package.json`, `VSdatabase` menolak berjalan** dan file database tidak dibaca.

### 3.2 Terminal VSDB>

Di luar database:

| Perintah | Fungsi |
|---|---|
| `create database <nama>` | Buat database baru (otomatis ada 3 tabel bawaan) |
| `use open database <nama>` | Buka database |
| `rm database <nama>` | Hapus database (ada konfirmasi y/n) |
| `check database` | Lihat daftar database |
| `help`, `clear`, `exit` | Bantuan, bersihkan layar, keluar |

Setelah database dibuka, prompt berubah menjadi `VSDB:<nama>>` dan perintah berikut aktif. Perintah ini **hanya bisa dipakai di dalam database**:

| Perintah | Fungsi |
|---|---|
| `create data table` | Buat tabel lewat isian `Name`, `Title`, `Description-<kolom>` |
| `rm table <nama_table>` | Hapus tabel (ada konfirmasi y/n) |
| `check table` | Daftar tabel |
| `check table <nama_table>` | Isi satu tabel |
| `run [nama_database]` | Jalankan database dan tampilkan semua tabel |
| `close` | Keluar dari database |

### 3.3 Membuat tabel

```
VSDB:toko_db> create data table
  > Name:warung baju
  > Title:baju kaos
  > Description-harga: 10.000
  >
Tabel 'warung baju' dibuat.
```

- `Name` wajib. `Title` dan `Description-<kolom>` opsional; kolom bisa lebih dari satu.
- Baris kosong mengakhiri isian.
- Penulisan `Descriotion-` (typo) juga diterima.
- Nama tabel tidak boleh sama dengan tabel yang sudah ada atau tabel bawaan.

### 3.4 Tabel bawaan

Setiap database baru otomatis punya 3 tabel yang tidak bisa dihapus:

| Tabel | Isi |
|---|---|
| `Virtual_stack_database_schema` | Info engine, format, dan versi package manager |
| `Stack_database_schema` | Kerangka wajib stack dan jumlah tabel bawaan |
| `Virtual_schema` | Nama database, tanggal dibuat, lokasi file |

## 4. Sintaks file .VSDB

Terminal menulis file ini otomatis, tapi formatnya bisa dibaca dan dijalankan langsung.

### Kerangka wajib (tidak boleh diganti)

```
@database
input database-stack
@stack
...isi...
@end database
```

Keempat baris ini harus persis seperti di atas dan berurutan. Kalau diganti, runtime menampilkan `VSDB SyntaxError` beserta nomor baris dan berhenti. Tidak boleh ada kode setelah `@end database`.

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

### Contoh (`database.VSDB`)

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

Menjalankannya di dalam folder proyek: `VSdatabase /jalur/ke/database.VSDB`. Cek sintaks saja: `VSdatabase --check <file>`.

## 5. VSpm

| Perintah | Hasil |
|---|---|
| `VSpm init` | Formulir pembuat `package.json` |
| `VSpm install <nama[@versi]>` | Menambah dependency |
| `VSpm install ./folder` | Menyalin modul lokal |
| `VSpm remove <nama>` | Menghapus dependency |
| `VSpm list` | Daftar dependency |
| `VSpm -v` | Versi package manager |

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

## 6. File execute

| File | Fungsi |
|---|---|
| `execute/runtime` | Menjalankan runtime (`VSdatabase`) |
| `execute/package_manager` | Menjalankan package manager (`VSpm`) |
| `execute/version_runtime` | Menampilkan versi runtime |
| `execute/version_package_manager` | Menampilkan versi package manager |

`VSDB -v` memanggil kedua file versi dan menampilkan:

```
VSDB Runtime v1.0.0 LTS
VSPackage_manager v1.2.2 LTS
```

## 7. Cara kerja runtime

1. Cek `package.json` di folder kerja dan baca field `database`. Tidak ada, berhenti dengan pesan error.
2. Buka terminal `VSDB>` dan baca perintah satu per satu.
3. Perintah database mengubah file di `vsdb_data/`. Setiap perubahan tabel dicek ulang dengan parser; kalau hasilnya tidak valid, perubahan dibatalkan dan file dikembalikan.
4. `run` memakai parser awk yang memvalidasi kerangka wajib lalu menampilkan semua tabel.

Syarat: `bash` dan `awk`. Di Windows pakai WSL atau Git Bash.

## 8. Batasan versi saat ini

- Package manager belum terhubung ke registry online. `install nama@versi` hanya mencatat dependency dan membuat folder modul.
- Satu tabel hanya menyimpan satu baris data (Title + kolom).
- Belum ada perintah ubah tabel; untuk mengubah, hapus lalu buat ulang.

## 9. Ide pengembangan

- Registry online untuk package manager.
- Banyak baris per tabel dan perintah query/filter.
- Perintah `edit table`.
- Ekspor ke JSON atau CSV.
