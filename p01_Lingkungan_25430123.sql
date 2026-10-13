```sql
-- =========================================================
-- MODUL 1: LINGKUNGAN BASIS DATA
-- Nama       : Rizqi Tri Haryadi
-- NIM        : 25430123
-- Tema       : Perpustakaan
-- Database   : perpus_123
-- Database latihan : kopma_123
-- DBMS       : MariaDB 10.4.x
-- =========================================================

-- Skrip ini dijalankan menggunakan akun root.
-- Skrip tidak menghapus database atau akun yang sudah ada.
-- Skrip tidak menyimpan kata sandi dalam berkas.

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
-- 2. PEMERIKSAAN LINGKUNGAN SERVER
-- =========================================================

SELECT VERSION(), CURRENT_USER();

SELECT @@sql_mode;

SHOW DATABASES;


-- =========================================================
-- 3. PEMERIKSAAN KONFIGURASI DATABASE
-- =========================================================

SHOW CREATE DATABASE kopma_123;

SHOW CREATE DATABASE perpus_123;


-- =========================================================
-- 4. PEMERIKSAAN HAK AKSES AKUN
-- =========================================================

SHOW GRANTS FOR 'mhs_123'@'localhost';

SHOW GRANTS FOR 'dev_123'@'localhost';

SHOW GRANTS FOR 'tamu_123'@'localhost';


-- =========================================================
-- AKHIR SKRIP MODUL 1
-- =========================================================
```