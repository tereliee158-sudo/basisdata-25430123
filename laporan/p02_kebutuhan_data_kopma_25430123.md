# Dokumen Kebutuhan Data - Koperasi Mahasiswa (Kopma)

## 1. Latar Belakang dan Aktivitas Organisasi

Koperasi Mahasiswa (Kopma) merupakan organisasi yang menyediakan barang kebutuhan mahasiswa dan melayani transaksi penjualan kepada anggota maupun nonanggota. Kegiatan operasionalnya meliputi pengelolaan anggota, barang, stok, transaksi penjualan, pembayaran, dan program loyalitas.

Dokumen ini disusun untuk mengidentifikasi kebutuhan data Kopma sebelum dilakukan perancangan basis data. Analisis mencakup proses bisnis, dokumen sumber, entitas kandidat, aturan bisnis, kebutuhan informasi, matriks CRUD, kamus data awal, kebutuhan non-fungsional, dan isu kualitas data.

## 2. Aktor dan Proses Bisnis

| Kode | Aktor | Proses Bisnis | Data yang Digunakan |
|---|---|---|---|
| PB-01 | Petugas | Mengelola data anggota Kopma | Anggota |
| PB-02 | Petugas | Mengelola data barang dan kategori | Barang, Kategori |
| PB-03 | Petugas | Mencatat transaksi penjualan | Penjualan, Detail Penjualan |
| PB-04 | Petugas | Mencatat pembayaran transaksi | Penjualan, Pembayaran |
| PB-05 | Petugas | Memperbarui stok barang | Barang |
| PB-06 | Petugas | Mengelola perolehan dan penukaran poin loyalitas | Anggota, Penjualan, Riwayat Poin |
| PB-07 | Ketua atau pengelola Kopma | Membuat laporan penjualan dan stok | Penjualan, Barang, Anggota |

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber fiktif yang digunakan adalah **nota penjualan Kopma**. Nota tersebut memuat nomor transaksi, tanggal transaksi, identitas petugas, status anggota pembeli, daftar barang, jumlah barang, harga satuan, subtotal, total pembayaran, dan metode pembayaran.

Dari nota tersebut, data transaksi dapat dipisahkan menjadi data utama penjualan dan data rinci barang yang dibeli. Data anggota dan barang disimpan sebagai data tersendiri agar tidak perlu ditulis ulang secara lengkap pada setiap transaksi.

## 4. Entitas Kandidat dan Elemen Data

Berdasarkan proses bisnis dan nota penjualan, entitas kandidat yang diperlukan adalah sebagai berikut.

| Entitas | Elemen Data Contoh | Keterangan |
|---|---|---|
| Anggota | id_anggota, nama, alamat, no_telepon, saldo_poin | Menyimpan identitas anggota dan saldo poin |
| Petugas | id_petugas, nama_petugas, username | Menyimpan data petugas Kopma |
| Kategori | id_kategori, nama_kategori | Mengelompokkan barang |
| Barang | id_barang, nama_barang, id_kategori, harga, stok | Menyimpan informasi barang dan persediaan |
| Penjualan | id_penjualan, tanggal, id_petugas, id_anggota, total | Menyimpan transaksi penjualan |
| Detail Penjualan | id_detail, id_penjualan, id_barang, jumlah, harga_satuan, subtotal | Menyimpan rincian barang dalam transaksi |
| Pembayaran | id_pembayaran, id_penjualan, metode, jumlah_bayar, status | Menyimpan informasi pembayaran |
| Riwayat Poin | id_riwayat, id_anggota, id_penjualan, jenis_transaksi, jumlah_poin, tanggal | Mencatat perolehan dan penukaran poin |

## 5. Aturan Bisnis

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap anggota memiliki ID anggota yang unik. |
| AB-02 | Setiap barang memiliki ID barang yang unik. |
| AB-03 | Setiap transaksi penjualan memiliki nomor transaksi yang unik. |
| AB-04 | Jumlah barang yang dijual harus lebih dari nol. |
| AB-05 | Stok barang tidak boleh menjadi negatif setelah transaksi penjualan. |
| AB-06 | Pembayaran harus tercatat dan terhubung dengan transaksi penjualan yang sesuai. |
| AB-07 | Setiap kelipatan belanja Rp10.000 yang memenuhi ketentuan program menghasilkan satu poin loyalitas bagi anggota. |
| AB-08 | Anggota dapat menukarkan poin apabila memiliki sedikitnya 50 poin yang tersedia. |
| AB-09 | Penukaran 50 poin memberikan potongan harga sebesar Rp5.000. |
| AB-10 | Saldo poin anggota harus diperbarui setiap kali poin diperoleh atau ditukarkan. |

Catatan: Ketentuan perolehan poin pada AB-07 menggunakan nilai belanja yang memenuhi ketentuan program loyalitas. Rincian pembulatan dan perlakuan terhadap sisa belanja perlu ditetapkan secara konsisten dalam implementasi sistem.
## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Pengguna | Data yang Diperlukan |
|---|---|---|---|
| KI-01 | Menampilkan daftar anggota Kopma | Petugas | Anggota |
| KI-02 | Menampilkan daftar barang beserta harga dan stok | Petugas | Barang, Kategori |
| KI-03 | Menampilkan rincian transaksi penjualan | Petugas | Penjualan, Detail Penjualan |
| KI-04 | Menampilkan laporan penjualan berdasarkan periode | Ketua atau pengelola Kopma | Penjualan, Detail Penjualan |
| KI-05 | Menampilkan barang dengan stok rendah | Petugas | Barang |
| KI-06 | Menampilkan saldo poin setiap anggota | Petugas | Anggota, Riwayat Poin |
| KI-07 | Menampilkan riwayat perolehan dan penukaran poin | Petugas | Riwayat Poin, Penjualan, Anggota |

## 7. Matriks CRUD

Keterangan: **C** = Create (membuat), **R** = Read (membaca), **U** = Update (memperbarui), dan **D** = Delete (menghapus).

| Proses Bisnis | Anggota | Petugas | Kategori | Barang | Penjualan | Detail Penjualan | Pembayaran | Riwayat Poin |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mengelola anggota | C/R/U | R | - | - | - | - | - | R |
| PB-02 Mengelola barang dan kategori | - | R | C/R/U | C/R/U | - | - | - | - |
| PB-03 Mencatat penjualan | R | R | R | R | C/R | C/R | - | - |
| PB-04 Mencatat pembayaran | - | R | - | - | R/U | R | C/R/U | - |
| PB-05 Memperbarui stok | - | R | - | R/U | R | R | - | - |
| PB-06 Mengelola poin loyalitas | R/U | R | - | - | R | R | R | C/R/U |
| PB-07 Membuat laporan | R | R | R | R | R | R | R | R |

Matriks ini merupakan rancangan awal. Hak penghapusan data tidak dijadikan operasi rutin agar riwayat transaksi tetap dapat ditelusuri. Pembaruan stok dan saldo poin harus dilakukan secara konsisten dengan transaksi yang menjadi sumbernya.
## 8. Kamus Data Awal

| Elemen Data | Entitas | Tipe Data Usulan | Keterangan | Penanggung Jawab |
|---|---|---|---|---|
| id_anggota | Anggota | INT | Identitas unik anggota | Petugas |
| nama_anggota | Anggota | VARCHAR(100) | Nama anggota | Petugas |
| alamat | Anggota | VARCHAR(255) | Alamat anggota | Petugas |
| no_telepon | Anggota | VARCHAR(20) | Nomor kontak anggota | Petugas |
| saldo_poin | Anggota | INT | Jumlah poin yang tersedia | Petugas |
| id_petugas | Petugas | INT | Identitas unik petugas | Pengelola |
| nama_petugas | Petugas | VARCHAR(100) | Nama petugas | Pengelola |
| username | Petugas | VARCHAR(50) | Nama akun petugas | Pengelola |
| id_kategori | Kategori | INT | Identitas kategori barang | Petugas |
| nama_kategori | Kategori | VARCHAR(100) | Nama kategori | Petugas |
| id_barang | Barang | INT | Identitas unik barang | Petugas |
| nama_barang | Barang | VARCHAR(150) | Nama barang | Petugas |
| harga | Barang | DECIMAL(12,2) | Harga satuan barang | Petugas |
| stok | Barang | INT | Jumlah barang tersedia | Petugas |
| id_penjualan | Penjualan | INT | Identitas transaksi penjualan | Petugas |
| tanggal_penjualan | Penjualan | DATETIME | Waktu transaksi | Petugas |
| total_penjualan | Penjualan | DECIMAL(12,2) | Total nilai transaksi | Petugas |
| id_detail | Detail Penjualan | INT | Identitas rincian transaksi | Petugas |
| jumlah | Detail Penjualan | INT | Kuantitas barang yang dibeli | Petugas |
| subtotal | Detail Penjualan | DECIMAL(12,2) | Nilai per rincian barang | Petugas |
| id_pembayaran | Pembayaran | INT | Identitas pembayaran | Petugas |
| metode_pembayaran | Pembayaran | VARCHAR(30) | Metode pembayaran | Petugas |
| status_pembayaran | Pembayaran | VARCHAR(20) | Status pembayaran | Petugas |
| id_riwayat | Riwayat Poin | INT | Identitas catatan poin | Petugas |
| jenis_transaksi | Riwayat Poin | VARCHAR(20) | Perolehan atau penukaran poin | Petugas |
| jumlah_poin | Riwayat Poin | INT | Poin yang diperoleh atau ditukarkan | Petugas |
| tanggal_poin | Riwayat Poin | DATETIME | Waktu perubahan poin | Petugas |

## 9. Kebutuhan Non-Fungsional Data

1. **Volume data:** Sistem harus mampu menyimpan data anggota, barang, transaksi penjualan, pembayaran, dan riwayat poin yang terus bertambah.
2. **Retensi:** Riwayat transaksi dan perubahan poin perlu dipertahankan sesuai kebijakan penyimpanan data Kopma.
3. **Privasi:** Data pribadi anggota, seperti alamat dan nomor telepon, hanya boleh diakses oleh petugas yang berwenang.
4. **Integritas:** Setiap transaksi harus terhubung dengan data barang dan petugas yang valid. Transaksi yang terkait dengan anggota harus mengacu pada anggota yang terdaftar.
5. **Keamanan:** Hak akses pengguna harus dibatasi berdasarkan tugas dan tanggung jawabnya.
6. **Pencadangan:** Data perlu dicadangkan secara berkala agar dapat dipulihkan apabila terjadi kerusakan atau kehilangan data.

## 10. Isu Kualitas Data yang Diantisipasi

| Isu | Dampak | Pencegahan |
|---|---|---|
| Data anggota ganda | Saldo poin dan riwayat anggota dapat terpisah | Menggunakan ID anggota unik |
| Data barang tidak lengkap | Informasi barang sulit digunakan | Memeriksa kolom wajib sebelum penyimpanan |
| Stok tidak sesuai | Laporan persediaan menjadi tidak akurat | Memperbarui stok berdasarkan transaksi |
| Pembayaran tidak terhubung | Status transaksi sulit diverifikasi | Menghubungkan pembayaran dengan ID penjualan |
| Saldo poin tidak sesuai | Penukaran poin dapat keliru | Mencatat setiap perolehan dan penukaran poin |
| Transaksi tercatat lebih dari sekali | Laporan penjualan menjadi berlebihan | Menggunakan nomor transaksi unik dan pemeriksaan duplikasi |

Dokumen ini menjadi dasar awal analisis kebutuhan data Kopma. Rancangan akhir perlu diperiksa kembali agar aturan loyalitas, matriks CRUD, dan pencatatan transaksi konsisten.
