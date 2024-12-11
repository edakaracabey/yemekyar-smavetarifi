# Yemek Yarışması Uygulaması

Bu proje, bir yemek yarışması uygulaması olarak tasarlanmıştır. Katılımcılar yemek tariflerini ekleyebilir, puan verebilir ve yarışmaya katılan yemekler arasından en yüksek puan alan tarifler önerilebilir. Ayrıca, kullanıcılar ellerindeki malzemeleri girerek bu malzemelerle yapabilecekleri yemekleri öğrenebilirler.

## Özellikler
- **Yemek Tarifleri Yönetimi:** Yemek tarifi oluşturma, okuma, güncelleme ve silme.
- **Puanlama:** Tariflere puan vererek en iyi tarifleri belirleme.
- **Malzeme Önerisi:** Kullanıcıların mevcut malzemelerine göre yapılabilecek yemekleri önerme.
- **Yarışma Verileri:** En yüksek puan alan tarifler üzerinden öneri sistemi.

---

## Proje Yapısı

### Tipler
- **RecipeId:** Her tarif için benzersiz bir kimlik (Nat32 türünde).
- **Recipe:** Tarif bilgilerini içeren yapı:
  - **name (Text):** Yemek adı.
  - **ingredients (List<Text>):** Tarif için gereken malzemeler.
  - **preparationTime (Nat32):** Hazırlama süresi (dakika).
  - **rating (Nat32):** Puan (1-5 arası).

```motoko
public type RecipeId = Nat32;

public type Recipe = {
  name : Text;
  ingredients : List.List<Text>;
  preparationTime : Nat32; // Dakika cinsinden
  rating : Nat32; // 1-5 puan arası
};
