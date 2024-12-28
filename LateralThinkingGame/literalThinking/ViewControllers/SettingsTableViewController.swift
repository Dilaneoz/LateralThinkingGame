//
//  SettingsTableViewController.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 24.12.2024.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // Bu dizide her section için kaç tane row olacağını belirliyoruz.
    let numberOfRowsInSections = [6, 2]  // İlk section'da 6, ikinci section'da 2 row olacak
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemRed
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance // bunların altta olması gerekiyor, navigation kodlarının üstünde olunca çalışmıyor navigation kodları. bunun sebebi self.navigationItem'ın tam olarak yüklenmesi ve konfigüre edilmesinden sonra appearance yapılandırmalarının uygulanması gerekmesi

        
    }
}
    
    extension SettingsTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfRowsInSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRowsInSections[section]
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

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
