
# KMStore Mobile

Store for keyboard & mouse mobile version.


## Tugas 9
Berikut jawaban dari Tugas 9

### Model untuk Pengambilan atau Pengiriman Data JSON
- Struktur Data yang Terdefinisi
Model membantu mendefinisikan struktur data yang diterima atau dikirim, sehingga data lebih mudah dikelola dan dimanipulasi. Contohnya, sebuah model dapat memiliki properti seperti id, name, dan price, sehingga data dapat diakses dengan cara yang lebih terorganisir, seperti product.name.

- Type Safety (Keamanan Tipe Data)
Dengan model, tipe data setiap properti dapat ditentukan. Ini membantu mencegah kesalahan runtime akibat tipe data yang tidak sesuai, seperti mencoba melakukan operasi matematika pada data bertipe string.

- Kemudahan Parsing
Model mempermudah proses konversi data dari/ke JSON (serialization dan deserialization). Dalam Flutter, biasanya digunakan metode fromJson untuk membaca JSON menjadi objek, dan toJson untuk mengubah objek kembali ke JSON.

- Apakah terjadi error?
Tidak akan terjadi error, tetapi kode yang kita gunakan akan lebih susah dikelola karena tidak adanya type safety yang membuat kita tidak tahu data yang masuk atau kita kirim seperti apa.

### Fungsi dari Library `http`
Library http dalam Flutter digunakan untuk melakukan permintaan `HTTP` ke server (API) untuk mengirim atau mengambil data. Pada tugas kali ini, saya mengimplementasikan penggunaan `GET` untuk listing product saya dan `POST` untuk menambahkan product saya. Saya juga menggunakan `GET` dan `POST` untuk autentikasi yang telah saya buat. Semua permintaan `HTTP` ini saya buat dengan mengintegrasikan web app `Django` dengan `Flutter`.

### Fungsi dari `CookieRequest`
`CookieRequest` berfungsi untuk memudahkan aplikasi kita untuk mengakses `Cookie`. `CookieRequest` disini berisi `headers`, `cookies`, dan juga `jsonData` yang kita perulah disaat kita login ke dalam aplikasi. `Cookie` ini dapat mempermudah kita untuk mengecek apakah user login atau tidak. `CookieRequest` perlu dibagikan ke semua aplikasi dalam Flutter agar dapat terinisiasi dan digunakan dengan baik yang bertujuan untuk memastikan user tidak terlepas dengan autentikasi di page tertentu.

### Mekanisme Pengiriman Data pada Flutter
1. Data dimasukan oleh pengguna melalui widget seperti TextField atau Form. Misalnya, nama dan deskripsi produk. setelah itu, data divalidasi secara lokal sebelum dikirim, misalnya dengan memeriksa apakah field kosong atau formatnya sesuai.
2. Data yang telah divalidasi dikirim ke backend menggunakan permintaan `HTTP`, biasanya melalui library seperti `http`.
3. Django menerima permintaan `HTTP POST` pada endpoint tertentu, misalnya `/create-flutter/`. Data JSON dari request diubah menjadi format Python menggunakan serializer. Django memvalidasi data menggunakan serializer atau model sebelum menyimpannya ke database.
4. Setelah data tersimpan, Flutter dapat mengambilnya dengan request `HTTP GET`.
5. Data JSON yang diterima diubah menjadi model Dart (deserialization) dan ditampilkan menggunakan widget seperti `ListView`.

### Mekanisme Autentikasi (Register, Login, Logout)
#### Register
- Pengguna memasukkan data akun seperti nama, email, dan password.
- Data dikirim dengan `HTTP POST` ke Django.
- Validasi data dengan serializer atau model (misalnya, memeriksa apakah email atau username sudah digunakan).
- Password akan di-hash sebelum disimpan ke database menggunakan library seperti `django.contrib.auth`.
- Terakhir, Django akan mengembalikan respons berhasil atau error ke Flutter.

#### Login
- Pengguna memasukkan email dan password.
- Data dikirim dengan `HTTP POST`.
- Django memeriksa apakah email dan password cocok dengan data di database.
- Jika berhasil, Django mengembalikan token autentikasi yang biasanya disimpan dalam `cookies` yang dapat digunakan sebagai validasi untuk membuat user selalu dalam state login dan untuk dapat membuat `request`.

#### Logout
- Pengguna menekan tombol Logout
- Mengirim permintaan logout ke Django
- Django meng-flush session id yang dimiliki user

### Step by Step Tugas 9
#### Pada Django
1. Membuat endpoint di django yang berguna untuk digunakan pada flutter
2. Membuat app bernama authentication dengan command sebagai berikut
```bash
py manage.py startapp authentication
```
3. Setelah itu, membuat endpoint pada views dan urls yang tidak lupa disambungkan kepada project django agar Flutter bisa melakukan request untuk Login, Logout, dan Register. Ketiga metode itu memanfaatkan metode bawaan django yang berasal dari library `django.contrib.auth`

4. Membuat `POST` berdasarkan model product yang saya punya dan mengembalikan
```python
return JsonResponse(
    {
        "status": "success",
        "message": "Keyboard has been created successfully!",
    },
    status=201,
)

# Atau

return JsonResponse(
    {
        "status": False,
        "message": "Failed.",
    },
    status=400,
)
```
5. Menambahkan endpoint `GET` untuk product yang dibuat oleh user yang sedang login dengan memanfaatkan params id.

#### Pada Flutter
1. Menambahkan page login dan register dengan menyambungkannya dengan django dengan library `http` dan `pbp_django_auth`
2. Menginisiasi `CookieRequest()` guna menyimpan `cookies` user untuk membuat `request` dan mengvalidasi bahwa user sedang login
3. Membuat 3 Model, yaitu Keyboard, Mouse, dan Product (gabungan Mouse dan Keyboard)
4. Form yang sebelumnya hanya menampilkan dialog, diubah menjadi `POST request` yang nantinya akan diterima pada Django dan divalidasi ulang sebelum dimasukan ke database
5. Melakukan `GET request` untuk semua product dan `GET request` untuk produk yang hanya dimiliki author saja, untuk yang hanya dimiliki author saja, saya menambahkan pada `views` login Django yang telah dibuat dengan menambahkan id user guna mengambil barang yang hanya miliknya saja.
6. Implement fitur detail dengan tombol pada setiap card yang dimana jika dipencet akan mengarahkan ke Stateless Widget yang berisi detail product tersebut, inisiasinya seperti ini:
```dart
class DetailProductPage extends StatelessWidget {
  final Keyboard? keyboard;
  final Mouse? mouse;
  const DetailProductPage({ // Widget ini bisa mendapatkan model keyboard/mouse
    super.key,
    this.keyboard, 
    this.mouse,
  });

  @override
  Widget build(BuildContext context) {
    . . . . .
  }
}
```


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

