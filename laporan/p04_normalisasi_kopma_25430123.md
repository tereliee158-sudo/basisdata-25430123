# Normalisasi Kopma - Pertemuan 4

**Nama:** Rizqi Tri Haryadi    **NIM:** 25430123

## 1. Relasi UNF

Satu nota menyimpan grup berulang barang.

```
NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas,
          no_anggota, nama_anggota,
          { kode_barang, nama_barang, qty_detail_penjualan,
            harga_satuan_detail_penjualan, subtotal_detail_penjualan },
          jumlah_penjualan, diskon_penjualan, total_penjualan)
```

## 2. UNF ke 1NF

Grup berulang dihilangkan: satu baris untuk setiap barang pada setiap nota. Satu nota kini muncul di banyak baris, sehingga kunci primernya gabungan dua kolom.

```
NOTA_1NF (no_nota_penjualan, kode_barang, tgl_penjualan, kode_petugas,
          nama_petugas, no_anggota, nama_anggota, nama_barang,
          qty_detail_penjualan, harga_satuan_detail_penjualan,
          subtotal_detail_penjualan, jumlah_penjualan,
          diskon_penjualan, total_penjualan)
Kunci primer: (no_nota_penjualan, kode_barang)
```

## 3. Dependensi fungsional (dari aturan bisnis)

| FD | Dependensi | Dasar |
|---|---|---|
| FD1 | no_nota_penjualan -> tgl_penjualan, kode_petugas, no_anggota | AB-01 |
| FD2 | kode_petugas -> nama_petugas | data petugas |
| FD3 | no_anggota -> nama_anggota | AB-05 |
| FD4 | kode_barang -> nama_barang | data barang |
| FD5 | (no_nota_penjualan, kode_barang) -> qty_detail_penjualan, harga_satuan_detail_penjualan | AB-04 |
| FD6 | qty_detail_penjualan, harga_satuan_detail_penjualan -> subtotal_detail_penjualan | turunan |

FD yang sengaja tidak dipakai: `kode_barang -> harga_satuan_detail_penjualan`. Menurut AB-04 harga di nota tetap meski harga barang kemudian naik, jadi harga di nota tidak ditentukan oleh kode barang saja.

## 4. Menuju 2NF

FD1 hanya bergantung pada sebagian kunci (nota) dan FD4 hanya pada sebagian kunci (barang). Keduanya dipisah:

- `penjualan` (kunci: no_nota_penjualan)
- `barang` (kunci: kode_barang)
- `detail_penjualan` (kunci: no_nota_penjualan, kode_barang) berisi qty dan harga satuan.

## 5. Menuju 3NF

Pada `penjualan` terdapat rantai:

- no_nota_penjualan -> kode_petugas -> nama_petugas
- no_nota_penjualan -> no_anggota -> nama_anggota

Nama petugas dan nama anggota dipindahkan ke relasi `petugas` dan `anggota`.

## 6. Keputusan nilai turunan

`subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, dan `total_penjualan` tidak disimpan di tabel operasional. Semuanya dapat dihitung dari qty, harga satuan di detail, dan status anggota (AB-02). Dengan tidak menyimpannya, nilai-nilai itu tidak mungkin tidak konsisten dengan data sumbernya.

## 7. Hasil 3NF

```
PENJUALAN        (no_nota_penjualan, tgl_penjualan, kode_petugas*, no_anggota*, bayar_penjualan)
DETAIL_PENJUALAN (no_nota_penjualan*, kode_barang*, qty_detail_penjualan, harga_satuan_detail_penjualan)
BARANG           (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang)
PETUGAS          (kode_petugas, nama_petugas, peran_petugas)
ANGGOTA          (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota)
-- kunci primer: kolom pertama / pasangan kolom kunci; * = kunci tamu
```

## 8. Tabel tahapan UNF -> 1NF -> 2NF -> 3NF

| Tahap | Relasi hasil | Masalah yang dihilangkan |
|---|---|---|
| UNF | NOTA_UNF | - |
| 1NF | NOTA_1NF (kunci komposit) | grup berulang barang |
| 2NF | penjualan, barang, detail_penjualan | atribut yang hanya bergantung pada sebagian kunci |
| 3NF | penjualan, detail_penjualan, barang, petugas, anggota | rantai nota -> petugas -> nama, nota -> anggota -> nama |

## 9. Perbandingan dengan skema kanonik (Tabel 4.2)

Hasil di atas sama dengan skema kanonik dalam hal pemisahan tabel. Perbedaannya:

- Skema kanonik memakai kunci pengganti `id_*` sebagai kunci primer, sedangkan kode alami (`kode_petugas`, `no_anggota`, `nim_anggota`, `kode_barang`, `no_nota_penjualan`) menjadi kunci unik.
- Skema kanonik memiliki tabel tambahan `pemasok`, `pembelian`, dan `detail_pembelian` untuk proses pembelian, yang belum muncul pada spreadsheet penjualan di modul ini.
- `id_anggota` pada `penjualan` boleh NULL (penjualan tanpa anggota, AB-02).

## 10. Pemeriksaan BCNF

| Tabel | Penentu | Kunci kandidat? | Hasil |
|---|---|---|---|
| penjualan | no_nota_penjualan | ya (kunci primer) | BCNF |
| detail_penjualan | (no_nota_penjualan, kode_barang) | ya (kunci primer) | BCNF |
| barang | kode_barang | ya (kunci primer) | BCNF |
| petugas | kode_petugas | ya (kunci primer) | BCNF |
| anggota | no_anggota dan nim_anggota | ya, keduanya kunci kandidat (AB-05) | BCNF |

Tidak ditemukan penentu yang bukan kunci kandidat, sehingga kelima tabel memenuhi BCNF. Kunci pengganti `id_*` tidak mengubah hasil ini karena pemeriksaan tetap dilakukan pada kunci alami.
