#!/bin/bash

# Direktori tempat file .zst disimpan
dir="x86_64"

# ID kunci GPG yang digunakan untuk menandatangani paket
key=""

# Import kunci GPG jika belum diimpor
gpg --import NAMA_FILE_KUNCI.asc

# Membuat daftar file .zst
list_zst=(${dir}/*.zst)

# Menampilkan daftar file .zst dan membuat tanda tangan
echo "Daftar file .zst dalam direktori ${dir}:"
for file_zst in ${list_zst[@]}; do
    if [ -e ${file_zst} ]; then
        nama_paket=$(basename ${file_zst})
        nama_sig="${file_zst}.sig"

        # Tandatangani paket
        gpg --detach-sign --output ${nama_sig} -u ${key} ${file_zst}

        # Menampilkan informasi
        echo "- ${nama_paket} [Tanda Tangan: ${nama_sig}]"
    else
        # File tidak ditemukan
        echo "- File tidak ditemukan: " ${file_zst}
    fi
done
