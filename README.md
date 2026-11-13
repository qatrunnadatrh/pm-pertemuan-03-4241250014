# pm-pertemuan-03-4241250014
Tugas Rutin 3: Kalkulator IP (Dart) oleh Qatrunnada Athirah Herdiyanto (4241250014), kelas PSIK 24C.

## Cara menjalankan
```bash
dart run bin/kalkulator_ip.dart
```
Isi Nama MK, SKS, dan Nilai. Kosongkan Nama MK (tekan Enter) untuk selesai.

## Fitur
- **Input:** diulang dengan `while` sampai nama MK kosong.
- **Fungsi:** `baca`, `validasiSks`, `validasiNilai`, `hitungIp`, `urutkan`, `cariPerbaikan`, `predikat`, `tampilkan`. Parameter bernama dipakai di `urutkan({menurun})` dan `tampilkan({judul})`.
- **Validasi:** SKS harus 1-6 dan nilai A-E. Fungsi validasi melempar `FormatException`, `main` menangkapnya.
- **Hitung:** IP dengan `fold`; MK yang perlu diperbaiki (nilai D/E) disaring dengan `where`.
- **Urut:** `sort` dengan fungsi pembanding berdasarkan bobot nilai, tertinggi dulu.

## Sesi 1: dengan input salah
```
Nama MK : Pemrograman Mobile
SKS     : 3
Nilai   : A
Nama MK : Jaringan Komputer
SKS     : tiga
Data diabaikan: SKS harus 1-6
Nama MK : Statistika
SKS     : 2
Nilai   : Z
Data diabaikan: Nilai harus A, B, C, D, atau E
Nama MK : Etika Profesi
SKS     : 2
Nilai   : D
Nama MK : Basis Data
SKS     : 2
Nilai   : B
Nama MK :

=== HASIL ===
Pemrograman Mobile    3 SKS  A
Basis Data            2 SKS  B
Etika Profesi         2 SKS  D
Total SKS : 7
IP        : 2.86 (Cukup)
Perlu diperbaiki: Etika Profesi
```

## Sesi 2: SKS di luar rentang, huruf kecil
```
Nama MK : Algoritma
SKS     : 0
Data diabaikan: SKS harus 1-6
Nama MK : Algoritma
SKS     : 4
Nilai   : a
Nama MK :

=== HASIL ===
Algoritma             4 SKS  A
Total SKS : 4
IP        : 4.00 (Sangat Memuaskan)
Perlu diperbaiki: -
```

## Higher-Order Function (HOF)
HOF adalah fungsi yang menerima atau mengembalikan fungsi lain.
- `fold` menerima fungsi untuk mengakumulasi: total SKS dan total poin (SKS x bobot) pada `hitungIp`.
- `where` menerima fungsi penyaring `(m) => bobot < 2.0` untuk mencari MK yang perlu diperbaiki.
- `sort` menerima fungsi pembanding `(a, b) => ...` pada `urutkan`.

## Error handling
- `validasiSks` dan `validasiNilai` **melempar** `FormatException` bila input salah. Ini Exception (kondisi yang bisa diantisipasi), bukan Error (bug logika).
- `main` **menangkap** dengan `try ... on FormatException catch (e)`, mencetak pesan ramah, lalu input berlanjut. Program tidak crash.
- `int.tryParse` dipakai agar teks seperti "tiga" menghasilkan `null`, lalu diubah menjadi `FormatException` dengan pesan yang jelas.

## Kendala & Solusi
1. **Kendala:** <isi kendala nyata yang kamu alami>
   **Solusi:** <solusinya>
## Cara menjalankan
```bash
dart run bin/kalkulator_ip.dart
```
Isi Nama MK, SKS, dan Nilai. Kosongkan Nama MK (tekan Enter) untuk selesai.

## Fitur
- **Input:** diulang dengan `while` sampai nama MK kosong.
- **Fungsi:** `baca`, `validasiSks`, `validasiNilai`, `hitungIp`, `urutkan`, `cariPerbaikan`, `predikat`, dan `tampilkan`. Parameter bernama dipakai di `urutkan({menurun})` dan `tampilkan({judul})`.
- **Validasi:** SKS harus 1-6 dan nilai A-E. Fungsi validasi melempar `FormatException`, lalu `main` menangkapnya.
- **Hitung:** IP dihitung dengan `fold`; mata kuliah yang perlu diperbaiki (nilai D atau E) disaring dengan `where`.
- **Urut:** `sort` dengan fungsi pembanding berdasarkan bobot nilai, tertinggi lebih dulu.
- **Predikat:** IP >= 3.5 Sangat Memuaskan, >= 3.0 Memuaskan, >= 2.0 Cukup, selain itu Kurang.

## Sesi 1: dengan input salah
```
Nama MK : keamanan data dan jaringan
SKS     : 3
Nilai   : A
Nama MK : pemrograman mobile
SKS     : 0
Data diabaikan: SKS harus 1-6
Nama MK : pemrograman mobile
SKS     : 3
Nilai   : B
Nama MK : algoritma optimasi dan metaheuristik
SKS     : 1
Nilai   : Z
Data diabaikan: Nilai harus A, B, C, D, atau E
Nama MK : pengenalan pola
SKS     : 3
Nilai   : D
Nama MK : 

=== HASIL ===
keamanan data dan jaringan  3 SKS  A
pemrograman mobile          3 SKS  B
pengenalan pola             3 SKS  D
Total SKS : 9
IP        : 2.67 (Cukup)
Perlu diperbaiki: pengenalan pola
```
SKS `0` dan nilai `Z` ditolak dengan pesan yang jelas, program tidak crash dan input berlanjut. Mata kuliah bernilai D muncul di baris "Perlu diperbaiki".

## Sesi 2: semua input valid
```
Nama MK : internet of things
SKS     : 3
Nilai   : B
Nama MK : pemodelan dan simulasi
SKS     : 3
Nilai   : B
Nama MK : metode penelitian
SKS     : 3
Nilai   : A
Nama MK : pengembangan web modern
SKS     : 3
Nilai   : A
Nama MK : 

=== HASIL ===
metode penelitian        3 SKS  A
pengembangan web modern  3 SKS  A
internet of things       3 SKS  B
pemodelan dan simulasi   3 SKS  B
Total SKS : 12
IP        : 3.50 (Sangat Memuaskan)
Perlu diperbaiki: -
```
Daftar terurut dari nilai tertinggi. Tidak ada nilai D atau E, sehingga baris "Perlu diperbaiki" berisi `-`.

## Higher-Order Function (HOF)
HOF adalah fungsi yang menerima atau mengembalikan fungsi lain.
- `fold` menerima fungsi untuk mengakumulasi: total SKS dan total poin (SKS x bobot) pada `hitungIp`.
- `where` menerima fungsi penyaring `(m) => bobot < 2.0` pada `cariPerbaikan` untuk mencari mata kuliah yang perlu diperbaiki.
- `sort` menerima fungsi pembanding `(a, b) => ...` pada `urutkan` untuk mengurutkan berdasarkan bobot nilai.

## Error handling
- `validasiSks` dan `validasiNilai` **melempar** `FormatException` bila input salah. Ini Exception (kondisi yang dapat diantisipasi), bukan Error (bug logika).
- `main` **menangkap** dengan `try ... on FormatException catch (e)`, mencetak pesan ramah, lalu input berlanjut. Program tidak crash.
- `int.tryParse` dipakai agar teks seperti "tiga" menghasilkan `null`, lalu diubah menjadi `FormatException` dengan pesan yang jelas.
- `stdin.readLineSync() ?? ''` menjaga agar hasil `String?` tidak menyebabkan error null.

## Kendala & Solusi
1. **Kendala:** Saat pertama dijalankan muncul pesan `File truncated before or at offset 0x0` dan `Invoked Dart programs must have a 'main' function defined`, karena file `kalkulator_ip.dart` masih kosong (0 byte) dan kode belum ditempel.
   **Solusi:** Mengecek ukuran file dengan `dir bin`, lalu menempelkan kode lengkap dan menyimpannya dengan Ctrl+S.
2. **Kendala:** Tabel hasil tidak sejajar ketika nama mata kuliah panjang, karena lebar kolom nama dibuat tetap (22 karakter).
   **Solusi:** Menghitung lebar kolom dari nama terpanjang dengan `fold`, lalu memakainya pada `padRight`.

## Pernyataan Penggunaan AI
Saya menggunakan Claude  untuk membantu menyusun kode. Saya sudah menjalankan, menguji, dan memahami kode tersebut.