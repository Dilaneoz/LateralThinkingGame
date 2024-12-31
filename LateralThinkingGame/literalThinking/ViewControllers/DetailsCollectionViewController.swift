//
//  DetailsCollectionViewController.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 29.10.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailsCollectionViewController: UICollectionViewController {
    
    var sectionTitles: [String] = []
    var sectionImages: [String] = []
    var sectionName: String? // Başlık için
    var sectionTitleColors: [UIColor] = []
    var selectedSection: Int = 0 // MainViewController'dan gelen section bilgisi
    var detailsCheckmarkButton: [UIColor] = []
 //   var detailsFavoriteButton: [UIColor] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        // FavoritesCollectionViewController'daki favori butonuna tıklandığında DetailsCollectionViewController'a haber verip buradaki butonun image'ını 'star' a dönüştürmek için:
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteStatusChanged), name: Notification.Name("FavoriteStatusChanged"), object: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if MusicPlayer.shared.isPlaying { // müziğin sesini azaltarak durdur
            MusicPlayer.shared.fadeOutMusic()
        }
        
        // Favori listesini UserDefaults'tan yükle
        FavoriteManager.loadFavoritesFromUserDefaults()
        
        // Koleksiyon görünümünü yenile
        collectionView.reloadData() 
    }
    
    // FavoritesCollectionViewController'daki favori butonuna tıklandığında DetailsCollectionViewController'a haber verip buradaki butonun image'ını 'star' a dönüştürmek için:
    @objc func favoriteStatusChanged() {
        // Bu fonksiyon, favori butonundaki değişiklikleri takip eder ve ilgili hücreyi günceller
        collectionView.reloadData()  // Favori durumunu yansıtmak için tüm collection view'ı yeniden yükleyin
    }
    deinit {
        // Bildirim dinleyicisini kaldır
        NotificationCenter.default.removeObserver(self, name: Notification.Name("FavoriteStatusChanged"), object: nil)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        
        guard let cell = sender.superview?.superview as? DetailsCollectionViewCell,  // sender'ı UIButton olarak cast ediyoruz
            // UIButton'ın üst görünümlerinden hücreyi buluyoruz
            let indexPath = collectionView.indexPath(for: cell) else { return }
        
        
        let selectedDetailsItem = DetailsItem( // İlgili `DetailsItem`'i veri kaynağından al. bu kısımda favoritesviewcontroller'da gözüken dataları aktarıyoruz
            imageName: sectionImages[indexPath.row],
            title: sectionTitles[indexPath.row],
            titleColor: ColorWrapper(color: sectionTitleColors[indexPath.row])

        )
        let selectedGameScenario = ScenariosItem( // bu kısımda favoritesviewcontroller'daki cell e tıklandığında scenariosviewcontroller a geçilirkenki aktarımları yapıyoruz
            gameScenario: GameData.gameScenarios[selectedSection][indexPath.row], // `gameScenario`yu `gameScenarios` dizisinden al
            backImage: GameData.scenarioImages[selectedSection][indexPath.row],
            frontImage: GameData.visualImages[selectedSection][indexPath.row],
            titleColor: ColorWrapper(color: GameData.scenarioTitleColor[selectedSection][indexPath.row]),
            lableColor: ColorWrapper(color: GameData.scenariosLabelColors[selectedSection][indexPath.row]),
            solutionButtonColor: ColorWrapper(color: GameData.solutionButtonColor[selectedSection][indexPath.row]),
            solutionButtonFrameColor: ColorWrapper(color: GameData.solutionButtonFrameColor[selectedSection][indexPath.row]),
            checkmarkButtonColor: ColorWrapper(color: GameData.checkmarkButton[selectedSection][indexPath.row])
        )
        let favoriteItem = FavoriteItem( // Bu kısımda da favoritesviewcontroller ve sonrasondaki scenariosviewcontroller'da gözükecek dataların section ve row bilgisi aktarılıyor
            section: selectedSection,
            row: indexPath.row,
            detailsItem: selectedDetailsItem,
            scenarioDetails: selectedGameScenario
        )
            
        // Eğer item zaten favorilerdeyse kaldır
        if FavoriteManager.favoritesList.contains(where: { $0.detailsItem.title == favoriteItem.detailsItem.title }) {
                FavoriteManager.removeFavoriteItem(favoriteItem)
            sender.setImage(UIImage(systemName: "star"), for: .normal) // İçi boş yıldız
                print("Favori kaldırıldı")
            } else {
                FavoriteManager.addFavoriteItem(favoriteItem) // yoksa ekle
                sender.setImage(UIImage(systemName: "star.fill"), for: .normal) // İçi dolu yıldız
                print("Favori eklendi")
            }
        FavoriteManager.saveFavoritesToUserDefaults()
    }
    
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemRed
        
        self.navigationController?.navigationBar.tintColor = UIColor.systemBackground // back butonu rengi
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground, .font: UIFont.systemFont(ofSize: 20)] // navigation bar başlık metninin rengi, yazı tipi ve boyutu
            
        if let sectionName = sectionName { // navigation item a section adını yazdır
                self.navigationItem.title = sectionName
            }
        
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance // bunların neden altta olması gerekiyor, navigation kodlarının üstünde olunca çalışmıyor navigation kodları
        }
    
}

extension DetailsCollectionViewController: UICollectionViewDelegateFlowLayout  {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toScenarios",
           let destinationVC = segue.destination as? ScenariosViewController {
            
            if let scenariosDatas = sender as? (String, String, String, String, UIColor, UIColor, UIColor, UIColor, Int, UIColor) {
                
                destinationVC.scenariosImages = scenariosDatas.0
                destinationVC.visualImages = scenariosDatas.1
                destinationVC.gameTitle = scenariosDatas.2
                destinationVC.gameScenario = scenariosDatas.3
                destinationVC.scenarioLabelColor = scenariosDatas.4
                destinationVC.scenarioTitleColor = scenariosDatas.5
                destinationVC.solutionButtonColor = scenariosDatas.6
                destinationVC.solutionButtonFrameColor = scenariosDatas.7
                destinationVC.selectedSection = selectedSection
                destinationVC.selectedIndexPathRow = scenariosDatas.8
                destinationVC.scenarioCheckmarkButton = scenariosDatas.9
            }
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sectionTitles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailsCollectionViewCell
        
        cell.detailsLabel.text = sectionTitles[indexPath.row]
        cell.detailsImage.image = UIImage(named: sectionImages[indexPath.row])
        
        // Her label için farklı renk atama
        if indexPath.row < sectionTitleColors.count {
            cell.detailsLabel.textColor = sectionTitleColors[indexPath.row]
        } else {
            cell.detailsLabel.textColor = .systemBackground // sectionTitleColors değerleri olması gerekenden azsa, yani eksik değer varsa
        }
       
      //  cell.detailsFavoriteButton.tintColor = .tintColor
        
        if indexPath.row < detailsCheckmarkButton.count {
            cell.detailsCheckmarkButton.tintColor = detailsCheckmarkButton[indexPath.row]
        } else {
            cell.detailsCheckmarkButton.tintColor = .black
        }
        /*
        if indexPath.row < detailsFavoriteButton.count {
            cell.detailsFavoriteButton.tintColor = detailsFavoriteButton[indexPath.row]
        } else {
            cell.detailsFavoriteButton.tintColor = .black
        }
        */
        cell.selectedIndexPathRow = indexPath.row // detailscollectionviewcell deki rowindex değerini detailscollectionviewcontroller daki indexpath e set et
        cell.selectedSection = selectedSection
        
        // UserDefaults'tan durumları kontrol ederek buton görünürlüğünü ayarla
        let key = "isSolved_Section\(selectedSection)_Row\(indexPath.row)"
        let isSolved = UserDefaults.standard.bool(forKey: key)
        cell.detailsCheckmarkButton.isHidden = !isSolved
        
        // favori butonuna tıklandığında değişen buton image ındaki değişikliği uygulama kapanıp açıldığında kaydetmek için:
        let isFavorite = FavoriteManager.favoritesList.contains(where: { $0.section == selectedSection && $0.row == indexPath.row })
        if isFavorite {
            cell.detailsFavoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) // İçi dolu yıldız
        } else {
            cell.detailsFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal) // İçi boş yıldız
        }
        
        return cell
    }
    
    // cell ler arasındaki boşluk olmaması için
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let totalSpacing = 0 // (minimumInteritemSpacing + sectionInset toplamı)
            let numberOfItemsPerRow: CGFloat = 2 // Kaç sütun istediğiniz
            let width = (collectionView.frame.width - CGFloat(totalSpacing) ) / numberOfItemsPerRow
        
            return CGSize(width: floor(width), height: 160)
    }
    // cell ler arasındaki boşluk olmaması için
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Satır boşlukları
    }
    // cell ler arasındaki boşluk olmaması için
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Hücreler arası boşluk
    }
    // cell ler arasındaki boşluk olmaması için
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Kenar boşlukları
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedVisualName = GameData.visualImages[selectedSection][indexPath.row] // selectedSection ile section bilgisi veriyoruz (kaçıncı section'dan gelicek bilgiler)
        let selectedImageName = GameData.scenarioImages[selectedSection][indexPath.row]
        let selectedTitleName = GameData.gameTitle[selectedSection][indexPath.row]
        let selectedGameScenario = GameData.gameScenarios[selectedSection][indexPath.row]
        let selectedLabelColor = GameData.scenariosLabelColors[selectedSection][indexPath.row]
        let selectedTitleColor = GameData.scenarioTitleColor[selectedSection][indexPath.row]
        let selectedSolutionButtonColor = GameData.solutionButtonColor[selectedSection][indexPath.row]
        let selectedSolutionButtonFrameColor = GameData.solutionButtonFrameColor[selectedSection][indexPath.row]
        let selectedCheckmark = GameData.checkmarkButton[selectedSection][indexPath.row]
        performSegue(withIdentifier: "toScenarios", sender: (selectedImageName, selectedVisualName, selectedTitleName, selectedGameScenario, selectedLabelColor, selectedTitleColor,selectedSolutionButtonColor, selectedSolutionButtonFrameColor, indexPath.row, selectedCheckmark)) // buradaki indexPath.row hangi cell e tıklandığı bilgisini diğer viewcontroller lara göndermek için oluşturuldu
    }
    
}
