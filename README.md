
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
