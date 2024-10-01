<?php

include "koneksi.php";

$sql = "SELECT * FROM images";
$result = $koneksi->query($sql);

if($result->num_rows > 0){
    $res['is_success'] = true;
    $res['message'] = "Berhasil Menampilkan images";
    $res['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $res['data'][] = $row;
    }
} else {
    $res['is_success'] = false;
    $res['message'] = "Gagal Menampilkan image";
    $res['data'] = null;
}

echo json_encode($res);

?>