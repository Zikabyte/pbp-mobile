<div align="center">

# Zikafolio Mobile

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)

Aplikasi portfolio berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform. Dikembangkan oleh Mohammad Zidane Kurnianto (2506584861), Sistem Informasi '25.

**We 💓 Flutter**

</div>

## Setup

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (CI menggunakan versi `3.44.2`, lihat [.github/workflows/analyze.yml](.github/workflows/analyze.yml))
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
