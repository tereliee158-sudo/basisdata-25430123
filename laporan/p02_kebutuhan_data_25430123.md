Dokumen Kebutuhan Data — Perpustakaan

1. Latar Belakang dan Aktivitas Organisasi

Perpustakaan merupakan organisasi yang menyediakan layanan peminjaman dan pengembalian buku serta pengelolaan koleksi untuk memenuhi kebutuhan informasi pengunjung. Agar kegiatan operasional berjalan dengan baik, perpustakaan membutuhkan pengelolaan data yang terstruktur, konsisten, dan mudah ditelusuri.

Data yang dikelola meliputi data anggota, petugas, buku, kategori buku, transaksi peminjaman, dan pengembalian. Pengelolaan data yang baik diperlukan untuk menghindari pencatatan ganda, mengetahui ketersediaan buku, memantau keterlambatan pengembalian, dan menyusun laporan aktivitas perpustakaan.

Aktivitas utama perpustakaan meliputi pendaftaran anggota, pencatatan koleksi buku, peminjaman buku, pengembalian buku, serta pembuatan laporan. Setiap aktivitas tersebut menghasilkan atau menggunakan data yang saling berhubungan.

Dokumen ini disusun untuk mengidentifikasi kebutuhan data perpustakaan sebelum dilakukan perancangan basis data. Hasil analisis akan menjadi dasar untuk menentukan entitas kandidat, aturan bisnis, kebutuhan informasi, matriks CRUD, dan kamus data awal.
## 2. Aktor dan Proses Bisnis

Aktor merupakan pihak yang terlibat dalam kegiatan operasional perpustakaan. Setiap aktor memiliki tanggung jawab dan kebutuhan data yang berbeda.

| Kode | Aktor | Proses Bisnis | Deskripsi |
|---|---|---|---|
| PB-01 | Petugas perpustakaan | Pendaftaran anggota | Mencatat identitas anggota baru dan membuat nomor anggota yang unik. |
| PB-02 | Petugas perpustakaan | Pengelolaan koleksi buku | Mencatat data buku baru, kategori, ISBN, dan jumlah eksemplar. |
| PB-03 | Anggota dan petugas | Peminjaman buku | Mencatat anggota, buku yang dipinjam, tanggal pinjam, dan batas pengembalian. |
| PB-04 | Anggota dan petugas | Pengembalian buku | Mencatat tanggal pengembalian dan memeriksa keterlambatan. |
| PB-05 | Petugas perpustakaan | Pengelolaan data anggota | Memperbarui data anggota serta status keanggotaannya. |
| PB-06 | Kepala perpustakaan | Pembuatan laporan | Melihat laporan peminjaman, pengembalian, dan ketersediaan buku. |
| PB-07 | Administrator sistem | Pengelolaan data petugas | Mencatat data petugas baru, memperbarui informasi, dan mengatur status petugas. |

### Pembagian Tanggung Jawab Aktor

- **Petugas perpustakaan:** mengelola data anggota, koleksi buku, serta transaksi peminjaman dan pengembalian.
- **Anggota:** mengajukan peminjaman dan mengembalikan buku sesuai ketentuan.
- **Kepala perpustakaan:** memantau aktivitas dan menggunakan laporan untuk evaluasi layanan.
## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber fiktif yang digunakan dalam analisis ini adalah formulir peminjaman buku Perpustakaan. Formulir ini dirancang untuk menggambarkan data yang dicatat ketika anggota meminjam buku.

### 3.1 Contoh Formulir Peminjaman Buku

**PERPUSTAKAAN — FORMULIR PEMINJAMAN BUKU**

| Elemen | Contoh Data |
|---|---|
| Nomor transaksi | PJ-2026-0001 |
| Nomor anggota | AG-001 |
| Nama anggota | Andi Saputra |
| Tanggal peminjaman | 13 Oktober 2026 |
| Batas pengembalian | 20 Oktober 2026 |
| Kode buku | BK-001 |
| Judul buku | Dasar-Dasar Basis Data |
| Jumlah buku | 1 eksemplar |
| Petugas | PT-001 |

*Catatan: seluruh identitas dan data pada formulir ini merupakan data fiktif untuk keperluan praktikum.*

### 3.2 Pembedahan Dokumen Sumber

Dari formulir peminjaman tersebut, dapat diidentifikasi beberapa elemen data, yaitu nomor transaksi, nomor anggota, tanggal peminjaman, batas pengembalian, kode buku, jumlah buku, dan kode petugas.

Elemen nomor transaksi digunakan untuk membedakan satu transaksi dari transaksi lainnya. Nomor anggota menghubungkan transaksi dengan data anggota, sedangkan kode buku menghubungkan transaksi dengan koleksi buku yang dipinjam.

Tanggal peminjaman dan batas pengembalian digunakan untuk memantau durasi peminjaman serta mengidentifikasi keterlambatan. Jumlah buku diperlukan untuk mencatat banyaknya eksemplar yang dipinjam. Sementara itu, kode petugas digunakan untuk mengetahui petugas yang melayani transaksi.

Dokumen ini menunjukkan bahwa satu transaksi peminjaman dapat melibatkan anggota, petugas, dan satu atau lebih buku. Oleh karena itu, kebutuhan data transaksi perlu dianalisis agar hubungan antarentitas dapat dirancang dengan tepat.
## 4. Entitas Kandidat dan Elemen Data

Entitas kandidat merupakan objek atau hal yang datanya perlu disimpan dalam sistem basis data perpustakaan. Berdasarkan proses bisnis dan formulir peminjaman yang telah dianalisis, entitas kandidat yang diidentifikasi adalah sebagai berikut.

| Entitas Kandidat | Elemen Data Utama | Sumber |
|---|---|---|
| Anggota | ID anggota, NIM, nama, alamat, nomor telepon, tanggal pendaftaran, status anggota | Formulir pendaftaran anggota |
| Petugas | ID petugas, nama, jabatan, nama pengguna, status petugas | Data petugas perpustakaan |
| Buku | ID buku, ISBN, judul, tahun terbit, penerbit, ID kategori, jumlah stok | Katalog buku |
| Kategori | ID kategori, nama kategori, deskripsi | Daftar kategori koleksi |
| Peminjaman | ID peminjaman, ID anggota, ID petugas, tanggal pinjam, batas pengembalian, status peminjaman | Formulir peminjaman |
| Detail Peminjaman | ID detail, ID peminjaman, ID buku, jumlah eksemplar, kondisi saat dipinjam | Formulir peminjaman |
| Pengembalian | ID pengembalian, ID peminjaman, tanggal pengembalian, kondisi buku, denda | Formulir pengembalian |

### 4.1 Penjelasan Hubungan Antarentitas

Entitas Anggota berhubungan dengan Peminjaman karena setiap transaksi peminjaman harus tercatat atas nama anggota yang terdaftar. Petugas berhubungan dengan transaksi karena petugas bertanggung jawab mencatat kegiatan peminjaman dan pengembalian.

Entitas Buku berhubungan dengan Kategori untuk mengelompokkan koleksi berdasarkan jenisnya. Peminjaman dan Buku dihubungkan melalui Detail Peminjaman agar satu transaksi dapat mencatat beberapa buku.

Entitas Pengembalian berhubungan dengan Peminjaman untuk mencatat penyelesaian transaksi, tanggal pengembalian, kondisi buku, dan kemungkinan denda apabila terjadi keterlambatan atau kerusakan.

Entitas-entitas tersebut masih merupakan kandidat awal. Struktur dan hubungan akhirnya akan disesuaikan pada tahap perancangan basis data berikutnya.
## 5. Aturan Bisnis

Aturan bisnis digunakan sebagai pedoman dalam menjalankan kegiatan perpustakaan dan menjaga konsistensi data yang disimpan dalam sistem.

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap anggota harus memiliki ID anggota yang unik dan tidak boleh digunakan oleh anggota lain. |
| AB-02 | Setiap buku harus memiliki ID buku yang unik. ISBN, apabila tersedia, dicatat sesuai dengan edisi buku yang bersangkutan. |
| AB-03 | Anggota hanya dapat melakukan peminjaman apabila status keanggotaannya aktif. |
| AB-04 | Setiap transaksi peminjaman harus memiliki nomor transaksi yang unik dan minimal satu detail buku. |
| AB-05 | Jumlah buku yang dipinjam harus lebih dari nol dan tidak boleh melebihi stok tersedia. |
| AB-06 | Batas pengembalian ditentukan pada saat peminjaman dicatat dan disimpan sebagai bagian dari transaksi. |
| AB-07 | Pengembalian harus merujuk pada transaksi peminjaman yang telah tercatat. |
| AB-08 | Buku yang dikembalikan harus diperiksa kondisinya oleh petugas sebelum transaksi pengembalian diselesaikan. |
| AB-09 | Denda keterlambatan, jika diterapkan, dihitung berdasarkan aturan tarif dan durasi keterlambatan yang ditetapkan perpustakaan. |
| AB-10 | Hanya petugas yang memiliki kewenangan yang boleh mengubah data koleksi dan data transaksi. |

### 5.1 Penjelasan Aturan Bisnis

Aturan AB-01 dan AB-02 menjaga keunikan identitas data anggota dan buku. Aturan AB-03 sampai AB-07 mengatur validitas transaksi peminjaman dan pengembalian. Aturan AB-08 dan AB-09 mendukung pemeriksaan kondisi buku serta pencatatan denda. Sementara itu, AB-10 membatasi perubahan data berdasarkan tanggung jawab petugas.

Ketentuan mengenai tarif denda dan lama peminjaman perlu ditetapkan lebih lanjut oleh pihak perpustakaan karena nilainya belum ditentukan dalam analisis awal ini.
## 6. Kebutuhan Informasi

Kebutuhan informasi ditentukan berdasarkan aktivitas operasional dan kebutuhan pelaporan perpustakaan. Informasi yang dihasilkan harus memiliki sumber data yang jelas dan dapat digunakan untuk mendukung pengambilan keputusan.

| Kode | Kebutuhan Informasi | Data yang Diperlukan | Pengguna |
|---|---|---|---|
| KI-01 | Menampilkan jumlah anggota aktif dan tidak aktif | Anggota | Petugas dan kepala perpustakaan |
| KI-02 | Menampilkan daftar buku beserta kategori dan stok tersedia | Buku, Kategori | Petugas dan anggota |
| KI-03 | Menampilkan jumlah transaksi peminjaman per hari dan per bulan | Peminjaman, Detail Peminjaman | Kepala perpustakaan |
| KI-04 | Menampilkan daftar buku yang sedang dipinjam dan batas pengembaliannya | Peminjaman, Detail Peminjaman, Anggota, Buku | Petugas |
| KI-05 | Menampilkan daftar keterlambatan pengembalian dan denda yang tercatat | Peminjaman, Pengembalian, Anggota | Petugas dan kepala perpustakaan |
| KI-06 | Menampilkan buku yang paling sering dipinjam dalam periode tertentu | Buku, Detail Peminjaman, Peminjaman | Kepala perpustakaan |
| KI-07 | Menampilkan riwayat peminjaman dan pengembalian setiap anggota | Anggota, Peminjaman, Detail Peminjaman, Pengembalian | Petugas yang berwenang |

### 6.1 Kriteria Informasi

Informasi yang disajikan harus berdasarkan data transaksi yang tersimpan dan dapat ditelusuri kembali ke sumbernya. Laporan berkala perlu memiliki rentang tanggal yang jelas, sedangkan laporan stok harus membedakan jumlah koleksi yang tersedia dan jumlah yang sedang dipinjam.

Akses terhadap riwayat anggota dan data transaksi harus dibatasi sesuai kewenangan pengguna. Dengan demikian, kebutuhan informasi tidak hanya mendukung operasional perpustakaan, tetapi juga menjaga kerahasiaan data anggota.
## 7. Matriks CRUD

Matriks CRUD digunakan untuk menunjukkan hubungan antara proses bisnis dan entitas data yang digunakan. Huruf C menunjukkan pembuatan data, R menunjukkan pembacaan data, U menunjukkan pembaruan data, dan D menunjukkan penghapusan data.

| Proses Bisnis | Anggota | Petugas | Buku | Kategori | Peminjaman | Detail Peminjaman | Pengembalian |
|---|---|---|---|---|---|---|---|
| PB-01 Pendaftaran anggota | C | R | — | — | — | — | — |
| PB-02 Pengelolaan koleksi buku | R | R | C/R/U | C/R/U | — | — | — |
| PB-03 Peminjaman buku | R | R | R/U | — | C | C | — |
| PB-04 Pengembalian buku | R | R | R/U | — | R/U | R | C |
| PB-05 Pengelolaan data anggota | R/U | R | — | — | — | — | — |
| PB-06 Pembuatan laporan | R | R | R | R | R | R | R |
| PB-07 Pengelolaan data petugas | — | C/R/U | — | — | — | — | — |

Keterangan: tanda `—` berarti entitas tersebut tidak digunakan secara langsung dalam proses yang bersangkutan.

### 7.1 Penjelasan Matriks CRUD

Proses pendaftaran anggota membuat data anggota baru. Pengelolaan koleksi buku membuat dan memperbarui data buku serta kategori. Proses peminjaman membaca data anggota dan buku, kemudian membuat data peminjaman beserta detail buku yang dipinjam.

Pada proses pengembalian, sistem membaca data transaksi terkait, memperbarui status peminjaman dan ketersediaan buku, serta membuat catatan pengembalian. Proses pengelolaan anggota digunakan untuk memperbarui informasi anggota, sedangkan pembuatan laporan membaca data yang dibutuhkan tanpa mengubah data operasional.

Penghapusan data tidak dicantumkan sebagai operasi rutin agar riwayat transaksi tetap dapat ditelusuri. Apabila data tidak lagi aktif, sistem sebaiknya menggunakan status nonaktif sesuai aturan yang ditetapkan perpustakaan.
## 8. Kamus Data Awal

Kamus data awal digunakan untuk mendokumentasikan elemen data yang dibutuhkan sistem perpustakaan. Tipe data dan panjang kolom pada tabel berikut merupakan usulan awal yang akan ditinjau kembali pada tahap perancangan logis.

| Entitas | Elemen Data | Tipe Data Usulan | Keterangan | Penanggung Jawab |
|---|---|---|---|---|
| Anggota | id_anggota | VARCHAR(15) | Identitas unik anggota | Petugas administrasi |
| Anggota | nim | VARCHAR(20) | Nomor induk mahasiswa, jika anggota mahasiswa | Petugas administrasi |
| Anggota | nama_anggota | VARCHAR(100) | Nama lengkap anggota | Petugas administrasi |
| Anggota | alamat | VARCHAR(255) | Alamat anggota | Petugas administrasi |
| Anggota | no_telepon | VARCHAR(20) | Nomor telepon anggota | Petugas administrasi |
| Anggota | tanggal_daftar | DATE | Tanggal pendaftaran anggota | Petugas administrasi |
| Anggota | status_anggota | VARCHAR(15) | Status aktif atau tidak aktif | Petugas administrasi |
| Petugas | id_petugas | VARCHAR(15) | Identitas unik petugas | Kepala perpustakaan |
| Petugas | nama_petugas | VARCHAR(100) | Nama lengkap petugas | Kepala perpustakaan |
| Petugas | jabatan | VARCHAR(30) | Jabatan atau peran petugas | Kepala perpustakaan |
| Petugas | nama_pengguna | VARCHAR(50) | Nama pengguna untuk login | Administrator sistem |
| Buku | id_buku | VARCHAR(15) | Identitas unik buku | Petugas koleksi |
| Buku | isbn | VARCHAR(20) | Nomor ISBN jika tersedia | Petugas koleksi |
| Buku | judul | VARCHAR(200) | Judul buku | Petugas koleksi |
| Buku | tahun_terbit | SMALLINT | Tahun penerbitan buku | Petugas koleksi |
| Buku | penerbit | VARCHAR(100) | Nama penerbit | Petugas koleksi |
| Buku | id_kategori | VARCHAR(15) | Referensi kategori buku | Petugas koleksi |
| Buku | stok_total | INT | Jumlah seluruh eksemplar yang tercatat | Petugas koleksi |
| Kategori | id_kategori | VARCHAR(15) | Identitas unik kategori | Petugas koleksi |
| Kategori | nama_kategori | VARCHAR(50) | Nama kategori buku | Petugas koleksi |
| Peminjaman | id_peminjaman | VARCHAR(20) | Identitas unik transaksi peminjaman | Petugas layanan |
| Peminjaman | id_anggota | VARCHAR(15) | Anggota yang melakukan peminjaman | Petugas layanan |
| Peminjaman | id_petugas | VARCHAR(15) | Petugas yang melayani transaksi | Petugas layanan |
| Peminjaman | tanggal_pinjam | DATE | Tanggal peminjaman | Petugas layanan |
| Peminjaman | batas_pengembalian | DATE | Tanggal batas pengembalian | Petugas layanan |
| Peminjaman | status_peminjaman | VARCHAR(20) | Status transaksi peminjaman | Petugas layanan |
| Detail Peminjaman | id_detail | VARCHAR(20) | Identitas unik detail peminjaman | Petugas layanan |
| Detail Peminjaman | id_buku | VARCHAR(15) | Buku yang dipinjam | Petugas layanan |
| Detail Peminjaman | jumlah | INT | Jumlah eksemplar yang dipinjam | Petugas layanan |
| Pengembalian | id_pengembalian | VARCHAR(20) | Identitas unik transaksi pengembalian | Petugas layanan |
| Pengembalian | tanggal_kembali | DATE | Tanggal buku dikembalikan | Petugas layanan |
| Pengembalian | kondisi_buku | VARCHAR(30) | Kondisi buku saat dikembalikan | Petugas layanan |
| Pengembalian | denda | DECIMAL(12,2) | Nilai denda jika dikenakan | Petugas layanan |

### 8.1 Catatan Kamus Data

Tipe data pada tabel merupakan usulan awal, bukan struktur tabel SQL final. Penentuan kunci utama, kunci asing, batasan nilai, dan aturan validasi akan dilakukan pada tahap perancangan berikutnya.

Data seperti nama, alamat, nomor telepon, dan NIM harus dikelola secara hati-hati karena dapat mengidentifikasi anggota. Akses terhadap data tersebut perlu dibatasi berdasarkan tugas dan kewenangan pengguna.
## 9. Kebutuhan Non-Fungsional Data

Kebutuhan non-fungsional data menjelaskan persyaratan pengelolaan data perpustakaan agar data tetap aman, tersedia, konsisten, dan dapat digunakan sesuai kebutuhan organisasi.

### 9.1 Volume Data

Pada tahap awal, sistem diperkirakan mengelola ratusan data anggota, ratusan hingga ribuan data buku, serta puluhan transaksi peminjaman dan pengembalian setiap hari. Perkiraan ini merupakan asumsi awal untuk perencanaan dan perlu disesuaikan dengan kondisi perpustakaan yang sebenarnya.

### 9.2 Retensi Data

Data anggota yang sudah tidak aktif tetap disimpan sesuai kebijakan perpustakaan agar riwayat transaksi dapat ditelusuri. Data peminjaman dan pengembalian juga perlu dipertahankan untuk keperluan laporan dan pemeriksaan. Jangka waktu penyimpanan final harus ditetapkan oleh pengelola perpustakaan sesuai kebijakan yang berlaku.

### 9.3 Privasi dan Keamanan Data

Data pribadi anggota, seperti nama, alamat, NIM, dan nomor telepon, hanya boleh diakses oleh petugas yang memiliki kewenangan. Data autentikasi pengguna harus dilindungi dan tidak boleh disimpan dalam bentuk kata sandi teks biasa. Setiap pengguna sistem harus memperoleh hak akses sesuai tugasnya.

### 9.4 Integritas dan Konsistensi Data

Setiap anggota, petugas, buku, kategori, peminjaman, detail peminjaman, dan pengembalian harus memiliki identitas yang dapat dibedakan. Data transaksi harus mengacu pada data anggota, petugas, dan buku yang valid. Jumlah stok tidak boleh menjadi negatif dan perubahan data transaksi harus menjaga konsistensi riwayat peminjaman.

### 9.5 Ketersediaan dan Pencadangan

Data perlu tersedia saat petugas melakukan pendaftaran anggota, pengelolaan koleksi, peminjaman, pengembalian, dan pembuatan laporan. Pencadangan basis data perlu dilakukan secara berkala dan hasil pencadangan harus dapat dipulihkan ketika terjadi kerusakan atau kehilangan data.

### 9.6 Audit dan Pembatasan Akses

Perubahan penting terhadap data anggota, koleksi, dan transaksi sebaiknya dapat ditelusuri berdasarkan pengguna dan waktu perubahan. Petugas layanan tidak perlu memperoleh hak untuk mengubah seluruh pengaturan sistem. Pemberian hak akses harus mengikuti prinsip hak minimum yang diperlukan untuk menjalankan pekerjaan.
## 10. Isu Kualitas Data

Dalam pengelolaan data perpustakaan, terdapat beberapa potensi masalah kualitas data yang perlu diperhatikan agar informasi yang dihasilkan akurat, konsisten, dan dapat dipercaya.

| No. | Isu Kualitas Data | Dampak | Usulan Penanganan |
|---|---|---|---|
| 1 | Data anggota ganda | Jumlah anggota menjadi tidak akurat | Menggunakan ID anggota yang unik dan memeriksa data sebelum pendaftaran |
| 2 | Nama atau identitas anggota tidak lengkap | Petugas kesulitan mengenali anggota | Menetapkan elemen wajib saat pendaftaran |
| 3 | Data buku ganda | Koleksi buku tercatat lebih dari satu kali | Menggunakan ID buku unik dan memeriksa ISBN jika tersedia |
| 4 | Stok buku tidak sesuai kondisi sebenarnya | Peminjaman dapat melebihi stok yang tersedia | Memperbarui stok setiap terjadi transaksi dan melakukan pemeriksaan berkala |
| 5 | Tanggal pengembalian tidak tercatat | Riwayat peminjaman menjadi tidak lengkap | Mewajibkan pencatatan tanggal saat buku dikembalikan |
| 6 | Data transaksi tidak terhubung dengan data anggota atau buku | Laporan menjadi tidak akurat | Memastikan setiap transaksi mengacu pada identitas yang valid |
| 7 | Penulisan kategori buku tidak konsisten | Pengelompokan dan pencarian buku menjadi sulit | Menggunakan daftar kategori yang terstandar |
| 8 | Nomor telepon atau alamat sudah tidak berlaku | Petugas kesulitan menghubungi anggota | Melakukan pembaruan data secara berkala |

### 10.1 Prioritas Perbaikan

Prioritas pertama adalah mencegah data anggota dan buku ganda, menjaga kesesuaian stok, serta memastikan hubungan antara data transaksi dan data induk tetap valid. Prioritas berikutnya adalah melengkapi data wajib, menyeragamkan kategori, dan memperbarui informasi anggota secara berkala.

Isu-isu di atas merupakan potensi masalah berdasarkan rancangan proses perpustakaan. Kondisi sebenarnya perlu diverifikasi melalui pemeriksaan data dan dokumen perpustakaan yang tersedia.