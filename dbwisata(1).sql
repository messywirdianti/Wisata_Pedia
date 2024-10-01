-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 01 Okt 2024 pada 04.27
-- Versi server: 8.0.30
-- Versi PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbwisata`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int NOT NULL,
  `kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `kategori`) VALUES
(1, 'wisata alam'),
(2, 'wisata budaya'),
(3, 'wisata kuliner'),
(4, 'wisata keluarga');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbuser`
--

CREATE TABLE `tbuser` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_daftar` timestamp NOT NULL,
  `gambar_user` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbuser`
--

INSERT INTO `tbuser` (`id`, `username`, `fullname`, `password`, `tgl_daftar`, `gambar_user`) VALUES
(2, 'Messy17', 'Messy Wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-10 14:15:54', ''),
(3, 'irwansyah', 'novriadi irwansyah', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-10 14:21:31', 'girl.png'),
(4, 'dinda', 'Dinda Gatya', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-10 15:01:58', ''),
(5, 'nadila24', 'Nadila Wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-11 07:57:50', ''),
(6, 'husein', 'yaser husein', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-11 08:04:03', ''),
(8, 'fadlisurya', 'Fadli Surya Pradana', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-11 08:13:38', 'a769c490-5b6b-4499-b30e-d64b501f950e3007854713633537394.jpg'),
(9, 'iqbal', 'iqball muhakim', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-11 14:57:54', ''),
(14, 'neisha', ' salsabila', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-11 15:53:29', '0c81e4a3-cfe6-47d4-a364-b818d49a6e40927182909224174778.jpg'),
(15, 'atha', 'Kainan athalla', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-25 09:47:53', ''),
(16, 'ichi17', 'Messy Wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 02:30:47', ''),
(17, 'putri22', '', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 02:36:36', ''),
(18, 'bintang01', 'bintang ', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 02:42:47', 'girl.png'),
(19, 'ritaa', 'rita sari', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 02:44:47', ''),
(20, 'bin12', 'bintang pratama putra', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 03:08:54', '57a2d8d8-15e8-4456-b19d-f81247c34af15378812779686652118.jpg'),
(21, 'araaa', 'sherena dwi azzahra', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 03:48:56', ''),
(22, 'wirdianti17', 'Messy Wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 04:17:24', ''),
(23, 'messyichi17', 'messy wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 04:23:19', '1e2c6f8a-5307-42f3-8e7b-10559946c5008569540103410360139.jpg'),
(24, 'wirdianti_17', 'Messy Wirdianti', '827ccb0eea8a706c4c34a16891f84e7b', '2024-09-26 04:28:39', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbwisata`
--

CREATE TABLE `tbwisata` (
  `id` int NOT NULL,
  `nama_wisata` varchar(225) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `gambar_wisata` varchar(225) NOT NULL,
  `lokasi` varchar(225) NOT NULL,
  `latitud` varchar(32) NOT NULL,
  `longitude` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbwisata`
--

INSERT INTO `tbwisata` (`id`, `nama_wisata`, `kategori`, `gambar_wisata`, `lokasi`, `latitud`, `longitude`) VALUES
(1, 'Pantai Nusa dua', 'objek wisata', 'pantai1.jpg', 'bali', '-8.795671696001067', '115.23297170343827'),
(2, 'Gunung Bromo', 'objek wisata', 'gunung1.jpg', 'Pasuruan, Jawa Barat', '-7.941387845707865', ' 112.95309770965099'),
(3, 'Labuhan Bajo/ Raja Empat pulau terindahh', 'wisata alam', 'rajaempat.jpeg', 'Papua Barat Daya Indonesia', '-8.484343198856374', '119.75570768159349'),
(4, 'Kawasan Mandehhh pesisir', 'wisata alam', 'mandehhh.jpeg', 'Padang,Sumatera Barat', '-1.1943362378988847', '100.43480247300751'),
(5, 'Nongsa Beach', 'Wisata Alam', 'nongsa.jpg', 'sambau, kecamatan nongsa, Batam', '1.2005599340263162', '104.08740149476567'),
(6, 'Tana Toraja', 'Wisata Budaya', 'toraja.jpg', 'Sulawesi Selatan', '-3.1053675268074326', '119.85292808139577'),
(7, 'Loncat Batu', 'Wisata Budaya', 'loncat.jpeg', 'Nias, Sumatra Utara', '-4567987.87', '984334567'),
(8, 'Pasar Lama Tangerang', 'wisata kuliner', 'pasar.jpg', 'Tanggerang', '-6.178650662629921', '106.63021095259477'),
(9, 'Gang Lombok', 'wisata kuliner-4567887654', 'lombok.jpg', 'Semarang', '-6.973577505888223', '110.42602945260627'),
(10, 'Gang Lombok, Semarang', 'Wisata Keluarga', 'tamansafari.jpg', 'Cisarua, Bogor, Jawa Barat, Indonesia ', '-6.973673351077622', '110.42610455445735'),
(11, 'Bali Zoo', 'Wisata Keluarga', 'balizoo.jpg', 'bali', '-8.591540381726135', '115.26564146612485'),
(14, 'Kebun Teh Kayu Aro', 'wisata alam', 'kebunteh.jpg', 'Girimulyo, Kayu Aro, Kerinci, Jambi', '-1.7964664369471957', '101.27285778490632'),
(15, 'kebun teh ', 'wisata alam', '86bf36c2-9e30-4f62-8ea4-d8e6e18510212471966810183907157.jpg', 'alahan panjang ', '-1.0334633701444205', '100.68424656220625'),
(16, 'taman nasional', 'wisata keluarga', 'eeb65abd-7ad8-485b-b3d9-97aa3d3fa8573983593909430668974.jpg', 'kota batam', '-0.8570474951342497', '100.50800267952823'),
(19, 'Gunung Padang', 'wisata alam', 'ab2483a5-51f0-4d4e-9ff2-156ee92cd7004597830301761051556.jpg', 'Puruih, Kota Padang', '-0.9698034160404196', '100.36617629674029');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbuser`
--
ALTER TABLE `tbuser`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbwisata`
--
ALTER TABLE `tbwisata`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbuser`
--
ALTER TABLE `tbuser`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `tbwisata`
--
ALTER TABLE `tbwisata`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
