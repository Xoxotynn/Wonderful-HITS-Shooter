//
//  AudioPlayer.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 16.01.2022.
//

import Foundation
import AVFoundation

final class AudioManager {
    // MARK: - Properties
    private var backgroundAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    private var musicVolume: Float = 1.0 {
        didSet {
            backgroundAudioPlayer.volume = musicVolume
        }
    }
    
    private var soundEffectsVolume: Float = 1.0
    
    // MARK: - Public Methods
    func play(audio: String, needToLoop: Bool = false) {
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audio, ofType: Strings.audioType) ?? ""))
            
            if needToLoop {
                backgroundAudioPlayer.numberOfLoops = -1
            }
            
            backgroundAudioPlayer.volume = musicVolume
            backgroundAudioPlayer.prepareToPlay()
            backgroundAudioPlayer.play()
            
        } catch {
            print(error)
        }
    }
    
    func playSoundEffect(audio: String) {
        do {
            let player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audio, ofType: Strings.audioType) ?? ""))
            player.volume = soundEffectsVolume
            player.prepareToPlay()
            player.play()
            
        } catch {
            print(error)
        }
    }
    
    func setMusicVolume(toValue value: Float) {
        musicVolume = value
    }
    
    func setSoundEffectsVolume(toValue value: Float) {
        soundEffectsVolume = value
    }
}

// MARK: - Strings
private extension Strings {
    static let audioType = "mp3"
}
