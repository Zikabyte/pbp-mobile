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

### Tugas 8

> Formulir Project ada di [lib/features/projects/pages/project_form.dart](lib/features/projects/pages/project_form.dart), formulir Experience ada di [lib/features/experiences/pages/experience_form.dart](lib/features/experiences/pages/experience_form.dart).

1. Ketiganya sama-sama mengubah stack navigasi, tetapi dengan cara yang berbeda:
   - **`Navigator.push()`**: menaruh halaman baru di atas halaman yang sedang aktif tanpa menghapus halaman tersebut dari stack. Halaman lama tetap tersimpan sehingga pengguna bisa kembali ke sana.
   - **`Navigator.pushReplacement()`**: menaruh halaman baru sekaligus menghapus halaman yang sedang aktif dari stack. Halaman yang digantikan tidak bisa dicapai lagi lewat tombol kembali karena sudah dibuang.
   - **`Navigator.pop()`**: menghapus halaman paling atas dari stack dan mengembalikan tampilan ke halaman yang ada di bawahnya.

   Metode yang dipakai untuk membuka formulir dari kartu aksi di halaman utama adalah **`Navigator.push()`**, sebab halaman utama harus tetap ada di stack supaya pengguna bisa kembali ke sana setelah selesai mengisi atau membatalkan formulir.

   Opsi Home di drawer memakai **`Navigator.pushReplacement()`** menuju `MyHomePage`. Alasannya, opsi Home bisa dipanggil dari halaman mana pun lewat drawer yang sama, jadi kalau dipakai `push()` biasa, stack bisa menumpuk banyak salinan halaman utama kalau pengguna bolak-balik. Dengan `pushReplacement()`, halaman aktif (apa pun itu) langsung diganti oleh satu `MyHomePage`, sehingga stack tetap bersih.

2. `Scaffold` menyediakan kerangka visual yang sama di setiap halaman (posisi `AppBar` di atas, `body` di tengah, `drawer` yang bisa dibuka dari sisi kiri), sehingga pengguna tidak perlu mempelajari ulang tata letak setiap kali berpindah halaman. Karena `AppBar` dan `Drawer` dipasang lewat parameter `Scaffold` yang sama persis di halaman utama, formulir Project, dan formulir Experience, perilaku navigasinya pun otomatis konsisten di ketiga halaman tersebut.

   Contoh pemakaian warna tema di lebih dari satu halaman: `BaseColors.primary` dipakai sebagai warna latar `AppBar` di halaman utama (lewat `colorScheme.primary` yang memang di-seed dari warna yang sama), formulir Project, dan formulir Experience, serta sebagai warna latar `DrawerHeader` pada `LeftDrawer` yang dipakai bersama oleh ketiga halaman itu.

3. Formulir disusun sebagai satu `Column` vertikal berisi input yang dibungkus `Form` dan `SingleChildScrollView`, karena urutan pengisiannya memang linear dari atas ke bawah (judul, deskripsi, kategori, tautan, tanggal) sehingga lebih wajar dibaca dan diisi satu per satu ketimbang disusun berdampingan.

   Widget pengatur jarak seperti `Padding` pada tiap input dan `SizedBox` di antara elemen menjaga supaya antar-input tidak saling menempel dan tetap nyaman dibaca. Widget penggulir (`SingleChildScrollView`) berperan penting ketika ruang layar terbatas, misalnya saat papan ketik muncul dan menutup sebagian besar tinggi layar. Tanpa widget ini, input atau tombol Simpan di bagian bawah formulir bisa terpotong atau memicu error overflow karena kontennya lebih tinggi dari layar yang tersedia. Dengan `SingleChildScrollView`, seluruh isi formulir tetap bisa dijangkau dengan cara digulir, berapa pun ukuran layarnya atau apakah papan ketik sedang tampil atau tidak.

4. - **`GlobalKey<FormState>`**: identitas unik yang menghubungkan tombol Simpan dengan widget `Form` tertentu, supaya kode di luar `Form` (seperti `onPressed` pada tombol) bisa mengakses `FormState` miliknya dan memanggil method seperti `validate()` atau `reset()`.
   - **`validator`**: fungsi yang didaftarkan pada tiap `TextFormField` untuk memeriksa apakah nilai yang diisi memenuhi aturan tertentu. Fungsi ini mengembalikan `null` kalau nilainya valid, atau sebuah `String` pesan kesalahan kalau tidak valid.
   - **`validate()`**: method pada `FormState` yang menjalankan seluruh `validator` dari semua `TextFormField` di dalam `Form` tersebut sekaligus. Hasilnya `true` kalau semua input valid, `false` kalau ada satu saja yang tidak valid, dan pesan kesalahan dari `validator` yang gagal otomatis muncul di bawah kolom terkait.

   Jadi saat tombol Simpan ditekan, `_formKey.currentState!.validate()` dipanggil lebih dulu. Kalau hasilnya `true`, baru `showDialog()` dijalankan untuk menampilkan ringkasan. Kalau `false`, dialog tidak muncul dan pengguna langsung melihat pesan kesalahan pada kolom yang bermasalah.

   Contoh nilai yang ditolak: pada formulir Experience, kolom Judul Pengalaman menolak nilai kosong atau yang hanya berisi spasi (misalnya `"   "`) karena `validator`-nya memeriksa `value.trim().isEmpty`. Kolom Tautan Thumbnail juga menolak nilai seperti `"bukan-url"` karena tidak diawali `http://` atau `https://`.

   Memilih jenis input atau papan ketik saja (misalnya mengatur `keyboardType` ke `TextInputType.url`) belum cukup, sebab jenis papan ketik hanya memengaruhi tombol apa yang ditampilkan pada papan ketik virtual, bukan memvalidasi isinya. Pengguna tetap bisa mengetik apa saja walaupun papan ketiknya diatur untuk URL, termasuk membiarkannya kosong, mengisi spasi, atau mengetik teks dengan format yang salah. Validasi lewat `validator` tetap dibutuhkan untuk benar-benar memeriksa isi akhirnya sebelum data dianggap sah.

#### AI Disclosure: Tugas 8

##### Tools yang Digunakan

- Claude Code: digunakan untuk widget testing, dan bug fixing.
  > Catatan: Log penggunaan Claude Code disediakan di folder `logs/`

##### Bagian Spesifik yang Dibantu AI

1. Penyesuaian formulir Experience (field, validasi, dialog ringkasan) berdasarkan model Experience di Django
2. Widget testing untuk navigasi dan validasi formulir

##### Strategi Prompting

- Menjalankan Claude Code dalam manual approval mode (bukan auto-accept), sehingga setiap perubahan/edit yang diajukan AI harus ditinjau dan disetujui secara eksplisit satu per satu.
- Semua kode hasil AI ditinjau dan diuji (`flutter analyze` serta `flutter test`) sebelum di-commit.
