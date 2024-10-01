<?php

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

$idList = $_POST['idList'];

$sql = "DELETE FROM tbwisata WHERE id = $idList";
$isSukses = $koneksi->query($sql);

if($isSukses){
	$res['value'] = 1;
	$res['message'] = "Berhasil Hapus Data";
	echo json_encode($res);
} else {
	$res['value'] = 0;
	$res['message'] = "Gagal Hapus Data";
	echo json_encode($res);
}
} 

?>