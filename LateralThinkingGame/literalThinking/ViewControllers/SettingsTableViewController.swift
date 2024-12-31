//
//  SettingsTableViewController.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 24.12.2024.
//

import UIKit
import StoreKit // feedback için

class SettingsTableViewController: UITableViewController {
    
    // Bu dizide her section için kaç tane row olacağını belirliyoruz.
    let numberOfRowsInSections = [6, 2]  // İlk section'da 6, ikinci section'da 2 row olacak
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemRed
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance // bunların altta olması gerekiyor, navigation kodlarının üstünde olunca çalışmıyor navigation kodları. bunun sebebi self.navigationItem'ın tam olarak yüklenmesi ve konfigüre edilmesinden sonra appearance yapılandırmalarının uygulanması gerekmesi
        
        // uygulama ilk defa yüklendiğinde, UserDefaults'ta sound için olan switch butonunda (switch_0) güncelleme olmadığı için varsayılan olarak "açık" yap
        if UserDefaults.standard.object(forKey: "switch_0") == nil {
            UserDefaults.standard.set(true, forKey: "switch_0") // default olarak açık
        }
        // uygulama ilk defa yüklendiğinde, UserDefaults'ta dark mode için olan switch butonunda (switch_1) güncelleme olmadığı için varsayılan olarak "kapalı" yap
        if UserDefaults.standard.object(forKey: "switch_1") == nil {
            UserDefaults.standard.set(false, forKey: "switch_1") // default olarak kapalı
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if MusicPlayer.shared.isPlaying { // müziğin sesini azaltarak durdur
            MusicPlayer.shared.fadeOutMusic()
        }
        
        tableView.reloadData()
    }

}
    
    extension SettingsTableViewController {


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfRowsInSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRowsInSections[section]
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        // Static cell kullanıldığında hücreyi storyboard'dan otomatik olarak alır. yani identifier belirtmek gerekmez
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
            
        // birinci ve ikinci row a switch butonu ekleme. swiftte accesoryview özelliği cell in en sağında tanımlı olduğu için otomatik en sağa ekleme yapıyor sanırım
        if indexPath.section == 0 , (indexPath.row == 0 || indexPath.row == 1) { // eğer birinci section ın bir ve ikinci row undaysak
                // Switch butonu ekleme. switch botonu swiftte tanımlı bir buton
                let switchControl = UISwitch()
                // Kaydedilen durumu yükle
                let key = "switch_\(indexPath.row)"
                let isOn = UserDefaults.standard.bool(forKey: key)
                switchControl.isOn = isOn // başlangıçta butonu kapalı tut
                switchControl.tag = indexPath.row // Ayırt etmek için tag
                cell.accessoryView = switchControl
            
                // switch butonunun boyutunu küçültmek için transform kullan
                let scaleX: CGFloat = 0.9 // %90 boyutunda yapmak için
                let scaleY: CGFloat = 0.8
                switchControl.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
                switchControl.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            }
        return cell
    }
        
    @objc func switchChanged(_ sender: UISwitch) {
            
        let key = "switch_\(sender.tag)"
        // Switch durumunu kaydet
        UserDefaults.standard.set(sender.isOn, forKey: key)
            
        if sender.tag == 0 { // birinci switch butonu yani sound un yanındaki switch
            
            print("First row switch is now \(sender.isOn ? "ON" : "OFF")")
                
        } else if sender.tag == 1 { // ikinci switch butonu yani dark mode un yanındaki switch
                
            // Eğer ikinci switch ON ise Dark Mode'a geç, OFF ise Light Mode'a geç
            if sender.isOn {
                // Dark Mode'a geçiş
                UserDefaults.standard.set(true, forKey: "switch_1")
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.window?.overrideUserInterfaceStyle = .dark
                }
            } else {
                // Light Mode'a geçiş
                UserDefaults.standard.set(false, forKey: "switch_1")
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.window?.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // İkinci section'ın ilk row'una tıklandığında "Rate Us" pop-up'ı göster
        if indexPath.section == 1 && indexPath.row == 0 {
            
            if let scene = view.window?.windowScene { // Kullanıcıyı puan vermeye yönlendirmek için AppStore.requestReview(in:) kullan
                AppStore.requestReview(in: scene)
            }
        }
    }
        
        
        
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { // iki section arasına seperator çizgisi ekleme
    
        // başlangıçta bütün seperator leri kaldırmak için main de seperator u none yapıyoruz

        if indexPath.section == 1 && indexPath.row == 0 { // İkinci section'ın ilk hücresine üst çizgi ekle
            let separator = CALayer()
            separator.backgroundColor = UIColor.systemGray4.cgColor
            separator.frame = CGRect(x: 15, y: 0, width: cell.bounds.width - 30, height: 0.3) // Çizgi pozisyonu (sağ ve soldan 15 boşluk bırak) ve kalınlığı (height)
            cell.layer.addSublayer(separator)
        }
    }


}
