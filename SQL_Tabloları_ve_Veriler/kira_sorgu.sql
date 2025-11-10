PRAGMA foreign_keys = ON;

-- Müşteri
CREATE TABLE IF NOT EXISTS Musteri (
    musteri_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    tc_no CHAR(11),
    telefon VARCHAR(15),
    email VARCHAR(100),
    adres VARCHAR(255)
);

-- Çalışan
CREATE TABLE IF NOT EXISTS Calisan (
    calisan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    pozisyon VARCHAR(50),
    telefon VARCHAR(15),
    email VARCHAR(100)
);

-- Yönetici
CREATE TABLE IF NOT EXISTS Yonetici (
    yonetici_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    sifre VARCHAR(100)
);

-- Araç
CREATE TABLE IF NOT EXISTS Arac (
    arac_id INTEGER PRIMARY KEY AUTOINCREMENT,
    plaka VARCHAR(20)  UNIQUE NOT NULL,
    marka VARCHAR(50),
    model VARCHAR(50),
    yil INTEGER,
    gunluk_ucret DECIMAL(10,2),
    durum VARCHAR(20) DEFAULT 'Müsait'
);

-- Rezervasyon
CREATE TABLE IF NOT EXISTS Rezervasyon (
    rezervasyon_id INTEGER PRIMARY KEY AUTOINCREMENT,
    musteri_id INTEGER NOT NULL,
    arac_id INTEGER NOT NULL,
    baslangic_tarihi DATE NOT NULL,
    bitis_tarihi DATE NOT NULL,
    durum VARCHAR(20) DEFAULT 'Beklemede',
    FOREIGN KEY (musteri_id) REFERENCES Musteri(musteri_id) ON DELETE CASCADE,
    FOREIGN KEY (arac_id) REFERENCES Arac(arac_id) ON DELETE CASCADE
);

-- Sözleşme
CREATE TABLE IF NOT EXISTS Sozlesme (
    sozlesme_id INTEGER PRIMARY KEY AUTOINCREMENT,
    rezervasyon_id INTEGER NOT NULL,
    calisan_id INTEGER,
    imza_tarihi DATE,
    teslim_tarihi DATE,
    toplam_tutar DECIMAL(10,2),
    FOREIGN KEY (rezervasyon_id) REFERENCES Rezervasyon(rezervasyon_id) ON DELETE CASCADE,
    FOREIGN KEY (calisan_id) REFERENCES Calisan(calisan_id)
);

-- Ödeme
CREATE TABLE IF NOT EXISTS Odeme (
    odeme_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sozlesme_id INTEGER NOT NULL,
    odeme_tarihi DATE,
    tutar DECIMAL(10,2),
    odeme_turu VARCHAR(20),
    FOREIGN KEY (sozlesme_id) REFERENCES Sozlesme(sozlesme_id) ON DELETE CASCADE
);

-- Sigorta
CREATE TABLE IF NOT EXISTS Sigorta (
    sigorta_id INTEGER PRIMARY KEY AUTOINCREMENT,
    arac_id INTEGER NOT NULL,
    sigorta_turu VARCHAR(50),
    baslangic_tarihi DATE,
    bitis_tarihi DATE,
    sigorta_firmasi VARCHAR(100),
    FOREIGN KEY (arac_id) REFERENCES Arac(arac_id) ON DELETE CASCADE
);

-- Bakım
CREATE TABLE IF NOT EXISTS Bakim (
    bakim_id INTEGER PRIMARY KEY AUTOINCREMENT,
    arac_id INTEGER NOT NULL,
    tarih DATE,
    aciklama VARCHAR(255),
    ucret DECIMAL(10,2),
    FOREIGN KEY (arac_id) REFERENCES Arac(arac_id) ON DELETE CASCADE
);

-- Kiralama Detay
CREATE TABLE IF NOT EXISTS KiralamaDetay (
    detay_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sozlesme_id INTEGER NOT NULL,
    arac_id INTEGER NOT NULL,
    gun_sayisi INTEGER,
    gunluk_ucret DECIMAL(10,2),
    toplam_ucret DECIMAL(10,2),
    FOREIGN KEY (sozlesme_id) REFERENCES Sozlesme(sozlesme_id) ON DELETE CASCADE,
    FOREIGN KEY (arac_id) REFERENCES Arac(arac_id) ON DELETE CASCADE
);


-- ===== VERİLER =====
INSERT INTO Musteri (ad, soyad, tc_no, telefon, email, adres)
VALUES
('Emir', 'Tosun', '11111111111', '05001112233', 'emir@gmail.com', 'İstanbul'),
('Ayşe', 'Kara', '22222222222', '05002223344', 'ayse@gmail.com', 'Ankara'),
('Mehmet', 'Demir', '33333333333', '05003334455', 'mehmet@gmail.com', 'İzmir'),
('Zeynep', 'Aksoy', '44444444444', '05004445566', 'zeynep@gmail.com', 'Bursa'),
('Can', 'Yılmaz', '55555555555', '05005556677', 'can@gmail.com', 'Antalya'),
('Elif', 'Koç', '66666666666', '05006667788', 'elif@gmail.com', 'Konya'),
('Ahmet', 'Şahin', '77777777777', '05007778899', 'ahmet@gmail.com', 'Eskişehir'),
('Deniz', 'Aydın', '88888888888', '05008889900', 'deniz@gmail.com', 'Samsun'),
('Selin', 'Kılıç', '99999999999', '05009990011', 'selin@gmail.com', 'Trabzon'),
('Eren', 'Polat', '10101010101', '05001010101', 'eren@gmail.com', 'Adana');

INSERT INTO Calisan (ad, soyad, pozisyon, telefon, email)
VALUES
('Mert', 'Aslan', 'Ofis Görevlisi', '05001112233', 'mert.aslan@arackirala.com'),
('Seda', 'Kurt', 'Temizlik Görevlisi', '05004567890', 'seda.kurt@arackirala.com'),
('Berk', 'Eren', 'Teslimat Sorumlusu', '05007894561', 'berk.eren@arackirala.com'),
('Ece', 'Çelik', 'Danışman', '05009998877', 'ece.celik@arackirala.com'),
('Okan', 'Uçar', 'Mekanik', '05003456789', 'okan.ucar@arackirala.com'),
('Deniz', 'Kaya', 'Ofis Görevlisi', '05001113322', 'deniz.kaya@arackirala.com'),
('Tuğba', 'Yıldız', 'Destek Personeli', '05005553344', 'tugba.yildiz@arackirala.com'),
('İsmail', 'Ateş', 'Bakım Personeli', '05002221100', 'ismail.ates@arackirala.com'),
('Betül', 'Ergin', 'Danışman', '05006667722', 'betul.ergin@arackirala.com'),
('Onur', 'Tuna', 'Teslimat Sorumlusu', '05009991122', 'onur.tuna@arackirala.com');

INSERT INTO Yonetici (ad, soyad, sifre, email)
VALUES
('Fatih', 'Erdoğan', '1234', 'fatih@firma.com'),
('Merve', 'Yalçın', 'abcd', 'merve@firma.com'),
('Kerem', 'Güneş', 'pass1', 'kerem@firma.com'),
('Esra', 'Altun', 'pass2', 'esra@firma.com'),
('Hüseyin', 'Aydın', 'admin', 'huseyin@firma.com'),
('Sevgi', 'Yılmaz', '6543', 'sevgi@firma.com'),
('Bora', 'Kara', '4321', 'bora@firma.com'),
('Aylin', 'Koç', '12345', 'aylin@firma.com'),
('Tolga', 'Demir', 'abcd', 'tolga@firma.com'),
('Sibel', 'Aslan', 'xyz', 'sibel@firma.com');



INSERT INTO Arac (plaka, marka, model, yil, gunluk_ucret, durum)
VALUES
('34ABC123', 'Renault', 'Clio', 2020, 750, 'Müsait'),
('06DEF456', 'Toyota', 'Corolla', 2022, 950, 'Kirada'),
('35XYZ789', 'Fiat', 'Egea', 2021, 800, 'Müsait'),
('07GHI321', 'Honda', 'Civic', 2019, 900, 'Bakımda'),
('01JKL111', 'Peugeot', '208', 2021, 850, 'Müsait'),
('27MNO222', 'Hyundai', 'i20', 2020, 820, 'Müsait'),
('41PRS333', 'Ford', 'Focus', 2018, 780, 'Kirada'),
('55TUV444', 'Volkswagen', 'Polo', 2023, 1000, 'Müsait'),
('66WXY555', 'Opel', 'Astra', 2020, 890, 'Müsait'),
('16ZAB666', 'Citroen', 'C3', 2019, 760, 'Bakımda');



INSERT INTO Rezervasyon (musteri_id, arac_id, baslangic_tarihi, bitis_tarihi, durum)
VALUES
(1, 1, '2025-11-01', '2025-11-03', 'Beklemede'),
(2, 2, '2025-11-04', '2025-11-06', 'Onaylandı'),
(3, 3, '2025-11-07', '2025-11-10', 'Beklemede'),
(4, 4, '2025-11-11', '2025-11-13', 'Onaylandı'),
(5, 5, '2025-11-14', '2025-11-16', 'Beklemede'),
(6, 6, '2025-11-02', '2025-11-04', 'Beklemede'),
(7, 7, '2025-11-05', '2025-11-07', 'Onaylandı'),
(8, 8, '2025-11-08', '2025-11-11', 'Beklemede'),
(9, 9, '2025-11-03', '2025-11-06', 'Beklemede'),
(10, 10, '2025-11-09', '2025-11-12', 'Beklemede');



INSERT INTO Sozlesme (rezervasyon_id, calisan_id, imza_tarihi, teslim_tarihi, toplam_tutar)
VALUES
(1, 1, '2025-10-01', '2025-10-05', 3200),
(2, 2, '2025-10-03', '2025-10-06', 2700),
(3, 3, '2025-10-05', '2025-10-08', 3500),
(4, 4, '2025-10-07', '2025-10-10', 2900),
(5, 5, '2025-10-09', '2025-10-12', 3100),
(6, 6, '2025-10-11', '2025-10-14', 3300),
(7, 7, '2025-10-13', '2025-10-17', 3600),
(8, 8, '2025-10-15', '2025-10-19', 2500),
(9, 9, '2025-10-17', '2025-10-21', 4000),
(10, 10, '2025-10-20', '2025-10-25', 4200);



INSERT INTO Odeme (sozlesme_id, odeme_tarihi, tutar, odeme_turu)
VALUES
(1, '2025-10-05', 3200, 'Kredi Kartı'),
(2, '2025-10-06', 2700, 'Nakit'),
(3, '2025-10-08', 3500, 'Banka Transferi'),
(4, '2025-10-10', 2900, 'Kredi Kartı'),
(5, '2025-10-12', 3100, 'Nakit'),
(6, '2025-10-14', 3300, 'Kredi Kartı'),
(7, '2025-10-17', 3600, 'Banka Transferi'),
(8, '2025-10-19', 2500, 'Nakit'),
(9, '2025-10-21', 4000, 'Kredi Kartı'),
(10, '2025-10-25', 4200, 'Nakit');


INSERT INTO Sigorta (arac_id, sigorta_turu, baslangic_tarihi, bitis_tarihi, sigorta_firmasi)
VALUES
(1, 'Kasko', '2025-01-01', '2026-01-01', 'Anadolu Sigorta'),
(2, 'Trafik', '2025-02-01', '2026-02-01', 'Allianz'),
(3, 'Kasko', '2025-03-01', '2026-03-01', 'AXA Sigorta'),
(4, 'Trafik', '2025-04-01', '2026-04-01', 'Mapfre'),
(5, 'Kasko', '2025-05-01', '2026-05-01', 'Sompo Japan'),
(6, 'Trafik', '2025-06-01', '2026-06-01', 'HDI Sigorta'),
(7, 'Kasko', '2025-07-01', '2026-07-01', 'Groupama'),
(8, 'Trafik', '2025-08-01', '2026-08-01', 'Zurich Sigorta'),
(9, 'Kasko', '2025-09-01', '2026-09-01', 'Ankara Sigorta'),
(10, 'Trafik', '2025-10-01', '2026-10-01', 'Neova Sigorta');


INSERT INTO Bakim (arac_id, tarih, aciklama, ucret)
VALUES
(1, '2025-01-10', 'Yağ değişimi ve filtre kontrolü', 450),
(2, '2025-02-05', 'Fren balatası değişimi', 600),
(3, '2025-03-12', 'Lastik değişimi ve balans ayarı', 850),
(4, '2025-04-08', 'Motor yağı ve hava filtresi değişimi', 500),
(5, '2025-05-15', 'Klima gazı dolumu ve kontrolü', 350),
(6, '2025-06-20', 'Genel periyodik bakım', 900),
(7, '2025-07-03', 'Akü değişimi', 700),
(8, '2025-08-18', 'Fren diski değişimi', 650),
(9, '2025-09-10', 'Rot balans ayarı ve lastik kontrolü', 400),
(10, '2025-10-02', 'Far ve silecek kontrolü', 300);


INSERT INTO KiralamaDetay (sozlesme_id, arac_id, gun_sayisi, gunluk_ucret, toplam_ucret)
VALUES
(1, 1, 4, 800, 3200),
(2, 2, 3, 900, 2700),
(3, 3, 5, 700, 3500),
(4, 4, 3, 970, 2910),
(5, 5, 4, 775, 3100),
(6, 6, 3, 1100, 3300),
(7, 7, 4, 900, 3600),
(8, 8, 2, 1250, 2500),
(9, 9, 5, 800, 4000),
(10, 10, 5, 840, 4200);

