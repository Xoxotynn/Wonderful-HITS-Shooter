import UIKit
import AVFoundation

class VideoPlayerViewController: BaseViewController {

    // MARK: - Properties
    private let videoContainerView = UIView()
    private let playButton = CustomButton()
    private let videoSlider = UISlider()
    private let currentVideoDurationLabel = UILabel()
    private let fullVideoDurationTimeLabel = UILabel()
    private let viewModel: VideoPlayerViewModel
    
    // MARK: - Actions
    @objc private func playOrPauseVideo() {
        viewModel.playOrPauseVideo()
    }
    
    @objc private func sliderValueDidChange(slider: UISlider) {
        viewModel.rewindVideo(toValue: slider.value)
    }
    
    // MARK: - Init
    init(viewModel: VideoPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.setBackgroundMusicAndStopVideo()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(videoContainerView)
        view.addSubview(playButton)
        view.addSubview(videoSlider)
        view.addSubview(currentVideoDurationLabel)
        view.addSubview(fullVideoDurationTimeLabel)
        
        setupVideoContainerView()
        setupPlayButton()
        setupVideoSlider()
        setupCurrentVideoDurationLabel()
        setupFullVideoDurationLabel()
    }
    
    private func setupVideoContainerView() {
        videoContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        videoContainerView.backgroundColor = .black
    }
    
    private func setupPlayButton() {
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(videoContainerView.snp.bottom).offset(Dimensions.large)
            make.width.height.equalTo(Dimensions.standartHeight)
        }
        
        playButton.setImage(UIImage(named: Images.play), for: .normal)
        playButton.configure()
        playButton.addTarget(self, action: #selector(playOrPauseVideo), for: .touchUpInside)
    }
    
    private func setupVideoSlider() {
        videoSlider.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(Dimensions.standart)
        }
        
        videoSlider.tintColor = .white
        videoSlider.minimumValue = 0
        videoSlider.addTarget(self, action: #selector(sliderValueDidChange(slider:)), for: .valueChanged)
    }
    
    private func setupCurrentVideoDurationLabel() {
        currentVideoDurationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Dimensions.medium)
            make.trailing.equalTo(videoSlider.snp.leading).offset(-Dimensions.standart)
            make.centerY.equalTo(videoSlider)
        }
        
        currentVideoDurationLabel.textAlignment = .center
        currentVideoDurationLabel.attributedText = NSAttributedString(
            string: Strings.startTime,
            attributes: StringAttributes.getStringAttributes(fontSize: 12))
    }
    
    private func setupFullVideoDurationLabel() {
        fullVideoDurationTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(videoSlider.snp.trailing).offset(Dimensions.standart)
            make.trailing.equalToSuperview().inset(Dimensions.medium)
            make.centerY.equalTo(videoSlider)
        }
        
        fullVideoDurationTimeLabel.textAlignment = .center
        fullVideoDurationTimeLabel.attributedText = NSAttributedString(
            string: Strings.startTime,
            attributes: StringAttributes.getStringAttributes(fontSize: 12))
    }
    
    private func setupVideoLayer(videoLayer: AVPlayerLayer) {
        videoLayer.frame = videoContainerView.bounds
        videoContainerView.layer.addSublayer(videoLayer)
    }
    
    private func bindToViewModel() {
        viewModel.didUpdateVideoLayer = { [weak self] videoLayer in
            self?.setupVideoLayer(videoLayer: videoLayer)
        }
        
        viewModel.didPlayedVideo = { [weak self] in
            self?.playButton.setImage(UIImage(named: Images.pause), for: .normal)
        }
        
        viewModel.didPausedVideo = { [weak self] in
            self?.playButton.setImage(UIImage(named: Images.play), for: .normal)
        }
        
        viewModel.didUpdateVideoDuration = { [weak self] in
            self?.fullVideoDurationTimeLabel.attributedText = NSAttributedString(
                string: self?.viewModel.videoDurationString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 12))
        }
        
        viewModel.didUpdateCurrentVideoDuration = { [weak self] in
            self?.currentVideoDurationLabel.attributedText = NSAttributedString(
                string: self?.viewModel.currentVideoDurationString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 12))
        }
        
        viewModel.didUpdateSliderValues = { [weak self] currentValue, maxValue in
            self?.videoSlider.value = currentValue
            self?.videoSlider.maximumValue = maxValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Images
private extension Images {
    static let play = "play"
    static let pause = "pause"
}

// MARK: - Strings
private extension Strings {
    static let startTime = "00:00"
}
