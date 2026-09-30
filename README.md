# Eduka-Orca

Pembaca layar **Orca 50.3** untuk **Edukasaun OS / Eduka-Desktop (LXQt)**, dengan
bicara lebih pelan dan teks ucapan di layar untuk pengguna dengan gangguan
pendengaran.

*Orca 50.3 screen reader for Edukasaun OS / Eduka-Desktop (LXQt), with slower
speech and on-screen captions for users who are hard of hearing.*

## Isi repo ini

Repo ini **tidak** menyalin seluruh kode Orca (ribuan berkas). Isinya hanya
perubahan Eduka dalam bentuk patch; kode Orca asli diunduh otomatis dari
[GNOME/orca](https://github.com/GNOME/orca) saat build.

```
patches/                     perubahan Eduka terhadap Orca 50.3
  0001-...caption.patch      bicara pelan (rate 30, pitch 4.5), teks ucapan di layar, suara Portugis untuk Tetum
  0002-...overrida.patch     integrasi LXQt, menu Eduka-Orca, toggle, pengaturan sistem
  0003-...packaging.patch    folder debian/ (paket eduka-orca) dan man page
build.sh                     unduh Orca 50.3 + terapkan patch (+ bangun .deb)
.github/workflows/build.yml  GitHub Actions: bangun .deb di Debian 13 otomatis
```

## Membangun paket

Di Debian 13 / Edukasaun OS:

```sh
sudo apt install git devscripts equivs build-essential
./build.sh deb        # hasil: build/eduka-orca_50.3+eduka1_all.deb
sudo apt install ./build/eduka-orca_50.3+eduka1_all.deb
```

Hanya menyiapkan kode sumber (tanpa build): `./build.sh`

### Otomatis lewat GitHub

Setiap *push* ke `main`, GitHub Actions membangun `.deb` di wadah Debian 13;
unduh dari tab **Actions → run terakhir → Artifacts**. Untuk rilis resmi, buat
tag, misalnya `v50.3+eduka1`, maka `.deb` otomatis dilampirkan ke halaman
**Releases**.

## Mengubah kode

```sh
./build.sh
cd build/eduka-orca-50.3+eduka1
# ... ubah berkas, lalu commit ...
git commit -am "Eduka-Orca: deskripsi perubahan"
git format-patch 50.3..HEAD -o ../../patches   # hapus patch lama dulu
```

Detail semua perubahan: `eduka/README.Eduka.md` di dalam kode sumber yang
sudah di-patch.

## Lisensi

LGPL-2.1-or-later, sama seperti Orca (lihat `COPYING`).
