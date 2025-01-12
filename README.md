# Student List App

Student List App adalah aplikasi sederhana yang memiliki dua fitur utama: **Login Feature** dan **List of Student Feature**. Aplikasi ini dibangun menggunakan **SwiftUI 5** dan memanfaatkan API dari [Random User API](https://randomuser.me/) untuk menampilkan data siswa.

## Fitur Utama

### 1. Login Feature
- **UI:**
  - Terdapat 2 input text untuk `username` dan `password`.
  - Terdapat 1 tombol untuk login.
- **Validasi:**
  - Input text untuk `username` dan `password` tidak boleh kosong.
  - Hanya pengguna dengan:
    - **Username:** `alfagift-admin`
    - **Password:** `asdf`
    - yang dapat login dengan sukses.

---

### 2. List of Student Feature
- **UI:**
  - Terdapat sebuah section yang menampilkan 10 daftar siswa.
  - Setiap daftar siswa menunjukkan:
    - **Nama**
    - **Foto Profil**
    - **Alamat**
- **Data:**
  - Data siswa diambil dari API [Random User API](https://randomuser.me/).

---

## Cara Menjalankan Aplikasi
1. Clone repositori ini:
   ```bash
   git clone https://github.com/litauven/Student_List_IOSApps.git

