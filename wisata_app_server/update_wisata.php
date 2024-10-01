<?php
include 'koneksi.php';

// Menetapkan agar output hanya berupa JSON
header('Content-Type: application/json');
error_reporting(0);  // Menonaktifkan semua error log agar tidak mengganggu output JSON

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $id = $_POST['id'];
    $namaWisata = $_POST['nama_wisata'];
    $kategori = $_POST['kategori'];
    $lokasi = $_POST['lokasi'];

    // Debugging log
    error_log("ID: " . $id);
    error_log("Nama Wisata: " . $namaWisata);
    error_log("Kategori: " . $kategori);
    error_log("Lokasi: " . $lokasi);

    $filename = $_FILES['gambar_wisata']['name'];
    $filetmpname = $_FILES['gambar_wisata']['tmp_name'];
    $folder = 'gambar_wisata/';

    // Jika ada file gambar yang diupload
    if (!empty($filename) && move_uploaded_file($filetmpname, $folder . $filename)) {
        // File berhasil di-upload, lanjutkan ke query update dengan gambar
        $update = "UPDATE tbwisata SET gambar_wisata = '$filename', nama_wisata = '$namaWisata', kategori = '$kategori', lokasi = '$lokasi' WHERE id=$id";
    } else {
        // Jika tidak ada gambar, hanya update nama, kategori, dan lokasi
        error_log("Gagal upload gambar atau tidak ada gambar yang diupload.");
        $update = "UPDATE tbwisata SET nama_wisata = '$namaWisata', kategori = '$kategori', lokasi = '$lokasi' WHERE id=$id";
    }

    // Eksekusi query
    if (mysqli_query($koneksi, $update)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil Update Data";
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal Update Data: " . mysqli_error($koneksi);
    }

    echo json_encode($response);
}
