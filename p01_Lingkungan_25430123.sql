
-- Modul 1: Lingkungan Basis Data
-- NIM: 25430123
-- Tema proyek: Perpustakaan
-- Database proyek: perpus_123
-- Database latihan: kopma_123
-- MariaDB 10.4.x

-- Memeriksa versi server dan akun aktif
SELECT VERSION(), CURRENT_USER();

-- Memeriksa mode SQL
SELECT @@sql_mode;

-- Memeriksa database yang tersedia
SHOW DATABASES;

-- Memeriksa hak akses akun latihan
SHOW GRANTS FOR 'mhs_123'@'localhost';

-- Memeriksa hak akses akun proyek
SHOW GRANTS FOR 'dev_123'@'localhost';

-- Memeriksa hak akses akun tamu
SHOW GRANTS FOR 'tamu_123'@'localhost';
-- Memeriksa database proyek perpustakaan
SHOW CREATE DATABASE perpus_123;