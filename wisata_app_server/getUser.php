<?php

include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $id = $_POST['id'];
    $sql ="SELECT * FROM tbuser WHERE id = $id";
    $result = $koneksi->query($sql);
    if($result->num_rows > 0){
        $res['is_success'] = true;
        $res['message'] = "Berhasil Menampilkan data user";
        $res['data'] = array();
        while ($row = $result->fetch_assoc()) {
            $res['data'][] = $row;
        }
    } else {
        $res['is_success'] = false;
        $res['message'] = "Gagal Menampilkan data user";
        $res['data'] = null;
    }
    echo json_encode($res);
}

?>