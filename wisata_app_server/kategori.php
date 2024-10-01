<?php

include "koneksi.php";

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $response = array();
    $kategori = $_POST['kategori'];

    $insert = "INSERT INTO kategori VALUE(NULL, '$kategori', NOW())";

    if(mysqli_query($konaksi, $insert)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil Insert Data";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal Insert Data";
        echo json_encode($response);
    }
}

?>