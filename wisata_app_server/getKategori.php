<?php 

include "koneksi.php";

if($_SERVER['REQUEST_METHOD'] == "GET"){
    $sql ="SELECT * FROM kategori";
    $result = $koneksi->query($sql);
    $res = array();
    if($result->num_rows > 0){
        $res['is_success'] = true;
        $res['message'] = "Berhasil Menampilkan Data Kategori";
        $res['data'] = array();
        while ($row = $result->fetch_assoc()) {
            $res['data'][] = $row;
        }
    } else {
        $res['is_success'] = false;
        $res['message'] = "Gagal Menampilkan Data Kategori";
        $res['data'] = null;
    }
    echo json_encode($res);
}

?>