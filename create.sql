CREATE TABLE Emlak (
  emlak_id INT IDENTITY(1,1) PRIMARY KEY,
  baslik VARCHAR(255),
  aciklama VARCHAR(200),
  ilanbaslangictarihi DATE,
  ilanbitistarihi DATE,
  il_id CHAR(2),
  ilce_id INT,
  adres_id INT,
  kullanici_id INT,
  FOREIGN KEY (adres_id) REFERENCES Adres(adres_id),
  FOREIGN KEY (il_id) REFERENCES Il(il_id),
  FOREIGN KEY (ilce_id) REFERENCES Ilce(ilce_id),
  FOREIGN KEY (kullanici_id) REFERENCES kullanici(kullanici_id)
);

CREATE TABLE Genel_ozellikler (
  ozellik_id INT IDENTITY(1,1) PRIMARY KEY,
  emlak_id INT,
  m2 INT,
  krediye_uygunluk BOOLEAN,
  satis BOOLEAN,
  kiralama BOOLEAN,
  harita BLOB,
  para_birimi_id VARCHAR(3),
  emlak_turleri_id INT, 
  tapu_durumu_id INT,
  cephe_id VARCHAR(1),
  FOREIGN KEY (emlak_id) REFERENCES Emlak(emlak_id),
  FOREIGN KEY (para_birimi_id) REFERENCES Para_Birimi(para_birimi_id),
  FOREIGN KEY (emlak_turleri_id) REFERENCES emlak_turleri(emlak_turu_id),
  FOREIGN KEY (tapu_durumu_id) REFERENCES Tapu_Durumu(tapu_durumu_id),
  FOREIGN KEY (cephe_id) REFERENCES cephe(cephe_id)
);

CREATE TABLE Para_Birimi (
  para_birimi_id VARCHAR(3) PRIMARY KEY,
  para_birimi_ad VARCHAR(20)
);

CREATE TABLE Emlak_Resimleri (
  resim_id INT IDENTITY(1,1) PRIMARY KEY,
  resim_no INT,
  emlak_id INT,
  resim BLOB,
  FOREIGN KEY (emlak_id) REFERENCES Emlak(emlak_id)
);

CREATE TABLE Tapu_Durumu (
  tapu_durumu_id INT IDENTITY(1,1) PRIMARY KEY,
  tapu_durumu_ad VARCHAR(255)
);

CREATE TABLE cephe(
    cephe_id VARCHAR(1) PRIMARY KEY,
    cephe_ad VARCHAR(5)
);

CREATE TABLE Kimden (
  kimden_id INT IDENTITY(1,1) PRIMARY KEY,
  kimden_satilik VARCHAR(10)
);

CREATE TABLE Adres (
  adres_id INT IDENTITY(1,1) PRIMARY KEY,
  emlak_id INT,
  il_id CHAR(2),
  ilce_id INT,
  mahalle_id INT,
  sokak_id INT,
  kapi_no_id INT,
  FOREIGN KEY (emlak_id) REFERENCES Emlak(emlak_id),
  FOREIGN KEY (il_id) REFERENCES Il(il_id),
  FOREIGN KEY (ilce_id) REFERENCES Ilce(ilce_id),
  FOREIGN KEY (mahalle_id) REFERENCES Mahalle(mahalle_id),
  FOREIGN KEY (sokak_id) REFERENCES Sokak(sokak_id),
  FOREIGN KEY (kapi_no_id) REFERENCES Kapi_No(kapi_no_id)
);

CREATE TABLE Il (
  il_id CHAR(2) PRIMARY KEY,
  il_ad VARCHAR(20)
);

CREATE TABLE Ilce (
  ilce_id INT IDENTITY(1,1) PRIMARY KEY,
  ilce_ad VARCHAR(20),
  il_id CHAR(2),
  FOREIGN KEY (il_id) REFERENCES Il(il_id)
);

CREATE TABLE Mahalle (
  mahalle_id INT IDENTITY(1,1) PRIMARY KEY,
  mahalle_ad VARCHAR(30),
  ilce_id INT,
  FOREIGN KEY (ilce_id) REFERENCES Ilce(ilce_id)
);

CREATE TABLE Sokak (
  sokak_id INT IDENTITY(1,1) PRIMARY KEY,
  sokak_ad VARCHAR(30),
  mahalle_id INT,
  FOREIGN KEY (mahalle_id) REFERENCES Mahalle(mahalle_id)
);


CREATE Table Kapi_no(
    kapi_no_id INT IDENTITY(1,1) PRIMARY KEY,
    ickapino INT,
    diskapino VARCHAR(4),   
    il_id CHAR(2), 
    ilce_id INT,
    mahalle_id INT,
    sokak_id INT,
    emlak_id INT,
    FOREIGN KEY (il_id)   REFERENCES il(il_id),
    FOREIGN KEY (ilce_id)   REFERENCES ilce(ilce_id),
    FOREIGN KEY (mahalle_id)  REFERENCES mahalle(mahalle_id),
    FOREIGN KEY (sokak_id)   REFERENCES sokak(sokak_id),
    FOREIGN KEY (emlak_id)   REFERENCES emlak(emlak_id)      
);





CREATE Table kullanici(
    kullanici_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    soyad VARCHAR(20),
    ad VARCHAR(20),
    e_mail VARCHAR(30),
    telefonNo VARCHAR(30),
    aktifMi BOOLEAN,
    sonGiris DATE,
    dogumTarihi DATE

);

-- Emlak Türleri tablosu
CREATE TABLE emlak_turleri (
  emlak_turu_id INTEGER PRIMARY KEY,
  emlak_turu_ad VARCHAR(20)
  
);

-- Arsa tablosu
CREATE TABLE arsa (
  arsa_id INTEGER PRIMARY KEY,
  parsel_no VARCHAR(20),
  zemin VARCHAR(20),
  ada_no VARCHAR(20),
  arsa_turu_id INTEGER,
  imar_durumu_id INTEGER,
  FOREIGN KEY (arsa_turu_id) REFERENCES emlak_turleri (emlak_turu_id),
  FOREIGN KEY (imar_durumu_id) REFERENCES imar_durumu (imar_durumu_id)

);

-- İş yeri tablosu
CREATE TABLE is_yeri (
  isyeri_id INTEGER PRIMARY KEY,
  kullanim_amaci VARCHAR(50),
  emlak_turu_id INTEGER,
  FOREIGN KEY (emlak_turu_id) REFERENCES emlak_turleri (emlak_turu_id)
);

-- Konut tablosu
CREATE TABLE konut (
  konut_id INTEGER PRIMARY KEY,
  site VARCHAR(50),
  kullanımDurumu VARCHAR(50),
  günlük_kiralık BOOLEAN,
  isitma_id INTEGER,
  bulundugu_kat_id INTEGER,
  bina_yasi_id INTEGER,
  oda_sayisi_id INTEGER,
  emlak_turu_id INTEGER,
  FOREIGN KEY (isitma_id) REFERENCES isitma (isitma_id),
  FOREIGN KEY (bulundugu_kat_id) REFERENCES bulundugu_kat (bulundugu_kat_id),
  FOREIGN KEY (bina_yasi_id) REFERENCES bina_yasi (bina_yasi_id),
  FOREIGN KEY (oda_sayisi_id) REFERENCES oda_sayisi (oda_sayisi_id),
  FOREIGN KEY (emlak_turu_id) REFERENCES emlak_turleri (emlak_turu_id)
);

-- Isıtma tablosu
CREATE TABLE isitma (
  isitma_id INTEGER PRIMARY KEY,
  isitma_turu VARCHAR(50)
);

-- Bulunduğu Kat tablosu
CREATE TABLE bulundugu_kat (
  bulundugu_kat_id INTEGER PRIMARY KEY,
  katNo INTEGER
);

-- Bina Yaşı tablosu
CREATE TABLE bina_yasi (
  bina_yasi_id INTEGER PRIMARY KEY,
  bina_yasi_no INTEGER
);

-- Oda Sayısı tablosu
CREATE TABLE oda_sayisi (
  oda_sayisi_id INTEGER PRIMARY KEY,
  oda_sayisi_no INTEGER
);

-- İmar Durumu tablosu
CREATE TABLE imar_durumu (
  imar_durumu_id INTEGER PRIMARY KEY,
  imar_durumu_ad VARCHAR(50)
);
