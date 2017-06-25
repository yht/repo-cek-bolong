# repo-cek-bolong
Cek Bolong, Unduh!

## Cek Binary
Skrip ini untuk melakukan pengecekan pada arsip debian secara langsung dan mengunduhnya.

### Penggunaan
```
. cek-binary.sh [dists] [section] [arsitektur]
```

## Cek Debian Snapshot
Skrip ini untuk melakukan pengecekan pada arsip debian snapshot secara langsung dan mengunduhnya.

### Penggunaan
```
. cek-snapshot.sh [dists] [section] [arsitektur]
```

## Deskripsi

### repo_dir
Merupakan letak cermin lokal ditempatkan, dalam hal ini di "$HOME/mirror"

### repo_dists
Merupakan _dists_ dari cermin, diambil dari argumen inputan skrip yang pertama.

### repo_sect
Merupakan _section_ dari cermin, diambil dari argumen inputan skrip yang kedua.

### repo_arch
Merupakan arsitektur dari cermin, diambil dari argumen inputan skrip yang kedua.

### repo_mirror
Merupakan _mirror_ dari cermin, dalam hal ini menggunakan "http://kartolo.sby.datautama.net.id/debian" untuk `cek-binary.sh` dan "http://snapshot.debian.org" untuk `cek-snapshot.sh`.
