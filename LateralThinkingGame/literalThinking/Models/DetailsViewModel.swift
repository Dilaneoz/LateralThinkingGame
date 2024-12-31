//
//  DetailsViewModel.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 31.12.2024.
//

import UIKit

class DetailsViewModel {
    private let section: Int

    init(section: Int) {
        self.section = section
    }

    /// Hücre sayısını döndürür.
    func numberOfItemsInSection() -> Int {
        guard section < GameData.gameTitle.count else { return 0 }
        return GameData.gameTitle[section].count
    }

    /// Verilen indexPath'e göre başlığı döndürür.
    func getTitle(for indexPath: IndexPath) -> String {
        guard indexPath.section < GameData.gameTitle.count,
              indexPath.row < GameData.gameTitle[section].count else { return "" }
        return GameData.gameTitle[section][indexPath.row]
    }

    /// Verilen indexPath'e göre başlık rengini döndürür.
    func getTitleColor(for indexPath: IndexPath) -> UIColor {
        guard indexPath.section < GameData.scenarioTitleColor.count,
              indexPath.row < GameData.scenarioTitleColor[section].count else { return .black }
        return GameData.scenarioTitleColor[section][indexPath.row]
    }

    /// Verilen indexPath'e göre görseli döndürür.
    func getImage(for indexPath: IndexPath) -> UIImage? {
        guard indexPath.section < GameData.scenarioImages.count,
              indexPath.row < GameData.scenarioImages[section].count else { return nil }
        let imageName = GameData.scenarioImages[section][indexPath.row]
        return UIImage(named: imageName)
    }

    /// Verilen indexPath'e göre tik işaretinin rengini döndürür.
    func getCheckmarkColor(for indexPath: IndexPath) -> UIColor {
        guard indexPath.section < GameData.checkmarkButton.count,
              indexPath.row < GameData.checkmarkButton[section].count else { return .black }
        return GameData.checkmarkButton[section][indexPath.row]
    }

    /// Verilen indexPath'e göre çözülme durumunu döndürür.
    func isSolved(for indexPath: IndexPath) -> Bool {
        let key = "isSolved_Section\(section)_Row\(indexPath.row)"
        return !UserDefaults.standard.bool(forKey: key)
    }

    /// Verilen indexPath'e göre favori yıldız ikonunu döndürür.
    func getFavoriteImage(for indexPath: IndexPath) -> UIImage? {
        let isFavorite = FavoriteManager.favoritesList.contains { $0.section == section && $0.row == indexPath.row }
        return UIImage(systemName: isFavorite ? "star.fill" : "star")
    }
}
