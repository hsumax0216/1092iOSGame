//
//  AVPlayer_Extensions.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/16.
//

import UIKit
import AVFoundation
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.play()

        return true
    }
}


extension AVPlayer {
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    static func setupBgMusic(){
        guard let url = Bundle.main.url(forResource: "GuitarHouse-joshpan", withExtension: "mp3")
        else{
            fatalError("Failed to find sound file.")
        }
        let item = AVPlayerItem(url:url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
        bgQueuePlayer.volume = 0.25
    }
    
    static let sharedCorrectPlayer: AVPlayer = {
         guard let url = Bundle.main.url(forResource: "cerrect_answer", withExtension:"mp3")
         else{
            fatalError("Failed to find sound file.")
         }
         return AVPlayer(url: url)
    }()

    static let sharedErrorPlayer: AVPlayer = {
         guard let url = Bundle.main.url(forResource: "error_answer", withExtension:"mp3")
         else{
            fatalError("Failed to find sound file.")
         }
         return AVPlayer(url: url)
    }()

    func playFromStart() {
        seek(to: .zero)
        play()
    }
}
