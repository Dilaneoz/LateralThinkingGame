//
//  MusicPlayer.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 29.12.2024.
//

import AVFoundation

class MusicPlayer {
    
    static let shared = MusicPlayer() // diğer viewcontroller lardan MusicPlayer class ına erişmek için
    private var audioPlayer: AVAudioPlayer?
    
    private init() {} // Singleton olduğu için dğer VC'lardan başlatılamamasını sağlar. diğer VC'larda "let musicPlayer = MusicPlayer()" gibi bi kod yazılamaz ve MusicPlayer.shared denilerek erişim sağlanabilir. bu tasarruf açısından iyidir. diğer VC'larda "let musicPlayer = MusicPlayer()" diyerek yeni nesneler oluşturmaya gerek kalmaz
    
    var isPlaying: Bool { // diğer viewcontroller lardan müziğin çalıp çalmadığını kontrol etmek için (diğer controllerlardaki "if MusicPlayer.shared.isPlaying" kısmı)
            return audioPlayer?.isPlaying ?? false
        }
    
    func playMusic(named fileName: String, fileType: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Müzik dosyası bulunamadı: \(fileName).\(fileType)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Sonsuz döngü şeklinde çal
            audioPlayer?.play()
        } catch {
            print("Müzik çalma hatası: \(error.localizedDescription)")
        }
    }
    
    func stopMusic() { // müziği durdur
            audioPlayer?.stop()
        }
    
    func fadeOutMusic() { // müziğin sesini azaltarak durdur
        
        guard let player = audioPlayer else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in // Ses azaltma için bir zamanlayıcı başlat
            if player.volume > 0.1 {
                player.volume -= 0.1 // Ses seviyesini azalt
            } else {
                player.volume = 0
                player.stop() // Ses sıfırlandığında çalmayı durdur
                timer.invalidate() // Zamanlayıcıyı durdur
            }
        }
    }
}
