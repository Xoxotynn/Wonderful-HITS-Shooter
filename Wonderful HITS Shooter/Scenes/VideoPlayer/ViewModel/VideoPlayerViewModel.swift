import Foundation
import AVFoundation
import UIKit

final class VideoPlayerViewModel: NSObject {
    
    // MARK: - Properties
    var videoDurationString: String?
    var currentVideoDurationString: String?
    
    var didUpdateVideoLayer: ((AVPlayerLayer) -> Void)?
    var didPlayedVideo: (() -> Void)?
    var didPausedVideo: (() -> Void)?
    var didUpdateVideoDuration: (() -> Void)?
    var didUpdateCurrentVideoDuration: (() -> Void)?
    var didUpdateSliderValues: ((Float, Float) -> Void)?
    
    private let dependencies: Dependencies
    private let videoURL: URL
    private var videoPlayerItem: AVPlayerItem?
    private var wasBackgroundMusicPlaying: Bool = false
    
    // MARK: - Init
    init(dependencies: Dependencies, url: URL) {
        self.dependencies = dependencies
        self.videoURL = url
    }
    
    // MARK: - Public Methods
    func start() {
        stopMusicIfItsPlaying()
        
        dependencies.videoManager.setupPlayer(withURL: videoURL) { [weak self] playerLayer, videoPlayerItem in
            self?.addTimeObserver()
            self?.videoPlayerItem = videoPlayerItem
            self?.didUpdateVideoLayer?(playerLayer)
        }
    }
    
    func rewindVideo(toValue value: Float) {
        dependencies.videoManager.rewindVideo(toValue: value)
    }
    
    func playOrPauseVideo() {
        dependencies.videoManager.playOrPause()
        if dependencies.videoManager.isVideoPlaying {
            didPlayedVideo?()
        } else {
            didPausedVideo?()
        }
    }
    
    func setBackgroundMusicAndStopVideo() {
        if dependencies.videoManager.isVideoPlaying {
            dependencies.videoManager.playOrPause()
        }
        
        if wasBackgroundMusicPlaying {
            dependencies.audioManager.playBackgroundMusic()
        }
    }
    
    // MARK: - Private Methods
    private func stopMusicIfItsPlaying() {
        if dependencies.audioManager.isAudioPlaying {
            wasBackgroundMusicPlaying = true
            dependencies.audioManager.pauseBackgroundMusic()
        }
    }
    
    private func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        _ = dependencies.videoManager.videoPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let videoPlayerItem = self?.videoPlayerItem else {
                return
            }

            let fullDuration = Float(videoPlayerItem.duration.seconds)
            let currentDuration = Float(videoPlayerItem.currentTime().seconds)
            self?.videoDurationString = self?.getTimeString(from: videoPlayerItem.duration)
            self?.currentVideoDurationString = self?.getTimeString(from: videoPlayerItem.currentTime())
            
            self?.didUpdateSliderValues?(currentDuration, fullDuration)
            self?.didUpdateCurrentVideoDuration?()
            self?.didUpdateVideoDuration?()
        }
    }
    
    private func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds / 3600)
        let minutes = Int(totalSeconds / 60) % 60
        let seconds = Int(totalSeconds) % 60
        if hours > 0 {
            return String(format: Strings.timePatternWithHours, arguments: [
                hours,
                minutes,
                seconds
            ])
        } else {
            return String(format: Strings.timePatternWithoutHours, arguments: [
                minutes,
                seconds
            ])
        }
    }
}

// MARK: - Strings
private extension Strings {
    static let timePatternWithHours = "%i:%02i:$02i"
    static let timePatternWithoutHours = "%02i:%02i"
}
