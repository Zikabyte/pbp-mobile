<div align="center">

# Zikafolio Mobile

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)

Aplikasi portfolio berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform. Dikembangkan oleh Mohammad Zidane Kurnianto (2506584861), Sistem Informasi '25.

**We 💓 Flutter**

</div>

## Setup

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (CI menggunakan versi `3.47.9`, lihat [.github/workflows/analyze.yml](.github/workflows/analyze.yml))
- Device, emulator, atau simulator yang sudah terhubung

### Installation

```bash
git clone <repo-url>
cd portfolio_mobile
flutter pub get
```

### Running

```bash
flutter run
```

### Analyze & Test

```bash
flutter analyze
flutter test
```

## Struktur Folder

Proyek ini mengikuti arsitektur **feature-based dan sedikit terinspirasi dari _clean architecture_**.

```
lib/
├── core/                 # Kode bersama yang dipakai lintas fitur (utils, constants, services, dll.)
└── features/
    ├── [feature]/
    │   ├── data/
    │   ├── pages/
    │   └── widgets/
    └── example/          # Template skeleton untuk fitur baru (data/pages/widgets)
```

## Pertanyaan Reflektif

### Tugas 7

> _By the way,_ home screen ada di file [lib/features/home/pages/home_page.dart](lib/features/home/pages/home_page.dart) ya kak :)

1. Di Flutter, "_everything is a widget_" (sebenarnya hampir semuanya sih hehe), mulai dari elemen visual seperti teks dan tombol sampai pengaturan tata letak seperti padding dan alignment. Widget tree adalah struktur hierarki yang menggambarkan susunan seluruh widget tersebut untuk membentuk antarmuka aplikasi secara utuh.

   Hubungan _parent-child_ antar-widget bekerja lewat konsep _composition_ dan pewarisan _constraints_:
   - **Composition:** Sebuah _parent widget_ membungkus satu atau beberapa child untuk mengatur posisi, gaya, atau perilakunya. Misalnya, `Scaffold` membungkus `Column`, lalu `Column` membungkus `Text` dan `ElevatedButton`.
   - **Constraints:** Parent widget mengirimkan batasan ukuran (lebar dan tinggi minimum maupun maksimum) ke child di bawahnya. Child lalu menentukan ukurannya sendiri sesuai batasan tersebut.

2. Berikut widget yang dipakai di proyek ini beserta fungsinya masing-masing:
   - **`MaterialApp`**: root widget aplikasi, menyediakan tema, judul, dan konfigurasi Material Design secara global.
   - **`Scaffold`**: menyediakan struktur dasar halaman seperti `AppBar`, `body`, dan `SnackBar`.
   - **`AppBar`**: menampilkan bar judul di bagian atas halaman.
   - **`SafeArea`**: menjaga konten agar tidak tertutup elemen sistem seperti notch atau status bar.
   - **`SingleChildScrollView`**: membuat konten bisa di-_scroll_ ketika tingginya melebihi layar.
   - **`Column`**: menyusun widget secara vertikal.
   - **`Row`**: menyusun widget secara horizontal.
   - **`IntrinsicHeight`**: menyamakan tinggi antar-child dalam `Row` sesuai tinggi intrinsiknya.
   - **`Expanded`**: membagi ruang kosong pada `Row` secara proporsional ke child-nya.
   - **`Center`**: memusatkan posisi child di dalam parent-nya.
   - **`Container`**: membungkus widget lain sambil mengatur ukuran, padding, margin, atau dekorasi seperti warna dan border.
   - **`Padding`**: memberi jarak kosong di sekeliling child.
   - **`SizedBox`**: memberi jarak atau ukuran tetap, dipakai sebagai spasi antar-elemen.
   - **`CircleAvatar`**: menampilkan gambar atau ikon dalam bentuk lingkaran, dipakai untuk foto profil.
   - **`Icon`**: menampilkan simbol ikon.
   - **`Text`**: menampilkan teks.
   - **`GridView`**: menyusun widget dalam tata letak kisi (_grid_), dipakai untuk menampilkan kartu menu.
   - **`Material`**: menyediakan properti visual Material Design seperti warna dan bayangan (_elevation_) pada permukaan widget.
   - **`InkWell`**: menangkap aksi sentuh dan menampilkan efek riak (_ripple_) saat ditekan.
   - **`SnackBar`**: menampilkan notifikasi singkat di bagian bawah layar setelah suatu aksi dilakukan.

3. `MaterialApp` adalah widget tingkat atas yang menyediakan berbagai konfigurasi dan layanan inti untuk aplikasi berbasis Material Design.

   Widget ini umumnya dijadikan _root widget_ karena menyediakan fondasi global yang dibutuhkan oleh halaman-halaman di bawahnya, antara lain:
   - Routing dan Navigasi
   - Theming
   - Lokalisasi dan Aksesibilitas

4. Perbedaan utama keduanya terletak pada apakah tampilan widget bisa berubah setelah dibuat atau tidak:
   - **`StatelessWidget`:** Bersifat statis (_immutable_). Tampilannya sepenuhnya bergantung pada data atau parameter yang dikirim saat widget dibuat. Tampilannya hanya berubah kalau parent widget _rebuild_ dirinya dengan parameter baru.
   - **`StatefulWidget`:** Tampilannya dinamis (_mutable_) karena dipasangkan dengan sebuah objek `State` terpisah yang menyimpan data yang bisa berubah. Ketika data di dalam `State` diubah dan fungsi `setState()` dipanggil, Flutter akan menjalankan ulang metode `build()` untuk memperbarui tampilan di layar sesuai data terbaru.

   Kapan memilih masing-masing:
   - Pakai **`StatelessWidget`** untuk komponen UI yang tampilannya murni bergantung pada data statis atau kiriman dari parent, seperti judul halaman, ikon statis, atau card informasi proyek yang datanya sudah tetap. Ini lebih ringan karena tidak perlu mengelola objek `State`.
   - Pakai **`StatefulWidget`** ketika widget perlu merespons interaksi user atau perubahan data internal secara langsung dan memperbarui UI-nya sendiri, seperti counter angka.

5. `BuildContext` adalah objek referensi yang menunjukkan **posisi spesifik sebuah widget di dalam widget tree**. Setiap widget punya `BuildContext`-nya sendiri yang dikirim otomatis sebagai parameter ke dalam metode `build(BuildContext context)`.

   Keberadaannya penting karena sebuah widget tidak tahu di mana posisinya berada di pohon hierarki tanpa `BuildContext`. Di dalam metode `build`, `BuildContext` dipakai untuk menelusuri widget tree ke arah atas (_ancestor_) guna mengambil data atau layanan bersama yang disediakan oleh parent widget, contohnya:
   - Mengambil pengaturan tema terdekat: `Theme.of(context).colorScheme.primary`
   - Mengecek ukuran layar perangkat: `MediaQuery.of(context).size`

6. **Hot Reload** adalah fitur di Flutter yang "menyuntikkan" file kode Dart yang baru diubah langsung ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Setelah kode diperbarui, Flutter otomatis membangun ulang widget tree sehingga perubahan UI langsung muncul di layar dalam hitungan detik, **tanpa mereset state aplikasi yang sedang aktif**.

   Perbedaannya dengan **Hot Restart** ada pada nasib state aplikasi:
   - **Hot Reload** mempertahankan state (misalnya sedang berada di halaman ketiga dan form sudah terisi setengah, perubahan warna tombol langsung terlihat tanpa keluar dari halaman tersebut).
   - **Hot Restart** menghapus seluruh state yang tersimpan di memori, mengompilasi ulang kode dari awal, dan menjalankan ulang fungsi `main()`, sehingga aplikasi kembali ke halaman awal dalam keadaan bersih.

   **Kapan Hot Reload tidak cukup dan harus melakukan Hot Restart atau Full Restart:**
   - **Harus Hot Restart:** Ketika mengubah kode yang tidak ikut dieksekusi ulang saat _rebuild_ widget tree biasa, seperti perubahan di dalam `main()`, `initState()`, `dispose()`, variabel global atau `static`, nilai awal pada konstruktor `State`, atau mengubah jenis widget dari `StatelessWidget` ke `StatefulWidget` (maupun sebaliknya).
   - **Harus Full Restart (Stop lalu Run ulang dari awal):** Ketika melakukan perubahan di luar kode Dart, seperti mengedit kode native platform (Kotlin/Java di folder `android/` atau Swift/Objective-C di folder `ios/`), mengubah konfigurasi `.env`, atau menambah atau mengubah library di `pubspec.yaml` yang memiliki kode native.

#### AI Disclosure: Tugas 7

AI digunakan hanya untuk styling dan writing widget testing. Kerangka `core/theme` dan struktur folder mengikuti proyek mobile saya sebelumnya.

##### Tools yang Digunakan

- Claude Code: digunakan untuk styling.
  > Catatan: Log penggunaan Claude Code disediakan di folder `logs/`

##### Bagian Spesifik yang Dibantu AI

1. Restyle home page
2. Widget testing home page

##### Strategi Prompting

- Menjalankan Claude Code dalam manual approval mode (bukan auto-accept), sehingga setiap perubahan/edit yang diajukan AI harus ditinjau dan disetujui secara eksplisit satu per satu.
- Semua kode hasil AI ditinjau dan diuji secara manual sebelum di-commit.
- Mengerjakan feature yang diminta tugas sendiri (tanpa bantuan AI).
