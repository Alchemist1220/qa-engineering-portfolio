/* ============================================================================
   LATIHAN SQL DASAR UNTUK QA ENGINEERING INTERN
   Software: Microsoft SQL Server Management Studio (SSMS)
   Dialek SQL: T-SQL (Microsoft SQL Server)

   TUJUAN
   - Mengambil dan memfilter data dengan SELECT dan WHERE
   - Menggabungkan data dengan INNER JOIN dan LEFT JOIN
   - Menghitung dan mengelompokkan data dengan COUNT, GROUP BY, HAVING
   - Mengurutkan hasil dengan ORDER BY
   - Memeriksa pelanggan yang belum memiliki pesanan (IS NULL)

   CARA MENGGUNAKAN
   1. Buka file ini di SSMS.
   2. Pilih database yang boleh digunakan untuk latihan (misalnya database
      latihan pribadi). Script ini membuat tabel SEMENTARA bernama #customers
      dan #orders; tidak membuat atau mengubah tabel permanen.
   3. Jalankan seluruh script dari bagian SETUP DATA terlebih dahulu, atau
      jalankan seluruh script sekaligus. Setiap query latihan menghasilkan
      result set tersendiri.
   4. Jika hanya ingin menjalankan satu latihan, pastikan bagian SETUP DATA
      sudah dijalankan pada jendela query/session SSMS yang sama.

   CATATAN DATA
   Dataset ini disatukan agar semua latihan memakai contoh yang konsisten.
   Lima pesanan mempertahankan status dan total dari latihan awal. Pelanggan
   Fani (ID 6) ditambahkan khusus untuk latihan LEFT JOIN/IS NULL karena ia
   belum memiliki pesanan.
   ============================================================================ */

/* ============================================================================
   BAGIAN 0 — SETUP DATA LATIHAN
   ============================================================================ */

-- Hapus tabel sementara dari eksekusi sebelumnya jika masih ada di session ini.
IF OBJECT_ID('tempdb..#orders') IS NOT NULL
    DROP TABLE #orders;

IF OBJECT_ID('tempdb..#customers') IS NOT NULL
    DROP TABLE #customers;

-- Membuat tabel pelanggan sementara.
CREATE TABLE #customers (
    customer_id   INT           NOT NULL PRIMARY KEY,
    customer_name VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  NOT NULL
);

-- Membuat tabel pesanan sementara.
CREATE TABLE #orders (
    order_id     INT           NOT NULL PRIMARY KEY,
    customer_id  INT           NOT NULL,
    status       VARCHAR(20)   NOT NULL,
    total        DECIMAL(12,2) NOT NULL
);

-- Memasukkan data pelanggan.
INSERT INTO #customers (customer_id, customer_name, email)
VALUES
    (1, 'Andi',  'andi@example.com'),
    (2, 'Budi',  'budi@example.com'),
    (3, 'Citra', 'citra@example.com'),
    (4, 'Deni',  'deni@example.com'),
    (5, 'Eka',   'eka@example.com'),
    (6, 'Fani',  'fani@example.com');

-- Memasukkan data pesanan.
INSERT INTO #orders (order_id, customer_id, status, total)
VALUES
    (1001, 1, 'COMPLETED',  250000.00),
    (1002, 2, 'PENDING',    175000.00),
    (1003, 3, 'COMPLETED',  320000.00),
    (1004, 4, 'PENDING',     90000.00),
    (1005, 5, 'CANCELLED',  120000.00);

-- Periksa isi tabel. Jalankan bagian ini jika ingin melihat data awal.
SELECT * FROM #customers ORDER BY customer_id;
SELECT * FROM #orders ORDER BY order_id;


/* ============================================================================
   LATIHAN 1 — SELECT dan WHERE
   Tujuan: menampilkan nomor pesanan, status, dan total hanya untuk pesanan
           yang statusnya PENDING.
   ============================================================================ */

SELECT
    o.order_id,
    o.status,
    o.total
FROM #orders AS o
WHERE o.status = 'PENDING';

-- CATATAN:
-- SELECT = kolom yang ingin ditampilkan.
-- FROM   = tabel sumber data.
-- WHERE  = filter untuk memilih baris yang memenuhi kondisi.
-- Tanda petik tunggal digunakan untuk nilai teks: 'PENDING'.
-- Alias o adalah nama singkat untuk tabel #orders.
-- Hasil yang diharapkan: pesanan 1002 dan 1004.


/* ============================================================================
   LATIHAN 2 — INNER JOIN / JOIN
   Tujuan: menampilkan nomor pesanan, nama pelanggan, email, dan total.
   ============================================================================ */

SELECT
    o.order_id,
    c.customer_name,
    c.email,
    o.total
FROM #orders AS o
INNER JOIN #customers AS c
    ON o.customer_id = c.customer_id;

-- CATATAN:
-- INNER JOIN hanya menampilkan baris yang punya pasangan pada kedua tabel.
-- ON menjelaskan bagaimana kedua tabel dihubungkan.
-- Di sini, customer_id pada pesanan dicocokkan dengan customer_id pelanggan.
-- Alias o = #orders; alias c = #customers.
-- Menulis JOIN saja di SQL Server setara dengan INNER JOIN.


/* ============================================================================
   LATIHAN 3 — JOIN + WHERE + ORDER BY
   Tujuan: menampilkan pesanan PENDING dari nomor pesanan terbesar ke terkecil.
   ============================================================================ */

SELECT
    o.order_id,
    c.customer_name,
    o.status
FROM #orders AS o
INNER JOIN #customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'PENDING'
ORDER BY o.order_id DESC;

-- CATATAN:
-- WHERE o.status = 'PENDING' menyaring pesanan sebelum hasil akhir ditampilkan.
-- ORDER BY o.order_id DESC mengurutkan nomor pesanan dari besar ke kecil.
-- DESC = descending (besar ke kecil); ASC = ascending (kecil ke besar).
-- ORDER BY DESC saja tidak lengkap: sebutkan kolom yang mau diurutkan.
-- Hasil yang diharapkan: 1004 (Deni), lalu 1002 (Budi).


/* ============================================================================
   LATIHAN 4 — COUNT(*) + WHERE
   Tujuan: menghitung berapa banyak pesanan yang berstatus PENDING.
   ============================================================================ */

SELECT
    COUNT(*) AS jumlah_pending
FROM #orders AS o
WHERE o.status = 'PENDING';

-- CATATAN:
-- COUNT(*) menghitung jumlah baris yang memenuhi kondisi.
-- AS jumlah_pending memberi nama pada kolom hasil hitungan.
-- Gunakan COUNT(*) untuk menghitung baris; bukan memilih o.order_id biasa.
-- Hasil yang diharapkan: jumlah_pending = 2.


/* ============================================================================
   LATIHAN 5 — GROUP BY
   Tujuan: menghitung jumlah pesanan untuk setiap status.
   ============================================================================ */

SELECT
    o.status,
    COUNT(*) AS jumlah_pesanan
FROM #orders AS o
GROUP BY o.status;

-- CATATAN:
-- GROUP BY menggabungkan baris ke dalam kelompok berdasarkan kolom status.
-- Karena ingin melihat jumlah untuk SETIAP status, tampilkan status dan COUNT(*).
-- Hasil hitungan yang diharapkan:
-- COMPLETED = 2, PENDING = 2, CANCELLED = 1.
-- Tanpa ORDER BY, urutan baris hasil tidak dijamin.


/* ============================================================================
   LATIHAN 6 — GROUP BY + HAVING
   Tujuan: hanya menampilkan status yang memiliki lebih dari satu pesanan.
   ============================================================================ */

SELECT
    o.status,
    COUNT(*) AS jumlah_pesanan
FROM #orders AS o
GROUP BY o.status
HAVING COUNT(*) > 1;

-- CATATAN:
-- WHERE menyaring baris sebelum pengelompokan.
-- HAVING menyaring kelompok setelah GROUP BY, misalnya berdasarkan COUNT(*).
-- Untuk kompatibilitas SQL Server, gunakan HAVING COUNT(*) > 1.
-- SQL Server tidak mengizinkan alias SELECT 'jumlah_pesanan' dipakai langsung
-- di HAVING pada query yang sama. Karena itu gunakan COUNT(*) di HAVING.
-- Hasil yang diharapkan: COMPLETED = 2 dan PENDING = 2.


/* ============================================================================
   LATIHAN 7 — GROUP BY + ORDER BY
   Tujuan: menampilkan hitungan tiap status, dari jumlah terbanyak ke tersedikit.
   ============================================================================ */

SELECT
    o.status,
    COUNT(*) AS jumlah_pesanan
FROM #orders AS o
GROUP BY o.status
ORDER BY jumlah_pesanan DESC;

-- CATATAN:
-- ORDER BY jumlah_pesanan DESC mengurutkan hasil hitungan dari besar ke kecil.
-- Alias yang dibuat pada SELECT bisa digunakan di ORDER BY pada SQL Server.
-- Dua status dapat memiliki hitungan yang sama; urutannya di antara keduanya
-- tidak pasti kecuali ditambahkan pengurutan kedua, misalnya , o.status ASC.


/* ============================================================================
   LATIHAN 8 — GROUP BY + HAVING + ORDER BY
   Tujuan: hanya menampilkan status dengan lebih dari satu pesanan, lalu urutkan
           berdasarkan jumlah pesanan dari terbanyak ke tersedikit.
   ============================================================================ */

SELECT
    o.status,
    COUNT(*) AS jumlah_pesanan
FROM #orders AS o
GROUP BY o.status
HAVING COUNT(*) > 1
ORDER BY jumlah_pesanan DESC;

-- CATATAN:
-- Urutan klausa yang harus ditulis: GROUP BY, lalu HAVING, lalu ORDER BY.
-- HAVING bukan ditulis setelah ORDER BY.
-- Hasil yang diharapkan: COMPLETED = 2 dan PENDING = 2.


/* ============================================================================
   LATIHAN 9 — JOIN + FILTER NILAI + ORDER BY
   Skenario QA: memeriksa pesanan bernilai minimal 200.000.
   Tujuan: tampilkan nomor pesanan, nama pelanggan, dan total; total terbesar
           ditampilkan lebih dahulu.
   ============================================================================ */

SELECT
    o.order_id,
    c.customer_name,
    o.total
FROM #orders AS o
INNER JOIN #customers AS c
    ON o.customer_id = c.customer_id
WHERE o.total >= 200000
ORDER BY o.total DESC;

-- CATATAN:
-- >= berarti lebih besar dari atau sama dengan.
-- COUNT(*) tidak diperlukan karena yang diminta adalah detail tiap pesanan,
-- bukan jumlah baris pesanan.
-- Hasil yang diharapkan: Citra (320000), lalu Andi (250000).


/* ============================================================================
   LATIHAN 10 — LEFT JOIN
   Tujuan: menampilkan SEMUA pelanggan, termasuk yang belum memiliki pesanan.
   ============================================================================ */

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.total
FROM #customers AS c
LEFT JOIN #orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- CATATAN:
-- LEFT JOIN mempertahankan semua baris dari tabel di sebelah kiri (customers).
-- Jika pelanggan tidak punya pesanan yang cocok, kolom dari #orders akan NULL.
-- Pada dataset ini, Fani belum memiliki pesanan sehingga order_id dan total-nya
-- akan NULL.
-- INNER JOIN berbeda: pelanggan tanpa pesanan tidak muncul sama sekali.


/* ============================================================================
   LATIHAN 11 — LEFT JOIN + IS NULL
   Tujuan: mencari pelanggan yang belum pernah membuat pesanan.
   ============================================================================ */

SELECT
    c.customer_id,
    c.customer_name
FROM #customers AS c
LEFT JOIN #orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- CATATAN:
-- IS NULL memeriksa nilai NULL; jangan menulis = NULL.
-- Karena order_id adalah kolom dari tabel pesanan, NULL menunjukkan tidak ada
-- baris pesanan yang cocok untuk pelanggan tersebut.
-- Hasil yang diharapkan: Fani (customer_id = 6).


/* ============================================================================
   RINGKASAN CATATAN PENTING
   ============================================================================ */

/*
1. SELECT       : menentukan kolom atau perhitungan yang ingin ditampilkan.
2. FROM         : menentukan tabel sumber.
3. JOIN / ON    : menggabungkan tabel dan menentukan hubungan antarbaris.
4. WHERE        : menyaring baris sebelum pengelompokan.
5. GROUP BY     : mengelompokkan baris dengan nilai yang sama.
6. HAVING       : menyaring kelompok, sering kali memakai COUNT/SUM/AVG.
7. ORDER BY     : mengurutkan hasil; ASC naik, DESC turun.
8. COUNT(*)     : menghitung jumlah baris.
9. INNER JOIN   : hanya baris dengan pasangan di kedua tabel.
10. LEFT JOIN   : semua baris tabel kiri tetap muncul; yang tidak cocok menjadi NULL.
11. IS NULL     : memeriksa nilai NULL; bukan = NULL.
12. Alias tabel : o dan c adalah nama singkat agar query lebih ringkas.

URUTAN KONSEPTUAL PEMROSESAN QUERY (sederhana):
FROM / JOIN -> ON -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
Urutan ini membantu memahami mengapa WHERE tidak digunakan untuk memfilter
hasil COUNT per kelompok, dan mengapa HAVING dipakai setelah GROUP BY.

CATATAN KHUSUS MICROSOFT SQL SERVER / SSMS:
- SSMS adalah aplikasi untuk menjalankan dan mengelola query SQL Server.
- Sintaks yang digunakan di file ini adalah T-SQL untuk Microsoft SQL Server.
- Gunakan petik tunggal untuk nilai teks, misalnya 'PENDING'.
- Jangan gunakan backtick (`) untuk nama kolom seperti di beberapa sistem lain.
- Tabel dengan awalan # adalah tabel sementara lokal. Tabel tersebut berlaku
  pada session/koneksi yang sama dan akan dibersihkan saat session ditutup.

KESALAHAN YANG PERLU DIHINDARI:
- Salah ketik nama kolom/tabel: order_id, orders, customer_id.
- COUNT(*) AS jumlah_pending menghitung baris; o.order_id AS jumlah_pending
  hanya mengganti nama tampilan kolom order_id dan TIDAK menghitung baris.
- WHERE COUNT(*) > 1 tidak tepat untuk menghitung per kelompok; gunakan
  GROUP BY ... HAVING COUNT(*) > 1.
- ORDER BY DESC tidak lengkap; tulis ORDER BY nama_kolom DESC.
- JOIN tanpa kondisi ON dapat menghasilkan pasangan baris yang tidak diinginkan.
- Filter WHERE pada kolom tabel kanan setelah LEFT JOIN dapat menghilangkan
  baris tanpa pasangan. Untuk mencari yang tidak punya pasangan, gunakan
  LEFT JOIN ... WHERE o.order_id IS NULL.
*/

-- Akhir file latihan SQL dasar untuk QA.
