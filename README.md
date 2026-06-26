# SmartChef AI - Dijital Mutfak Şefi

## 1. Proje Bilgileri

**Proje Adı:** SmartChef AI - Dijital Mutfak Şefi
**Öğrenci Adı Soyadı:** Merve Sağlık
**Öğrenci Numarası:** 24010509098
**Proje Türü:** Mobil Uygulama
**Geliştirme Ortamı:** Flutter / Android Studio
**GitHub Proje Bağlantısı:** https://github.com/mervesaglik74-byte/smartchef_ai

---

## 2. Projenin Amacı

SmartChef AI - Dijital Mutfak Şefi, kullanıcıların evde bulunan malzemelere göre yemek önerileri almasını, tarifleri adım adım takip etmesini, günlük beslenme durumunu görüntülemesini ve alışveriş listesini daha düzenli yönetmesini sağlayan mobil bir yemek tarifi uygulamasıdır.

Uygulamanın temel amacı, kullanıcıların günlük hayatta sıkça yaşadığı “Bugün ne pişirsem?” sorununa pratik, görsel olarak anlaşılır ve kullanımı kolay bir çözüm sunmaktır. Kullanıcı elindeki malzemeleri uygulamaya girerek uygun tarif önerileri alabilir, eksik malzemeleri listeleyebilir ve tarifin yapılışını adım adım takip edebilir.

Bu proje, ders kapsamında mobil uygulama geliştirme sürecini göstermek, Flutter ile modern arayüz tasarımı yapmak ve gerçek bir kullanıcı problemine yönelik işlevsel bir prototip oluşturmak amacıyla hazırlanmıştır.

---

## 3. Projenin Kısa Açıklaması

SmartChef AI, koyu tema üzerine yeşil ve turuncu vurgu renkleriyle tasarlanmış modern bir Flutter mobil uygulamasıdır. Uygulama, kullanıcının yemek planlama sürecini kolaylaştırmak için farklı ekranlardan oluşmaktadır.

Uygulamada kullanıcı:

* Günlük kalori ve su tüketimini görüntüleyebilir.
* Elindeki malzemeleri yazarak tarif önerisi alabilir.
* Tarif detaylarını ve besin değerlerini inceleyebilir.
* Eksik malzemeleri alışveriş listesine ekleyebilir.
* Adım adım pişirme rehberi ile yemeği uygulama üzerinden takip edebilir.
* Tarif videosu için YouTube yönlendirmesini kullanabilir.
* Profil ekranından hedeflerini ve genel durumunu görüntüleyebilir.

Mevcut proje, ders teslimi için hazırlanmış çalışan bir mobil uygulama prototipidir. Yapay zeka mantığı şu an demo senaryo olarak kurgulanmıştır. Kullanıcının yazdığı malzemeye göre uygulama ilgili tarif ekranına yönlendirme yapmaktadır. İlerleyen sürümlerde gerçek yapay zeka API bağlantısı ve kamera ile malzeme tanıma sistemi eklenebilir.

---

## 4. Problem Tanımı

Günlük hayatta birçok kişi evde bulunan malzemelerle ne pişireceğine karar vermekte zorlanmaktadır. Ayrıca tarif aramak zaman alabilir, eksik malzemeler unutulabilir ve kullanılmayan ürünler zamanla çöpe gidebilir.

Bu projede çözülmek istenen temel problemler şunlardır:

* Evdeki malzemelerle ne yapılacağını bilememe
* Uzun süre tarif arama ihtiyacı
* Eksik malzemelerin düzenli takip edilememesi
* Günlük beslenme hedeflerinin kontrol edilememesi
* Son kullanma tarihi yaklaşan ürünlerin unutulması
* Gıda israfının artması
* Tariflerin yeterince açık ve adım adım anlatılmaması

SmartChef AI, bu sorunları azaltmak için tarif önerisi, alışveriş listesi, beslenme bilgisi ve adım adım pişirme rehberini tek bir mobil uygulama içinde birleştirmektedir.

---

## 5. Hedef Kitle

Uygulama aşağıdaki kullanıcı gruplarına hitap etmektedir:

* Öğrenciler
* Çalışan bireyler
* Evde pratik yemek yapmak isteyen kullanıcılar
* Sağlıklı beslenmeye dikkat eden kişiler
* Spor yapan ve kalori/protein takibi yapmak isteyen kullanıcılar
* Alışveriş listesini düzenli takip etmek isteyen kişiler
* Gıda israfını azaltmak isteyen kullanıcılar
* Yemek yapmaya yeni başlayan kişiler

---

## 6. Kullanılan Teknolojiler ve Kütüphaneler

| Teknoloji / Kütüphane | Açıklama                                                             |
| --------------------- | -------------------------------------------------------------------- |
| Flutter               | Mobil uygulama geliştirme çatısı                                     |
| Dart                  | Uygulamanın geliştirildiği programlama dili                          |
| Material Design       | Arayüz bileşenleri ve sayfa tasarımları                              |
| Android Studio        | Projenin geliştirildiği IDE                                          |
| url_launcher          | Uygulama içinden YouTube tarif videosu açmak için kullanıldı         |
| GitHub                | Proje dosyalarının ve kaynak kodlarının paylaşılması için kullanıldı |

---

## 7. Uygulama Sayfaları ve Özellikleri

### 7.1 Keşfet Sayfası

Keşfet sayfası uygulamanın ana ekranıdır. Kullanıcı uygulamaya girdiğinde ilk olarak bu ekranı görür.

Bu ekranda bulunan özellikler:

* “Buzdolabında ne var?” tanıtım kartı
* Malzemeleri tara butonu
* Günlük tüketim kartı
* Su tüketimi kartı
* Yapay zeka analiz kartı
* Kişiye özel tarif önerileri
* Son kullanma tarihi yaklaşan ürünler bölümü

Bu sayfa, kullanıcıya uygulamanın genel amacını hızlıca anlatmak ve tarif önerilerine kolay erişim sağlamak için tasarlanmıştır.

---

### 7.2 Tara Sayfası

Tara sayfası, kullanıcının elindeki malzemeleri yazdığı ve tarif önerisi aldığı bölümdür.

Bu ekranda bulunan özellikler:

* Günlük kalori alımı bilgisi
* Protein, karbonhidrat ve yağ değerleri
* Yapay zeka analiz kartı
* Malzeme giriş alanı
* Akşam yemeği planını analiz et butonu
* Son kayıtlar bölümü
* Kullanıcıya öneri gösteren bildirim alanı

Demo sürümde kullanıcı malzeme alanına örnek olarak “somon”, “tavuk”, “makarna” veya “omlet” yazdığında uygulama buna uygun tarif detayına yönlendirme yapmaktadır.

---

### 7.3 Tarifler Sayfası

Tarifler sayfası, seçilen yemeğin detaylarının gösterildiği bölümdür.

Bu ekranda bulunan özellikler:

* Tarif görseli
* Tarif başlığı ve açıklaması
* Yapay zeka ipucu
* Kalori, protein, karbonhidrat ve yağ bilgileri
* Malzeme tabağı
* Mevcut ve eksik malzeme gösterimi
* Hazırlanış aşamaları
* Adım adım pişirme rehberi butonu
* Önerilen tarifler bölümü

Bu sayfa sayesinde kullanıcı, seçtiği yemeğin genel bilgilerini ve hazırlanış adımlarını hızlıca görebilir.

---

### 7.4 Adım Adım Pişirme Rehberi

Adım adım pişirme rehberi, kullanıcının tarifi gerçekten uygulayabilmesi için hazırlanmıştır.

Bu ekranda bulunan özellikler:

* Tarif videosu önizleme alanı
* YouTube tarif videosuna yönlendirme
* Toplam süre bilgisi
* Eksik malzeme sayısı
* Ön hazırlık kontrol listesi
* Detaylı adım adım yapılış anlatımı
* Her adım için süre bilgisi
* Pişirme sıcaklığı veya hazırlık bilgisi
* Şef notu
* Tarifi tamamladım butonu

Bu bölüm, sadece kısa tarif açıklaması vermek yerine kullanıcının yemeği gerçekten yapabilmesini sağlayacak şekilde detaylandırılmıştır.

---

### 7.5 Alışveriş Listesi Sayfası

Alışveriş listesi sayfası, eksik malzemelerin düzenli takip edilmesi için tasarlanmıştır.

Bu ekranda bulunan özellikler:

* AI akıllı öneri kartı
* Eksikleri ekle butonu
* Liste içinde arama alanı
* Instacart hazır butonu
* Filtre butonu
* Sebze & Meyve kategorisi
* Kiler kategorisi
* Checkbox ile malzeme işaretleme
* AI önerisi olan malzeme kartları
* Mağazada bul kartı
* Reyon bilgisi
* Ekolojik etki kartı
* Aile senkronizasyonu kartı
* Animasyonlu artı butonu

Bu ekran, kullanıcının alışverişe çıkmadan önce eksik ürünlerini daha düzenli takip etmesini ve gereksiz ürün alımını azaltmasını hedefler.

---

### 7.6 Profil Sayfası

Profil sayfası, kullanıcının uygulama içindeki genel bilgilerini ve hedeflerini gösterir.

Bu ekranda bulunan özellikler:

* Kullanıcı profil kartı
* Premium demo etiketi
* Günlük seri bilgisi
* Tarif sayısı
* Önlenen gıda israfı bilgisi
* Bugünkü hedefler kartı
* Kalori, protein ve su ilerleme çubukları
* Beslenme hedefleri menüsü
* Favori tarifler menüsü
* Mutfak envanteri menüsü
* Aile senkronizasyonu menüsü
* Ekolojik katkı kartı

Profil sayfası, uygulamanın sadece tarif gösteren bir yapı değil, aynı zamanda kişisel mutfak ve beslenme asistanı mantığıyla çalışmasını hedefler.

---

## 8. Demo Tarifler

Uygulama içerisinde örnek olarak aşağıdaki tarifler bulunmaktadır:

| Tarif Adı                     | Açıklama                                                  |
| ----------------------------- | --------------------------------------------------------- |
| Ballı Miso Soslu Somon Kasesi | Somon, avokado ve miso soslu dengeli bir yemek            |
| Akdeniz Gücü Salatası         | Tavuk, avokado ve yeşillik içeren yüksek proteinli salata |
| Sebzeli Makarna               | Pratik, ekonomik ve sebze ağırlıklı makarna               |
| Protein Omlet                 | Kahvaltı veya hafif öğün için protein odaklı omlet        |

Bu tariflerin her biri için besin değerleri, malzeme listesi, eksik malzeme durumu ve adım adım pişirme anlatımı hazırlanmıştır.

---

## 9. Proje Klasör Yapısı

Proje standart Flutter klasör yapısına sahiptir.

```text
smartchef_ai/
├── android/                     # Android platform dosyaları
│
├── assets/                      # Uygulamada kullanılan görseller
│   ├── icon/                    # Uygulama ikon dosyaları
│   └── images/                  # Yemek, market ve arayüz görselleri
│
├── lib/                         # Flutter kaynak kodları
│   └── main.dart                # Uygulamanın ana Dart dosyası
│
├── test/                        # Flutter test klasörü
│
├── .gitignore                   # Git'e gönderilmeyecek dosyalar
├── .metadata                    # Flutter proje metadata dosyası
├── analysis_options.yaml        # Dart analiz ayarları
├── pubspec.yaml                 # Proje bağımlılıkları ve asset tanımları
├── pubspec.lock                 # Paket sürüm kilit dosyası
└── README.md                    # Proje dokümantasyon dosyası
```

---

## 10. Kurulum Adımları

Projeyi çalıştırmak için bilgisayarda Flutter SDK ve Android Studio kurulu olmalıdır.

### 10.1 Projeyi GitHub'dan İndirme

```bash
git clone https://github.com/mervesaglik74-byte/smartchef_ai.git
```

```bash
cd smartchef_ai
```

### 10.2 Flutter Paketlerini Yükleme

```bash
flutter pub get
```

### 10.3 Bağlı Cihazları Kontrol Etme

```bash
flutter devices
```

### 10.4 Uygulamayı Çalıştırma

```bash
flutter run
```

Android Studio üzerinden çalıştırmak için:

1. Android Studio açılır.
2. Proje klasörü seçilir.
3. Üst kısımdan Android cihaz veya emülatör seçilir.
4. Run butonuna basılır.
5. Uygulama cihazda çalıştırılır.

---

## 11. Kullanım Talimatları

1. Uygulama açıldığında Keşfet sayfası görüntülenir.
2. Kullanıcı “Malzemeleri Tara” butonuna basarak Tara sayfasına geçebilir.
3. Tara sayfasında elindeki malzemeleri metin alanına yazar.
4. “Akşam Yemeği Planını Analiz Et” butonuna basılır.
5. Uygulama yazılan malzemeye göre uygun tarif ekranını açar.
6. Tarifler sayfasında yemeğin besin değerleri, malzemeleri ve hazırlanış aşamaları görüntülenir.
7. “Adım Adım Pişirme Rehberi” butonuna basıldığında detaylı pişirme anlatımı açılır.
8. Video alanına tıklandığında ilgili YouTube tarif videosu açılır.
9. Liste sayfasında eksik malzemeler ve alışveriş listesi takip edilebilir.
10. Profil sayfasında günlük hedefler ve kullanıcı bilgileri görüntülenebilir.

---

## 12. Projede Kullanılan Tasarım Yaklaşımı

Uygulamada modern, koyu temalı ve premium görünümlü bir tasarım dili tercih edilmiştir.

Tasarımda dikkat edilen noktalar:

* Koyu arka plan kullanımı
* Yeşil ve turuncu vurgu renkleri
* Yuvarlatılmış kart tasarımları
* Gölge ve derinlik efektleri
* Alt menü ile kolay gezinme
* Animasyonlu başlık renk geçişi
* Kullanıcıyı yormayan sade bilgi düzeni
* Beslenme, tarif ve alışveriş bilgilerini kartlar halinde sunma

Bu tasarım yaklaşımı sayesinde uygulamanın hem modern hem de anlaşılır bir kullanıcı deneyimi sunması hedeflenmiştir.

---

## 13. Mevcut Durum

Proje şu anda ders teslimi için hazırlanmış çalışan bir Flutter mobil uygulama prototipidir.

Mevcut sürümde tamamlanan başlıca özellikler:

* Ana sayfa tasarımı
* Malzeme giriş ekranı
* Demo tarif yönlendirme sistemi
* Tarif detay ekranı
* Adım adım pişirme rehberi
* YouTube video yönlendirmesi
* Alışveriş listesi ekranı
* Profil ekranı
* Modern alt menü navigasyonu
* Görsel asset kullanımı
* Flutter proje yapısının GitHub’a yüklenmesi

---

## 14. Geliştirilebilecek Özellikler

Proje ilerleyen sürümlerde daha gelişmiş hale getirilebilir.

Eklenebilecek özellikler:

* Gerçek yapay zeka API entegrasyonu
* Kamera ile malzeme tanıma
* Kullanıcı kayıt ve giriş sistemi
* Firebase veya Supabase veritabanı bağlantısı
* Tarifleri favorilere ekleme
* Haftalık yemek planı oluşturma
* Gerçek market entegrasyonu
* Barkod veya QR kod ile ürün ekleme
* Bildirim sistemi
* Son kullanma tarihi takibi
* Kalori ve makro değerlerin kişiye özel hesaplanması
* Çoklu kullanıcı ve aile hesabı desteği
* Tarif arama ve filtreleme sistemi

---

## 15. Ekran Görüntüleri

Proje ekran görüntüleri teslim dosyasına veya GitHub reposuna eklenebilir.

Örnek ekran görüntüleri:

* Keşfet ekranı
* Tara ekranı
* Tarif detay ekranı
* Adım adım pişirme rehberi ekranı
* Alışveriş listesi ekranı
* Profil ekranı

Ekran görüntüleri eklenmek istenirse aşağıdaki gibi bir klasör yapısı kullanılabilir:

```text
assets/screenshots/
├── kesfet.png
├── tara.png
├── tarifler.png
├── liste.png
└── profil.png
```

---

## 16. Kaynakça ve Yararlanılan Bağlantılar

* Flutter Resmi Dokümantasyonu: https://docs.flutter.dev/
* Dart Resmi Dokümantasyonu: https://dart.dev/
* Material Design: https://m3.material.io/
* url_launcher Paketi: https://pub.dev/packages/url_launcher
* GitHub Proje Bağlantısı: https://github.com/mervesaglik74-byte/smartchef_ai
* YouTube tarif videoları: Uygulama içindeki pişirme rehberi ekranlarında tariflere göre yönlendirme yapılmıştır.

---

## 17. Sonuç

SmartChef AI - Dijital Mutfak Şefi projesi, kullanıcıların günlük yemek planlama sürecini kolaylaştırmak için geliştirilmiş bir Flutter mobil uygulamasıdır. Uygulama; tarif önerisi, malzeme kontrolü, alışveriş listesi, beslenme takibi ve adım adım pişirme rehberi özelliklerini tek bir arayüzde birleştirmektedir.

Bu proje sayesinde mobil uygulama geliştirme, Flutter arayüz tasarımı, sayfalar arası geçiş, asset kullanımı, kullanıcı deneyimi tasarımı ve temel proje dokümantasyonu konularında uygulamalı çalışma yapılmıştır.
