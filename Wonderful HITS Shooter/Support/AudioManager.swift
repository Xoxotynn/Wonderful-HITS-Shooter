import AVFoundation

final class AudioManager {
    // MARK: - Properties
    var isAudioPlaying: Bool {
        backgroundAudioPlayer.isPlaying
    }
    
    private var backgroundAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    private var nowPlaying: String = ""
    private var soundEffectsVolume: Float = 1.0
    private var musicVolume: Float = 1.0 {
        didSet {
            backgroundAudioPlayer.volume = musicVolume
        }
    }
    
    // MARK: - Public Methods
    func play(audio: String, needToLoop: Bool = false) {
        
        guard audio != nowPlaying else { return }
        
        do {
            nowPlaying = audio
            
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
    
    func playBackgroundMusic() {
        backgroundAudioPlayer.play()
    }
    
    func pauseBackgroundMusic() {
        backgroundAudioPlayer.pause()
    }
}

// MARK: - Strings
private extension Strings {
    static let audioType = "mp3"
}
