# Normalisasi Proyek Perpustakaan - Pertemuan 4 (Milestone Proyek 4)

**Nama:** Rizqi Tri Haryadi    **NIM:** 25430123

Dasar: `p02_kebutuhan_data_25430123.md` (proses bisnis, aturan bisnis AB-01 s.d. AB-10, kamus data) dan ERD `p03_erd_25430123.png`. Nama kolom mengikuti ERD Pertemuan 3; padanan nama pada kamus data dicatat di bagian 12.

## 1. Dokumen sumber (titik awal UNF)

Formulir Peminjaman Buku (p02, bagian 3.1). Elemen pada formulir: nomor transaksi, nomor anggota, nama anggota, tanggal peminjaman, batas pengembalian, kode buku, judul buku, jumlah buku, dan petugas. Menurut pembedahan p02 bagian 3.2 dan AB-04, satu formulir dapat memuat satu atau lebih buku, sehingga ada grup berulang buku.

## 2. UNF

```
PEMINJAMAN_UNF (id_peminjaman, tanggal_pinjam, tanggal_jatuh_tempo,
                id_anggota, nama_anggota, id_petugas,
                { id_buku, judul_buku, jumlah })
```

## 3. UNF ke 1NF

Grup berulang buku dipecah: satu baris untuk setiap buku pada setiap transaksi. Satu transaksi muncul di banyak baris, sehingga kunci primer menjadi komposit.

```
PEMINJAMAN_1NF (id_peminjaman, id_buku, tanggal_pinjam, tanggal_jatuh_tempo,
                id_anggota, nama_anggota, id_petugas, judul_buku, jumlah)
Kunci primer: (id_peminjaman, id_buku)
```

Catatan atomik: kolom `penulis` pada tabel buku diperlakukan sebagai satu nilai (penulis utama) karena aturan bisnis tidak mensyaratkan banyak penulis per buku (lihat bagian 13).

## 4. Dependensi fungsional (berdasarkan aturan bisnis p02)

| FD | Dependensi | Dasar |
|---|---|---|
| FD1 | id_peminjaman -> tanggal_pinjam, tanggal_jatuh_tempo, id_anggota, id_petugas | AB-04 (nomor transaksi unik), AB-06 (batas pengembalian ditentukan saat pinjam dan disimpan di transaksi) |
| FD2 | id_anggota -> nama_anggota, alamat, no_hp, email, status_anggota | AB-01 (ID anggota unik), AB-03 (status keanggotaan) |
| FD3 | id_buku -> judul_buku, penulis, penerbit, tahun_terbit, isbn, id_kategori, stok_total | AB-02 (ID buku unik, ISBN sesuai edisi) |
| FD4 | id_kategori -> nama_kategori, deskripsi | PB-02 dan isu kualitas data no. 7 (kategori terstandar); tidak ada AB khusus |
| FD5 | id_petugas -> nama_petugas, nama_pengguna, peran, status_petugas | AB-10 (petugas berwenang), PB-07 |
| FD6 | (id_peminjaman, id_buku) -> jumlah, kondisi_pinjam | AB-04 (minimal satu detail buku), AB-05 (jumlah per buku lebih dari nol) |
| FD7 | id_pengembalian -> id_peminjaman, tanggal_kembali, kondisi_kembali | AB-07 (merujuk transaksi), AB-08 (kondisi diperiksa) |
| FD8 | id_denda -> id_pengembalian, jumlah_denda, status_pembayaran, tanggal_pembayaran | AB-09 |

Dependensi yang sengaja **tidak** dipakai:

- `tanggal_pinjam -> tanggal_jatuh_tempo`. Pada contoh formulir selisihnya 7 hari, tetapi p02 bagian 5.1 menyatakan lama peminjaman belum ditetapkan dan AB-06 menyimpan batas sebagai bagian transaksi. Contoh data tidak boleh dipakai membuktikan FD.
- `id_buku -> jumlah`. Jumlah bergantung pada transaksi dan buku sekaligus (FD6), bukan pada buku saja.

## 5. Menuju 2NF

Kunci komposit `(id_peminjaman, id_buku)`. Ketergantungan parsial:

- FD1: tanggal_pinjam, tanggal_jatuh_tempo, id_anggota, id_petugas (dan nama_anggota secara tidak langsung) hanya bergantung pada `id_peminjaman`.
- FD3: judul_buku hanya bergantung pada `id_buku`.

Hasil pemisahan:

```
PEMINJAMAN        (id_peminjaman, tanggal_pinjam, tanggal_jatuh_tempo, id_anggota, nama_anggota, id_petugas)
BUKU              (id_buku, judul_buku)
DETAIL_PEMINJAMAN (id_peminjaman, id_buku, jumlah)
```

## 6. Menuju 3NF

Pada `PEMINJAMAN` terdapat rantai `id_peminjaman -> id_anggota -> nama_anggota` (FD1 dan FD2). Atribut anggota dipisah ke relasi `ANGGOTA`. Hal yang sama berlaku untuk petugas (FD5): `id_peminjaman -> id_petugas -> nama_petugas`, sehingga data petugas berada di relasi `PETUGAS`, dan `PEMINJAMAN` hanya menyimpan `id_petugas` sebagai kunci tamu.

```
PEMINJAMAN        (id_peminjaman, tanggal_pinjam, tanggal_jatuh_tempo, id_anggota*, id_petugas*)
DETAIL_PEMINJAMAN (id_peminjaman*, id_buku*, jumlah, kondisi_pinjam)
BUKU              (id_buku, judul_buku, ...)
ANGGOTA           (id_anggota, nama_anggota, alamat, no_hp, email, status_anggota)
PETUGAS           (id_petugas, nama_petugas, nama_pengguna, peran, status_petugas)
```

## 7. Perluasan ke entitas lain pada ERD

- **Kategori.** Pada `BUKU` terdapat rantai `id_buku -> id_kategori -> nama_kategori` (FD3 dan FD4). Nama dan deskripsi kategori dipisah ke `KATEGORI`, sehingga penulisan kategori konsisten (isu kualitas data no. 7).
- **Pengembalian.** FD7 menempatkan tanggal_kembali dan kondisi_kembali pada kunci `id_pengembalian`; tidak ada ketergantungan parsial maupun transitif. Kolom `denda` pada ERD dihapus dari relasi ini (lihat bagian 9).
- **Denda.** FD8 menempatkan jumlah_denda, status_pembayaran, dan tanggal_pembayaran pada kunci `id_denda`. Tidak ada rantai.

## 8. Tabel tahapan UNF -> 1NF -> 2NF -> 3NF

| Tahap | Relasi hasil | Masalah yang dihilangkan |
|---|---|---|
| UNF | PEMINJAMAN_UNF | - |
| 1NF | PEMINJAMAN_1NF (kunci komposit id_peminjaman, id_buku) | grup berulang buku |
| 2NF | PEMINJAMAN, BUKU, DETAIL_PEMINJAMAN | atribut yang hanya bergantung pada id_peminjaman atau id_buku |
| 3NF | PEMINJAMAN, DETAIL_PEMINJAMAN, BUKU, ANGGOTA, PETUGAS, KATEGORI, PENGEMBALIAN, DENDA | rantai peminjaman -> anggota -> nama, peminjaman -> petugas -> nama, buku -> kategori -> nama |

## 9. Keputusan nilai turunan

| Nilai | Cara memperoleh | Keputusan | Alasan |
|---|---|---|---|
| stok tersedia (KI-02, AB-05) | stok_total dikurangi jumlah buku pada transaksi yang belum punya pengembalian | **Dihitung**; hanya `stok_total` disimpan | stok_total adalah fakta koleksi yang dicatat petugas koleksi (PB-02). Jika stok tersedia ikut disimpan, nilainya dapat tidak cocok dengan data transaksi. |
| status_peminjaman | ada atau tidaknya baris pengembalian, dibandingkan dengan tanggal_jatuh_tempo | **Dihitung**; kolom dihapus | Status dapat diturunkan dari data pengembalian sehingga menyimpannya membuka peluang tidak konsisten. |
| lama keterlambatan (hari) | selisih tanggal_kembali dan tanggal_jatuh_tempo | **Dihitung** | Murni turunan dari dua tanggal yang sudah tersimpan. |
| jumlah_denda (AB-09) | tarif dan durasi keterlambatan, atau penilaian kerusakan oleh petugas | **Disimpan** di tabel `denda` | Tarif belum ditetapkan dan dapat berubah, dan denda kerusakan ditentukan petugas sehingga tidak murni turunan. Denda yang sudah ditetapkan adalah potret historis yang tidak boleh berubah. |
| tanggal_jatuh_tempo (AB-06) | - | **Disimpan** | AB-06 menyatakan batas disimpan sebagai bagian transaksi; lama peminjaman belum tetap. |
| jumlah transaksi per hari/bulan, buku paling sering dipinjam (KI-03, KI-06) | agregasi dari peminjaman dan detail | **Dihitung** saat laporan | Hasil laporan, bukan data operasional. |

## 10. Pemeriksaan BCNF

| Tabel | Kunci kandidat | Penentu | Hasil |
|---|---|---|---|
| anggota | id_anggota | id_anggota | BCNF |
| petugas | id_petugas, nama_pengguna (dibuat unik untuk login) | id_petugas, nama_pengguna | BCNF |
| kategori | id_kategori, nama_kategori (kategori terstandar) | id_kategori, nama_kategori | BCNF |
| buku | id_buku, isbn (bila diisi, unik per id_buku) | id_buku, isbn | BCNF |
| peminjaman | id_peminjaman | id_peminjaman | BCNF |
| detail_peminjaman | id_detail; (id_peminjaman, id_buku) | keduanya | BCNF |
| pengembalian | id_pengembalian; id_peminjaman (satu pengembalian per peminjaman, sesuai ERD 0..1) | keduanya | BCNF |
| denda | id_denda; id_pengembalian (satu denda per pengembalian, sesuai ERD 0..1) | keduanya | BCNF |

Tidak ditemukan penentu yang bukan kunci kandidat. Kunci pengganti `id_*` tidak mengubah hasil, karena pemeriksaan tetap dilakukan pada kunci alami (misalnya pasangan `id_peminjaman, id_buku`).

## 11. Skema 3NF akhir

```
ANGGOTA           (id_anggota, nama_anggota, alamat, no_hp, email, status_anggota)
PETUGAS           (id_petugas, nama_petugas, nama_pengguna, password_hash, peran, status_petugas)
KATEGORI          (id_kategori, nama_kategori, deskripsi)
BUKU              (id_buku, id_kategori*, isbn, judul_buku, penulis, penerbit, tahun_terbit, stok_total)
PEMINJAMAN        (id_peminjaman, id_anggota*, id_petugas*, tanggal_pinjam, tanggal_jatuh_tempo)
DETAIL_PEMINJAMAN (id_detail, id_peminjaman*, id_buku*, jumlah, kondisi_pinjam)   -- unik (id_peminjaman, id_buku)
PENGEMBALIAN      (id_pengembalian, id_peminjaman*, tanggal_kembali, kondisi_kembali)   -- id_peminjaman unik
DENDA             (id_denda, id_pengembalian*, jumlah_denda, status_pembayaran, tanggal_pembayaran)   -- id_pengembalian unik
-- * = kunci tamu
```

## 12. Perubahan pada ERD Pertemuan 3

| No | Perubahan | Alasan |
|---|---|---|
| 1 | Hapus `status_peminjaman` dari PEMINJAMAN | nilai turunan (bagian 9) |
| 2 | Hapus `denda` dari PENGEMBALIAN | duplikat `jumlah_denda` di DENDA dan potensi turunan |
| 3 | Ganti nama `stok` menjadi `stok_total` pada BUKU | sesuai kamus data; stok tersedia dihitung |
| 4 | Tambah `status_anggota` pada ANGGOTA | AB-03 mensyaratkan status aktif untuk meminjam |
| 5 | Tambah `isbn` pada BUKU | AB-02 dan kamus data |
| 6 | Tambah `status_petugas` pada PETUGAS; ganti `password` menjadi `password_hash` | PB-07; p02 bagian 9.3 melarang kata sandi teks biasa |
| 7 | Ganti nama DETAIL_PEMINJAM menjadi DETAIL_PEMINJAMAN; beri kunci unik (id_peminjaman, id_buku) | konsistensi nama; FD6 |

Padanan nama kolom antara ERD dan kamus data p02: `tanggal_jatuh_tempo` = `batas_pengembalian`, `judul_buku` = `judul`, `no_hp` = `no_telepon`, `nama_pengguna` = `username`. Pilih satu penamaan dan samakan di kedua dokumen sebelum Pertemuan 5.

Dampak pada matriks CRUD p02: karena stok tersedia dan status peminjaman dihitung, operasi U pada Buku di PB-03/PB-04 dan U pada Peminjaman di PB-04 tidak lagi diperlukan.

## 13. Asumsi dan hal yang perlu dikonfirmasi

- Satu buku muncul paling banyak satu baris per transaksi (jumlah eksemplar dicatat di `jumlah`). Bila ingin menegakkannya, tambahkan sebagai aturan bisnis.
- Pengembalian dilakukan sekaligus untuk seluruh buku dalam satu transaksi (ERD: pengembalian 0..1 per peminjaman). Bila buku boleh dikembalikan terpisah, `tanggal_kembali` dan `kondisi_kembali` harus dipindah ke tingkat detail.
- `penulis` ditulis sebagai satu nilai. Bila satu buku boleh banyak penulis, buat tabel `penulis_buku` dengan kunci (id_buku, nama_penulis).
- `id_buku` mewakili judul/edisi dengan banyak eksemplar (dicatat di `stok_total`), bukan eksemplar fisik.
- Tarif denda dan lama peminjaman belum ditetapkan (p02 bagian 5.1).
