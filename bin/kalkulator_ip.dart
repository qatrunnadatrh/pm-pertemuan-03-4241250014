import 'dart:io';

/// Satu mata kuliah yang diinput pengguna (Record bernama).
typedef MataKuliah = ({String nama, int sks, String nilai});

/// Bobot huruf mutu. const: tetap dan diketahui saat kompilasi.
const Map<String, double> bobotNilai = {
  'A': 4.0,
  'B': 3.0,
  'C': 2.0,
  'D': 1.0,
  'E': 0.0,
};

/// Mata kuliah dengan bobot di bawah ini dianggap perlu diperbaiki (D dan E).
const double batasPerbaikan = 2.0;

void main() {
  final daftar = <MataKuliah>[];

  // Input diulang sampai nama MK dikosongkan.
  while (true) {
    final nama = baca('Nama MK');
    if (nama.isEmpty) break;

    try {
      final sks = validasiSks(baca('SKS'));
      final nilai = validasiNilai(baca('Nilai'));
      daftar.add((nama: nama, sks: sks, nilai: nilai));
    } on FormatException catch (e) {
      // Fungsi validasi melempar, main yang menangkap.
      print('Data diabaikan: ${e.message}');
    }
  }

  if (daftar.isEmpty) {
    print('Tidak ada data yang valid.');
    return;
  }

  print('\n=== HASIL ===');
  tampilkan(urutkan(daftar));

  final totalSks = daftar.fold<int>(0, (s, m) => s + m.sks);
  final ip = hitungIp(daftar);
  print('Total SKS : $totalSks');
  print('IP        : ${ip.toStringAsFixed(2)} (${predikat(ip)})');

  final perbaikan = cariPerbaikan(daftar);
  print(
    'Perlu diperbaiki: '
    '${perbaikan.isEmpty ? '-' : perbaikan.map((m) => m.nama).join(', ')}',
  );
}

/// Menampilkan label lalu membaca satu baris; hasil String? dijaga dengan ??.
String baca(String label) {
  stdout.write('${label.padRight(7)} : ');
  return (stdin.readLineSync() ?? '').trim();
}

/// Melempar FormatException bila SKS bukan angka atau di luar 1-6.
int validasiSks(String teks) {
  final sks = int.tryParse(teks);
  if (sks == null || sks < 1 || sks > 6) {
    throw FormatException('SKS harus 1-6');
  }
  return sks;
}

/// Melempar FormatException bila huruf mutu bukan A-E.
String validasiNilai(String teks) {
  final nilai = teks.toUpperCase();
  if (!bobotNilai.containsKey(nilai)) {
    throw FormatException('Nilai harus A, B, C, D, atau E');
  }
  return nilai;
}

/// IP = jumlah(sks x bobot) / jumlah(sks), dihitung dengan fold.
double hitungIp(List<MataKuliah> daftar) {
  final totalSks = daftar.fold<int>(0, (s, m) => s + m.sks);
  if (totalSks == 0) return 0.0;
  final poin = daftar.fold<double>(
    0.0,
    (s, m) => s + m.sks * (bobotNilai[m.nilai] ?? 0.0),
  );
  return poin / totalSks;
}

/// Mengurutkan salinan daftar dengan fungsi pembanding (nilai tertinggi dulu).
List<MataKuliah> urutkan(List<MataKuliah> daftar, {bool menurun = true}) {
  final salinan = [...daftar];
  salinan.sort((a, b) {
    final selisih = (bobotNilai[a.nilai] ?? 0.0).compareTo(
      bobotNilai[b.nilai] ?? 0.0,
    );
    return menurun ? -selisih : selisih;
  });
  return salinan;
}

/// Mata kuliah yang perlu diperbaiki, disaring dengan where.
List<MataKuliah> cariPerbaikan(List<MataKuliah> daftar) =>
    daftar.where((m) => (bobotNilai[m.nilai] ?? 0.0) < batasPerbaikan).toList();

String predikat(double ip) => switch (ip) {
  >= 3.5 => 'Sangat Memuaskan',
  >= 3.0 => 'Memuaskan',
  >= 2.0 => 'Cukup',
  _ => 'Kurang',
};

/// Mencetak daftar mata kuliah; judul opsional lewat parameter bernama.
void tampilkan(List<MataKuliah> daftar, {String judul = ''}) {
  if (judul.isNotEmpty) print(judul);
  // Lebar kolom mengikuti nama terpanjang agar tabel tetap sejajar.
  final lebar = daftar.fold<int>(
    0,
    (l, m) => m.nama.length > l ? m.nama.length : l,
  );
  for (final m in daftar) {
    print('${m.nama.padRight(lebar)}  ${m.sks} SKS  ${m.nilai}');
  }
}
