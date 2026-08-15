# 🛡️ Sinkhole iptables - Domain Blocking Dinamis via GitHub

Solusi otomatis dan dinamis untuk memblokir lalu lintas keluar (*egress/sinkhole*) pada Linux Server berdasarkan nama domain menggunakan modul `string` matching `iptables`.

Daftar domain terpusat di repository GitHub Anda (`blockinglist.txt`). Server akan melakukan sinkronisasi otomatis secara berkala melalui cron job dan tetap persisten meski firewall / CSF di-restart.

---

## 🚀 Fitur Utama

- **Otomatis & Dinamis**: Cukup tambahkan/edit domain di repository GitHub (`blockinglist.txt`), server akan otomatis memperbarui aturan iptables.
- **One-Liner Installation**: Instalasi mudah dengan satu baris perintah `curl`.
- **String Matching (`xt_string`)**: Memblokir paket TCP & UDP (termasuk DNS request dan HTTP/TLS SNI raw traffic) tanpa perlu me-resolve IP domain satu per satu.
- **Integrasi CSF (ConfigServer Security & Firewall)**: Otomatis mendaftarkan hook pada `/etc/csf/csfpost.sh` agar chain blokir tidak hilang saat CSF di-restart/reload.
- **Otomatisasi Cron**: Sync berkala otomatis setiap hari (bisa disesuaikan).
- **CLI Lengkap**: Perintah mandiri untuk cek `status`, `list`, `update`, dan `uninstall`.

---

## 📋 Prasyarat Sistem

- **OS**: Linux (Ubuntu, Debian, CentOS, AlmaLinux, Rocky Linux, CloudLinux, dll)
- **Akses**: `root` atau pengguna dengan hak akses `sudo`
- **Paket**: `iptables`, `curl`
- **Modul Kernel**: `xt_string` (sudah bawaan mayoritas kernel Linux modern)

---

## 📦 Cara Instalasi Cepat (One-Liner)

Jalankan perintah berikut di terminal server Anda:

```bash
curl -fsSL https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/installer.sh | sudo bash
```

> 💡 **Info**: Secara default, installer akan menggunakan daftar domain dari repo ini (`blockinglist.txt`). Jika ingin menggunakan URL raw blocklist kustom lainnya, jalankan:
> ```bash
> curl -fsSL https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/installer.sh | sudo bash -s -- https://raw.githubusercontent.com/username/repo/main/my-domains.txt
> ```

---

## 🛠️ Penggunaan & Perintah CLI

Setelah terinstal, Anda dapat menggunakan perintah `jagoankode_sinkhole-iptables` langsung dari terminal:

### 1. Cek Status
Melihat status chain iptables, jumlah domain yang aktif diblokir, dan waktu update terakhir:
```bash
jagoankode_sinkhole-iptables status
```

### 2. Lihat Daftar Domain Terblokir
Menampilkan daftar domain yang saat ini aktif dicatat di server:
```bash
jagoankode_sinkhole-iptables list
```

### 3. Paksa Update / Sync Ulang
Menarik daftar domain terbaru dari GitHub dan memperbarui rule iptables secara instan:
```bash
sudo jagoankode_sinkhole-iptables update
```

### 4. Uninstall
Menghapus seluruh konfigurasi, cron job, hook CSF, dan chain iptables:
```bash
sudo jagoankode_sinkhole-iptables uninstall
```

---

## 📝 Cara Menambahkan Domain Baru

1. Buka file [`blockinglist.txt`](blockinglist.txt) di GitHub.
2. Tambahkan domain baru (satu domain per baris), contoh:
   ```text
   # Daftar Domain yang Diblokir
   hgsocket.com
   hxbdoor.one
   malware-c2-domain.com
   phishing-site.xyz
   ```
3. Lakukan **Commit Changes** / Push ke branch `main`.
4. Server Anda akan otomatis memperbarui aturan iptables pada jadwal cron berikutnya (setiap hari pk 03:00) atau Anda dapat menjalankan `sudo jagoankode_sinkhole-iptables update` di server untuk menerapkan langsung.

---

## 🧪 Cara Pengujian & Verifikasi

Untuk memastikan domain berhasil diblokir oleh iptables:

1. **Coba ping atau curl ke domain target dari server:**
   ```bash
   curl -I -m 5 http://hgsocket.com
   ```
   *(Koneksi akan langsung timeout/dropped)*

2. **Periksa counter packet yang tertangkap di iptables chain:**
   ```bash
   sudo iptables -L JAGOANKODE_SINKHOLE -v -n
   ```
   Anda akan melihat jumlah paket dan byte yang berhasil di-DROP oleh rule domain terkait.

---

## ⚙️ Struktur & Lokasi File di Server

- **CLI Binary**: `/usr/local/bin/jagoankode_sinkhole-iptables`
- **Konfigurasi**: `/etc/jagoankode-sinkhole/config`
- **Cache Domain**: `/etc/jagoankode-sinkhole/domains.txt`
- **Log File**: `/var/log/jagoankode-sinkhole.log`
- **Cron Job**: `/etc/cron.d/jagoankode-sinkhole`

---

## 🤝 Kontribusi & Lisensi

Dikelola oleh **Jagoankode Group Indonesia**.
