import AVFoundation

final class VideoManager {
    // MARK: - Properties
    var isVideoPlaying: Bool = false
    var videoPlayer: AVPlayer
    
    private var videoLayer: AVPlayerLayer
    
    // MARK: - Init
    init() {
        self.videoPlayer = AVPlayer()
        self.videoLayer = AVPlayerLayer(player: videoPlayer)
    }
    
    // MARK: - Public Methods
    func setupPlayer(withURL url: URL,
                     _ complition: @escaping (AVPlayerLayer, AVPlayerItem?) -> Void) {
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        
        complition(videoLayer, videoPlayer.currentItem)
    }
    
    func getPlayerLayer(withURL url: URL)  -> AVPlayerLayer {
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        
        return videoLayer
    }
    
    func playOrPause() {
        if isVideoPlaying {
            videoPlayer.pause()
        } else {
            videoPlayer.play()
        }
        
        isVideoPlaying = !isVideoPlaying
    }
    
    func rewindVideo(toValue value: Float) {
        videoPlayer.seek(to: CMTimeMake(value: Int64(value * 1000), timescale: 1000))
    }
}
