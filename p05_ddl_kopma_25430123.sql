-- p05_ddl_kopma_25430123.sql
-- Pertemuan 5: DDL dan Constraint, studi kasus Kopma
-- Nama: Rizqi | NIM: 25430123
-- Rujukan AB-xx: aturan bisnis pada p02_kebutuhan_data_kopma_25430123.md
USE kopma_123;

-- Hapus tabel dari anak ke induk agar skrip dapat dijalankan ulang
DROP TABLE IF EXISTS detail_pembelian;
DROP TABLE IF EXISTS pembelian;
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS pemasok;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS anggota;
DROP TABLE IF EXISTS petugas;

-- ===== Tabel master =====

CREATE TABLE petugas (
  id_petugas    SMALLINT                      NOT NULL AUTO_INCREMENT,
  kode_petugas  CHAR(3)                       NOT NULL,
  nama_petugas  VARCHAR(100)                  NOT NULL,
  peran_petugas ENUM('kasir','gudang','ketua') NOT NULL,
  CONSTRAINT pk_petugas PRIMARY KEY (id_petugas),
  CONSTRAINT uq_petugas_kode UNIQUE (kode_petugas)
) ENGINE=InnoDB;

CREATE TABLE anggota (
  id_anggota          INT                    NOT NULL AUTO_INCREMENT,
  no_anggota          VARCHAR(10)            NOT NULL,
  nim_anggota         CHAR(10)               NOT NULL,
  nama_anggota        VARCHAR(100)           NOT NULL,
  prodi_anggota       VARCHAR(50)            NOT NULL,
  no_hp_anggota       VARCHAR(20)            NULL,      -- data pribadi (boleh kosong)
  status_anggota      ENUM('aktif','nonaktif') NOT NULL DEFAULT 'aktif',  -- status keanggotaan
  tgl_daftar_anggota  DATE                   NOT NULL,
  CONSTRAINT pk_anggota PRIMARY KEY (id_anggota),
  CONSTRAINT uq_anggota_no  UNIQUE (no_anggota),    -- AB-01: identitas anggota unik
  CONSTRAINT uq_anggota_nim UNIQUE (nim_anggota)        -- NIM tidak boleh ganda
) ENGINE=InnoDB;

CREATE TABLE barang (
  id_barang          INT                             NOT NULL AUTO_INCREMENT,
  kode_barang        VARCHAR(10)                     NOT NULL,
  nama_barang        VARCHAR(100)                    NOT NULL,
  kategori_barang    ENUM('ATK','makanan','minuman') NOT NULL,
  harga_jual_barang  DECIMAL(12,2)                   NOT NULL,
  stok_barang        INT                             NOT NULL DEFAULT 0,
  stok_min_barang    INT                             NOT NULL DEFAULT 5,   -- batas stok rendah (KI-05)
  CONSTRAINT pk_barang PRIMARY KEY (id_barang),
  CONSTRAINT uq_barang_kode UNIQUE (kode_barang),   -- AB-02: identitas barang unik
  CONSTRAINT ck_barang_stok  CHECK (stok_barang >= 0),        -- AB-05: stok tidak boleh negatif
  CONSTRAINT ck_barang_harga CHECK (harga_jual_barang >= 0)
) ENGINE=InnoDB;

CREATE TABLE pemasok (
  id_pemasok       INT          NOT NULL AUTO_INCREMENT,
  nama_pemasok     VARCHAR(100) NOT NULL,
  telepon_pemasok  VARCHAR(20)  NULL,
  alamat_pemasok   VARCHAR(255) NULL,
  CONSTRAINT pk_pemasok PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

-- ===== Penjualan =====

CREATE TABLE penjualan (
  id_penjualan       INT           NOT NULL AUTO_INCREMENT,
  no_nota_penjualan  CHAR(12)      NOT NULL,
  tgl_penjualan      DATETIME      NOT NULL,
  id_petugas         SMALLINT      NOT NULL,   -- setiap nota wajib punya kasir
  id_anggota         INT           NULL,       -- NULL untuk pembeli umum
  bayar_penjualan    DECIMAL(12,2) NOT NULL,   -- terkait AB-06: pembayaran tercatat pada transaksi
  CONSTRAINT pk_penjualan PRIMARY KEY (id_penjualan),
  CONSTRAINT uq_penjualan_nota UNIQUE (no_nota_penjualan),   -- AB-03: nomor transaksi unik
  CONSTRAINT fk_penjualan_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas),
  CONSTRAINT fk_penjualan_anggota FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota)
) ENGINE=InnoDB;

CREATE TABLE detail_penjualan (
  id_penjualan                   INT           NOT NULL,
  id_barang                      INT           NOT NULL,
  qty_detail_penjualan           SMALLINT      NOT NULL,
  harga_satuan_detail_penjualan  DECIMAL(12,2) NOT NULL,   -- harga saat transaksi disimpan per baris
  CONSTRAINT pk_detail_penjualan PRIMARY KEY (id_penjualan, id_barang),
  CONSTRAINT fk_detail_penjualan FOREIGN KEY (id_penjualan) REFERENCES penjualan (id_penjualan) ON DELETE CASCADE,
  CONSTRAINT fk_detail_barang    FOREIGN KEY (id_barang)    REFERENCES barang (id_barang),
  CONSTRAINT ck_detail_qty   CHECK (qty_detail_penjualan > 0),   -- AB-04: jumlah lebih dari nol
  CONSTRAINT ck_detail_harga CHECK (harga_satuan_detail_penjualan >= 0)
) ENGINE=InnoDB;

-- ===== Pembelian =====

CREATE TABLE pembelian (
  id_pembelian         INT         NOT NULL AUTO_INCREMENT,
  no_faktur_pembelian  VARCHAR(30) NOT NULL,   -- tidak unik: dua pemasok dapat memakai nomor yang sama
  tgl_pembelian        DATE        NOT NULL,
  status_pembelian     ENUM('dipesan','diterima') NOT NULL DEFAULT 'dipesan',   -- status pesanan pembelian
  id_pemasok           INT         NOT NULL,
  CONSTRAINT pk_pembelian PRIMARY KEY (id_pembelian),
  CONSTRAINT fk_pembelian_pemasok FOREIGN KEY (id_pemasok) REFERENCES pemasok (id_pemasok)
) ENGINE=InnoDB;

CREATE TABLE detail_pembelian (
  id_pembelian                 INT           NOT NULL,
  id_barang                    INT           NOT NULL,
  qty_detail_pembelian         SMALLINT      NOT NULL,
  harga_beli_detail_pembelian  DECIMAL(12,2) NOT NULL,
  CONSTRAINT pk_detail_pembelian PRIMARY KEY (id_pembelian, id_barang),
  CONSTRAINT fk_detail_pembelian_faktur FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian) ON DELETE CASCADE,
  CONSTRAINT fk_detail_pembelian_barang FOREIGN KEY (id_barang)    REFERENCES barang (id_barang),
  CONSTRAINT ck_detail_pembelian_qty   CHECK (qty_detail_pembelian > 0),
  CONSTRAINT ck_detail_pembelian_harga CHECK (harga_beli_detail_pembelian >= 0)
) ENGINE=InnoDB;

SHOW TABLES;
