-- =========================================================
-- MODUL 1: LINGKUNGAN BASIS DATA
-- Nama              : Rizqi Tri Haryadi
-- NIM               : 25430123
-- Tema              : Perpustakaan
-- Database proyek   : perpus_123
-- Database latihan  : kopma_123
-- DBMS              : MariaDB 10.4.x
-- =========================================================

-- Jalankan menggunakan akun root.
-- Skrip tidak menghapus database atau akun.
-- Kata sandi tidak disimpan dalam berkas ini.

-- =========================================================
-- 1. PENYIAPAN DATABASE
-- =========================================================

CREATE DATABASE IF NOT EXISTS kopma_123
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS perpus_123
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- =========================================================
-- 2. PENYIAPAN AKUN
-- =========================================================

CREATE USER IF NOT EXISTS 'mhs_123'@'localhost';

CREATE USER IF NOT EXISTS 'dev_123'@'localhost';

CREATE USER IF NOT EXISTS 'tamu_123'@'localhost';

-- =========================================================
-- 3. PENGATURAN HAK AKSES
-- =========================================================

-- Mahasiswa: seluruh hak akses pada database latihan.
GRANT ALL PRIVILEGES ON kopma_123.*
    TO 'mhs_123'@'localhost';

-- Pengembang: seluruh hak akses pada database proyek.
GRANT ALL PRIVILEGES ON perpus_123.*
    TO 'dev_123'@'localhost';

-- Tamu: hanya hak membaca data pada database latihan.
GRANT SELECT ON kopma_123.*
    TO 'tamu_123'@'localhost';

-- =========================================================
-- 4. PEMERIKSAAN LINGKUNGAN SERVER
-- =========================================================

SELECT VERSION(), CURRENT_USER();

SELECT @@sql_mode;

SHOW DATABASES;

-- =========================================================
-- 5. PEMERIKSAAN KONFIGURASI DATABASE
-- =========================================================

SHOW CREATE DATABASE kopma_123;

SHOW CREATE DATABASE perpus_123;

-- =========================================================
-- 6. PEMERIKSAAN HAK AKSES AKUN
-- =========================================================

SHOW GRANTS FOR 'mhs_123'@'localhost';

SHOW GRANTS FOR 'dev_123'@'localhost';

SHOW GRANTS FOR 'tamu_123'@'localhost';

-- =========================================================
-- AKHIR SKRIP MODUL 1
-- =========================================================