//
//  FavoriteManager.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 31.12.2024.
//

import Foundation

class FavoriteManager { // bu sınıfın içeriğin FavoriteItem class ına yazmıyoruz çünkü bu sınıf favori item'larla ilgili tüm işlevselliği (ekleme, kaldırma, listeleme, kaydetme vs.) tek bir yerde toplar. Böylece favori yönetiminin sorumluluğu tek bir sınıfa ait olur ve FavoriteItem sınıfı yalnızca veriyi taşır. Bu yöntem, ileride favorilerle ilgili daha fazla özellik eklemek gerektiğinde daha sürdürülebilir olacaktır (örneğin, favori item'ları sıralama, arama gibi)
    
    static var favoritesList: [FavoriteItem] = [] // Favori bilgilerini tutacak statik liste
    
    static func addFavoriteItem(_ favoriteItem: FavoriteItem) {
        favoritesList.append(favoriteItem)
        saveFavoritesToUserDefaults()
    }
    
    static func removeFavoriteItem(_ favoriteItem: FavoriteItem) {
        if let index = favoritesList.firstIndex(where: { $0.detailsItem.title == favoriteItem.detailsItem.title }) {
            favoritesList.remove(at: index)
            saveFavoritesToUserDefaults()
        }
    }
 
    // user defaults'a kaydetme (favoritesviewcontroller'da da bu fonksiyonu çağırıyoruz). viewdidload'lara yazmadık çünkü aynı kod favoritesviewcontroller'da da kullanılıyor
    static func saveFavoritesToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favoritesList) {
                UserDefaults.standard.set(encoded, forKey: "favoritesList")
                UserDefaults.standard.synchronize() // Verileri hemen kaydeder. kaydedilen son cell uygulama kapanıp açıldığında kayboluyordu. bu kodla kaybolmuyor
            }
        }
        
    static func loadFavoritesFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "favoritesList"),
            let decoded = try? decoder.decode([FavoriteItem].self, from: data) {
            favoritesList = decoded
        }
    }
}
