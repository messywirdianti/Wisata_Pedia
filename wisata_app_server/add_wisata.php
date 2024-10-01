<?php
include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();

    // Cek apakah semua field yang diperlukan ada
    if (isset($_POST['nama_wisata'], $_POST['kategori'], $_POST['lokasi'], $_POST['latitude'], $_POST['longitude']) && isset($_FILES['gambar'])) {
        
        $namaWisata = $_POST['nama_wisata'];
        $kategori = $_POST['kategori'];
        $lokasi = $_POST['lokasi'];
        $latitude = $_POST['latitude'];
        $longitude = $_POST['longitude'];
        
        // Handle file upload
        $filename = $_FILES['gambar']['name'];
        $filetmpname = $_FILES['gambar']['tmp_name'];
        $folder = 'gambar_wisata/';
        
        if (move_uploaded_file($filetmpname, $folder.$filename)) {
            // Query insert data ke database
            $insert = "INSERT INTO tbwisata (nama_wisata, kategori, lokasi, latitud, longitude, gambar_wisata) 
                       VALUES ('$namaWisata','$kategori','$lokasi','$latitude','$longitude','$filename')";

            // Eksekusi query dan cek apakah berhasil
            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['message'] = "Berhasil Insert Data";
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal Insert Data" . mysqli_error($koneksi);
            }
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal Upload Gambar";
        }
    } else {
        // Jika ada data yang tidak lengkap
        $response['value'] = 0;
        $response['message'] = "Data tidak lengkap";
    }
    
    // Return JSON response
    echo json_encode($response);
}
?>
