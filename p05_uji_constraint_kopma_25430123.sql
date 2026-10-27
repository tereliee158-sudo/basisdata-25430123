-- p05_uji_constraint_kopma_25430123.sql
-- Pembuktian constraint (langkah D.3), alter struktur (D.4), dan Latihan E
-- Jalankan SATU PERINTAH PER KALI di phpMyAdmin. Perintah bertanda [DITOLAK] harus menghasilkan galat.
USE kopma_123;

-- ===== Persiapan data induk (harus berhasil) =====
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas)
VALUES ('K01','Kasir Satu','kasir'), ('G01','Gudang Satu','gudang');

INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang)
VALUES ('ATK-001','Pulpen','ATK',4000,50), ('MKN-001','Roti','makanan',5000,20);

-- ===== D.3: pembuktian constraint =====
-- [DITOLAK] Uji 1: petugas 99 tidak ada (diharapkan galat 1452)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0199', NOW(), 99, NULL, 5000);

-- [DITOLAK] Uji 2: stok negatif, melanggar AB-05 (diharapkan galat 4025)
UPDATE barang SET stok_barang = -1 WHERE id_barang = 1;

-- [DITOLAK] Uji 3: kode barang kembar (diharapkan galat 1062)
INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang)
VALUES ('ATK-001','Duplikat','ATK',1000);

-- ===== D.4: mengubah struktur =====
ALTER TABLE barang ADD COLUMN tgl_kedaluwarsa DATE NULL AFTER stok_min_barang;
ALTER TABLE barang DROP COLUMN tgl_kedaluwarsa;

-- ===== Latihan E.1: CHECK stok minimum tidak negatif =====
ALTER TABLE barang ADD CONSTRAINT ck_barang_stok_min CHECK (stok_min_barang >= 0);

-- [DITOLAK] pembuktian E.1 (diharapkan galat 4025)
UPDATE barang SET stok_min_barang = -1 WHERE id_barang = 1;

-- ===== Latihan E.2: ON DELETE SET NULL pada fk_penjualan_anggota =====
ALTER TABLE penjualan DROP FOREIGN KEY fk_penjualan_anggota;
ALTER TABLE penjualan
  ADD CONSTRAINT fk_penjualan_anggota FOREIGN KEY (id_anggota)
  REFERENCES anggota (id_anggota) ON DELETE SET NULL;

-- ===== Bukti struktur =====
SHOW CREATE TABLE penjualan;
