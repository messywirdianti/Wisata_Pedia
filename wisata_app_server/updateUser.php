<?php

include 'Koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $res = array();

    // Cek apakah semua field yang diperlukan ada
    if (isset($_POST['id']) && isset($_POST['fullname']) && isset($_POST['username'])) {
        $id = $_POST['id'];
        $fullname = $_POST['fullname'];
        $username = $_POST['username'];

        // Penanganan file gambar
        if (isset($_FILES['gambar_user']) && $_FILES['gambar_user']['error'] === UPLOAD_ERR_OK) {
            $filename = $_FILES['gambar_user']['name'];
            $filetmpname = $_FILES['gambar_user']['tmp_name'];
            $folder = 'gambar_wisata/';
            move_uploaded_file($filetmpname, $folder . $filename);
        } else {
            // Jika tidak ada gambar, gunakan filename yang lama atau kosongkan jika diperlukan
            $filename = '';
        }

        // Query SQL untuk update
        $sql = "UPDATE tbuser SET gambar_user='$filename', fullname='$fullname', username='$username' WHERE id='$id'";

        error_log("Query yang dijalankan: " . $sql);

        $isSuccess = $koneksi->query($sql);
        if (!$isSuccess) {
            $error = mysqli_error($koneksi);
            $res['is_success'] = false;
            $res['value'] = 0;
            $res['message'] = "Gagal edit user: " . $error;
            echo json_encode($res);
            exit;
        }

        if ($isSuccess) {
            $cek = "SELECT * FROM tbuser WHERE id='$id'";
            $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));

            $res['is_success'] = true;
            $res['value'] = 1;
            $res['message'] = "Berhasil edit data";
            $res['username'] = $result['username'];
            $res['fullname'] = $result['fullname'];
            $res['gambar'] = $result['gambar_user'];
            $res['id'] = $result['id'];
        } else {
            $res['is_success'] = false;
            $res['value'] = 0;
            $res['message'] = "Gagal edit user";
        }
    } else {
        $res['is_success'] = false;
        $res['value'] = 0;
        $res['message'] = "Field tidak lengkap";
    }

    echo json_encode($res);
}
?>
