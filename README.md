
# KMStore Mobile

Store for keyboard & mouse mobile version.


# Tugas 7
Berikut jawaban dari Tugas 7

### Stateless Widget dan Stateful Widget
Steteless widget adalah widget yang statenya tidak dapat berubah sama sekali, sehingga stateless widget cocok untuk digunakan sebagai widget yang sifatnya  statis karena bersifat immutable yang dimana lebih ringan jika hanya membutuhkan tampilan yang statis. Sedangkan stateful widget adalah widget yang statenya dapat berubah - ubah, sehingga widget ini cocok digunakan untuk widget yang bertipe dynamic karena sifatnya yang mutable memudahkan kita untuk mengganti state widget tersebut.

### Widget yang digunakan pada KMStore
Widget yang saya gunakan adalah stateless widget dikarenakan kebutuhan app saya yang sifatnya masih statis, sehingga akan lebih efficient jika saya menggunakan widget yang bertipe stateless karena lebih ringan.

### Fungsi setState()
Fungsi setState() digunakan dalam Stateful Widget untuk memberi tahu Flutter bahwa ada perubahan pada state yang memerlukan pembaruan UI. Saat setState() dipanggil, Flutter akan menjalankan ulang build method, sehingga tampilan di layar diperbarui sesuai state terbaru.

### Perbedaan const dengan final
- Const digunakan untuk membuat variabel yang bersifat konstan dan nilainya sudah ditentukan saat waktu kompilasi. Objek yang dideklarasikan sebagai const tidak akan bisa diubah nilainya setelah kompilasi, dan sifatnya adalah konstanta compile-time.

- Final digunakan untuk membuat variabel yang nilainya hanya bisa diinisialisasi satu kali, tetapi nilainya bisa ditentukan saat runtime. Dengan kata lain, variabel final adalah konstanta runtime.

Contoh:
```dart 
const int myConst = 10;
final DateTime myFinalDate = DateTime.now();
```
- nilai myConst adalah 10 dan tidak bisa diubah sejak kompilasi.
- nilai myFinalDate hanya bisa diinisialisasi sekali, tapi nilainya ditentukan saat runtime.

### Cara Implementasi Tugas 7
- Menginisiasi Flutter project
```bash
flutter create kmstore_mobile
```

- Buka vm di Android Studio dan jalankan `flutter run`
```bash
flutter run
```

- Ubah file main.dart untuk mengkonfigurasi layout dari app KMStore
- Untuk page home, saya buat di file menu.dart dimana terdapat 2 class stateless widget untuk container layar dan komponen tombol yang saya buat.

# Tugas 8
Berikut jawaban dari Tugas 8

### Kegunaan const di Flutter
Dalam Flutter, const digunakan untuk membuat objek atau widget yang bersifat konstan atau immutable (tidak berubah). Jika sebuah objek atau widget ditandai dengan const, maka Flutter tahu bahwa objek tersebut tidak akan berubah selama masa pakainya, sehingga objek tersebut hanya perlu dibuat satu kali. Ini sangat bermanfaat dalam meningkatkan efisiensi memori dan performa, karena Flutter tidak perlu membuat ulang objek yang tidak berubah.

- Keuntungan menggunakan const:
Peningkatan Performa: Mengurangi jumlah objek yang dibuat ulang, sehingga mempercepat rendering dan menurunkan konsumsi memori.
Optimasi Hot Reload: Ketika melakukan hot reload, objek const tidak akan di-refresh sehingga mempercepat proses pengembangan.

- Kapan menggunakan const:

Jika widget atau nilai tersebut tidak akan berubah selama masa pakainya, seperti warna, padding, atau teks statis.
- Kapan tidak menggunakan const:

Jika objek tersebut bergantung pada data yang mungkin berubah, seperti state dinamis atau nilai yang diambil dari pengguna.

### Penggunaan Column dan Row pada Flutter
- Column: Widget yang digunakan untuk menyusun elemen-elemen secara vertikal. Biasanya digunakan untuk menumpuk widget di dalam arah vertikal, seperti dalam layout form atau daftar item.

- Row: Widget yang digunakan untuk menyusun elemen-elemen secara horizontal. Biasanya digunakan untuk menyusun elemen di samping satu sama lain, seperti tombol navigasi atau ikon bersama teks.

### Halaman Form pada KMStore
Pada implementasi KMStore Mobile, saya memakai dua form field, yaitu:

- TextFormField
Form Field ini menerima elemen input berupa sebuah string, nantinya akan dilakukan validasi untuk mengecek apakah form tersebut kosong atau tidak. Untuk menerima input angka saya juga menggunakan TextFormField hanya saja saya menambahkan `keyboardType: TextInputType.number,` untuk membuat keyboard hanya bisa mengetik angka saja dan melakukan validasi apakah negatif atau tidak.

- DropdownButtonFormField
Form Field ini saya buat berdasarkan enum yang telah saya deklarasi di luar class. Nantinya user dapat memilih salah satu dari pilihan dropdown tersebut. Form Field ini bagus untuk dipakai jika kita memiliki enum atau datatype yang kita bisa petakan sendiri valuenya, sehingga user akan memilih salah satu dari value tersebut. Oleh karena itu, kita tidak perlu memasang validator dikarenakan tidak pasti salah dan kosong dikarenakan kita dapat mengatur default valuenya.

### Mengatur Tema dalam Flutter
Untuk konsistensi desain, Flutter mendukung penggunaan tema yang dapat diterapkan pada seluruh aplikasi. Saya telah mengatur tema pada widget MaterialApp dengan mengatur properti `theme`. Selanjutnya saya dapat mengatur dengan memasukan `themeData()` yang saya mau seperti berikut:
```dart
theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
    ).copyWith(secondary: Colors.lightBlueAccent),
    useMaterial3: true,
),
```
Disini saya membuat tema warna primary dengan warna biru dan tema warna secondary dengan warna biru muda.

### Navigasi pada Flutter
Pada Flutter saya menggunakan Navigator untuk mengatur transisi antar halaman. Selain itu, saya membuat sidebar yang berfungsi untuk menavigasi user ke berbagai halaman. Pada sidebar tersebut saya menggunakan Class Navigator yang berfungsi untuk memindahkan user ke halaman lain. Berikut salah satu contoh implementasi saya:
```dart
ListTile(
  leading: const Icon(Icons.keyboard),
  title: const Text('Tambah Keyboard'),
  // Jika dipencet, akan memindahkan ke page KeyboardFormPage()
  onTap: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const KeyboardFormPage(),
    ));
  },
),
```