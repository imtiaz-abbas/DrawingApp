//
//  AudioScreenController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 10/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

import UIKit
import Stevia
import AVFoundation

class AudioScreenController: UIViewController {
    let playButton = UIButton(type: UIButton.ButtonType.system)
    let stopButton = UIButton(type: UIButton.ButtonType.system)
    let screenSize = UIScreen.main.bounds
    var wasAudioPlaying = false
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appBackgroundEvent), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appForegroundEvent), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        view.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
        view.backgroundColor = .white
        
        //adding subviews to mainContainer
        view.sv(playButton, stopButton)
        var playButtonText = "Play"
        if (player?.isPlaying ?? false) {
            playButtonText = "Pause"
        }
        playButton.text(playButtonText)
        playButton.Left == 20
        playButton.Bottom == 40
        stopButton.Right == 20
        stopButton.Bottom == 40
        stopButton.text("Stop")
        playButton.addTarget(self, action: #selector(togglePlayer), for:.touchUpInside)
        stopButton.addTarget(self, action: #selector(stop), for:.touchUpInside)
        play()
    }
    
    @objc func stop() {
        player?.stop()
        player?.currentTime = 0
        playButton.text("Play")
    }
    
    func togglePlayerStatus() {
        if (player?.isPlaying ?? false) {
            player?.pause()
            playButton.text("Play")
        } else {
            player?.play()
            playButton.text("Pause")
        }
    }
    
    @objc func togglePlayer() {
     self.togglePlayerStatus()
    }
    
    @objc func appBackgroundEvent(_ notification: Notification) {
        if (player?.isPlaying ?? false) {
            self.wasAudioPlaying = true
            player?.pause()
            playButton.text("Play")
        } else {
            self.wasAudioPlaying = false
        }
    }
    @objc func appForegroundEvent(_ notification: Notification) {
        if (self.wasAudioPlaying) {
            player?.play()
            playButton.text("Pause")
            self.wasAudioPlaying = false
        }
    }
    
    func play(){
        if let asset = NSDataAsset(name:"sample"){
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"mp3")
                player?.play()
                playButton.text("Pause")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
