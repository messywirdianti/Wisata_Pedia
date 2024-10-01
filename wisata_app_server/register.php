<?php

include "koneksi.php";

if($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();
    $username = $_POST['username'];
    $fullname = $_POST['nama_lengkap'];
    $password = md5($_POST['password']);
    $filename = $_FILES['gambar']['name'];
    $filetmpname = $_FILES['gambar']['tmp_name'];
    $folder = 'gambar_wisata/';
    move_uploaded_file($filetmpname, $folder . $filename);

    $cek = "SELECT * FROM tbuser WHERE username = '$username'";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
    if(isset($result)) {
        $response['value'] = 2;
        $response['message'] = "Username telah digunakan";
        echo json_encode($response);
    } else {
        $insert = "INSERT INTO tbuser (id, username, fullname, password, gambar_user, tgl_daftar) VALUE(NULL, '$username','$fullname','$password','$filename', NOW())";
        if(mysqli_query($koneksi, $insert)){
            $response['value'] = 1;
            $response['message'] = "Berhasil didaftarkan";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal didaftarkan";
            echo json_encode($response);
        }
    }
   
}
?>