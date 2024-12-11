import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor YemekYarismasi {

  /**
   * Types
   */

  // Yemek türü kimliği
  public type RecipeId = Nat32;

  // Yemek türü
  public type Recipe = {
    name : Text;
    ingredients : List.List<Text>;
    preparationTime : Nat32; // Dakika cinsinden
    rating : Nat32; // 1-5 puan arası
  };

  /**
   * Application State
   */

  // Yeni yemek kimliği için sayaç
  private stable var nextRecipeId : RecipeId = 0;

  // Yemek verisi saklama alanı
  private stable var recipes : Trie.Trie<RecipeId, Recipe> = Trie.empty();

  /**
   * High-Level API
   */

  // Yeni yemek oluştur
  public func create(recipe : Recipe) : async RecipeId {
    let recipeId = nextRecipeId;
    nextRecipeId += 1;
    recipes := Trie.replace(
      recipes,
      key(recipeId),
      Nat32.equal,
      ?recipe,
    ).0;
    return recipeId;
  };

  // Yemek verisini oku
  public query func read(recipeId : RecipeId) : async ?Recipe {
    let result = Trie.find(recipes, key(recipeId), Nat32.equal);
    return result;
  };

  // Yemek güncelle
  public func update(recipeId : RecipeId, recipe : Recipe) : async Bool {
    let result = Trie.find(recipes, key(recipeId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      recipes := Trie.replace(
        recipes,
        key(recipeId),
        Nat32.equal,
        ?recipe,
      ).0;
    };
    return exists;
  };

  // Yemek sil
  public func delete(recipeId : RecipeId) : async Bool {
    let result = Trie.find(recipes, key(recipeId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      recipes := Trie.replace(
        recipes,
        key(recipeId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

public func puanla(puan: Nat32, id: RecipeId) : async Nat32 {
    let result = Trie.find(recipes, key(id), Nat32.equal);
    let exists = Option.isSome(result);

    if (exists) {
        let temp = Option.unwrap(result);

        // Yeni Recipe nesnesini oluştururken doğru türdeki alanlara erişim sağlıyoruz
        let updateRating: Recipe = {
            name = temp.name;
            ingredients = temp.ingredients;
            preparationTime = temp.preparationTime; // Dakika cinsinden
            rating = puan; // 1-5 puan arası
        };

        // recipes'i güncelle
        recipes := Trie.replace(
            recipes,
            key(id),
            Nat32.equal,
            ?updateRating,
        ).0;
    };

    0
};


  /**
   * Utilities
   */

  // Yemek kimliğinden trie anahtarı oluştur
  private func key(x : RecipeId) : Trie.Key<RecipeId> {
    return { hash = x; key = x };
  };

};
