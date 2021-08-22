SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE galeri (
  id bigint(20) UNSIGNED NOT NULL,
  tipe_galeri_id bigint(20) UNSIGNED NOT NULL,
  judul varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  deskripsi text COLLATE utf8mb4_unicode_ci NOT NULL,
  file varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  created_by bigint(20) UNSIGNED NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE jenis_reservasi (
  id bigint(20) UNSIGNED NOT NULL,
  nama varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE kategori_produk (
  id bigint(20) UNSIGNED NOT NULL,
  nama varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE layanan (
  id bigint(20) UNSIGNED NOT NULL,
  kategori_produk_id bigint(20) UNSIGNED NOT NULL,
  nama varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  harga int(11) NOT NULL,
  deskripsi text COLLATE utf8mb4_unicode_ci NOT NULL,
  created_by bigint(20) UNSIGNED NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE pembayaran (
  id bigint(20) UNSIGNED NOT NULL,
  reservasi_id bigint(20) UNSIGNED NOT NULL,
  pegawai_id bigint(20) UNSIGNED NOT NULL,
  total bigint(20) NOT NULL,
  poin_dapat int(11) NOT NULL,
  poin_total int(11) NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE reservasi (
  id bigint(20) UNSIGNED NOT NULL,
  kode_reservasi int(11) NOT NULL,
  nomor_antrian varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  customer_id bigint(20) UNSIGNED NOT NULL,
  jenis_reservasi_id bigint(20) UNSIGNED NOT NULL,
  layanan_id bigint(20) UNSIGNED NOT NULL,
  jam_reservasi time NOT NULL,
  tanggal_reservasi date NOT NULL,
  no_plat varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  status enum('Selesai','Belum Selesai') COLLATE utf8mb4_unicode_ci NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tipe_galeri (
  id bigint(20) UNSIGNED NOT NULL,
  nama varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tipe_user (
  id bigint(20) UNSIGNED NOT NULL,
  nama varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user` (
  id bigint(20) UNSIGNED NOT NULL,
  tipe_user_id bigint(20) UNSIGNED NOT NULL,
  email varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  password varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  nama varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  no_telepon varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  foto varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  poin int(11) NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


ALTER TABLE galeri
  ADD PRIMARY KEY (id),
  ADD KEY galeri_tipe_galeri_id_foreign (tipe_galeri_id),
  ADD KEY galeri_created_by_foreign (created_by);

ALTER TABLE jenis_reservasi
  ADD PRIMARY KEY (id);

ALTER TABLE kategori_produk
  ADD PRIMARY KEY (id);

ALTER TABLE layanan
  ADD PRIMARY KEY (id),
  ADD KEY layanan_kategori_produk_id_foreign (kategori_produk_id);

ALTER TABLE pembayaran
  ADD PRIMARY KEY (id),
  ADD KEY pembayaran_reservasi_id_foreign (reservasi_id);

ALTER TABLE reservasi
  ADD PRIMARY KEY (id),
  ADD KEY reservasi_customer_id_foreign (customer_id),
  ADD KEY reservasi_jenis_reservasi_id_foreign (jenis_reservasi_id),
  ADD KEY reservasi_layanan_id_foreign (layanan_id);

ALTER TABLE tipe_galeri
  ADD PRIMARY KEY (id);

ALTER TABLE tipe_user
  ADD PRIMARY KEY (id);

ALTER TABLE `user`
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY user_email_unique (email),
  ADD KEY user_tipe_user_id_foreign (tipe_user_id);


ALTER TABLE galeri
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE jenis_reservasi
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE kategori_produk
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE layanan
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE pembayaran
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE reservasi
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE tipe_galeri
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE tipe_user
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `user`
  MODIFY id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;


ALTER TABLE galeri
  ADD CONSTRAINT galeri_created_by_foreign FOREIGN KEY (created_by) REFERENCES `user` (id),
  ADD CONSTRAINT galeri_tipe_galeri_id_foreign FOREIGN KEY (tipe_galeri_id) REFERENCES tipe_galeri (id);

ALTER TABLE layanan
  ADD CONSTRAINT layanan_kategori_produk_id_foreign FOREIGN KEY (kategori_produk_id) REFERENCES kategori_produk (id);

ALTER TABLE pembayaran
  ADD CONSTRAINT pembayaran_reservasi_id_foreign FOREIGN KEY (reservasi_id) REFERENCES reservasi (id);

ALTER TABLE reservasi
  ADD CONSTRAINT reservasi_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES `user` (id),
  ADD CONSTRAINT reservasi_jenis_reservasi_id_foreign FOREIGN KEY (jenis_reservasi_id) REFERENCES jenis_reservasi (id),
  ADD CONSTRAINT reservasi_layanan_id_foreign FOREIGN KEY (layanan_id) REFERENCES layanan (id);

ALTER TABLE `user`
  ADD CONSTRAINT user_tipe_user_id_foreign FOREIGN KEY (tipe_user_id) REFERENCES tipe_user (id);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
