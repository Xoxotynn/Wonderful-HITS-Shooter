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
    func setupPlayer(withURL url: URL = URL.init(fileURLWithPath: Bundle.main.path(forResource: Strings.videoName, ofType: Strings.videoType) ?? ""),
                     _ complition: @escaping (AVPlayerLayer, AVPlayerItem?) -> Void) {
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.videoGravity = .resizeAspectFill
        
        complition(videoLayer, videoPlayer.currentItem)
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

private extension Strings {
    static let videoName = "SuperMoovik"
    static let videoType = "mov"
}
