//
//  SettingsViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 16.01.2022.
//

import UIKit

class SettingsViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    private let musicSliderTitleLabel = UILabel()
    private let musicVolumeSlider = VolumeSlider()
    private let soundEffectsTitleLabel = UILabel()
    private let soundEffectsVolumeSlider = VolumeSlider()
    private let viewModel: SettingsViewModel
    
    // MARK: - Actions
    @objc private func musicVolumeSliderDidChangeValue(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .ended:
                viewModel.changeMusicVolume(toValue: musicVolumeSlider.value,
                                            needToSave: true)
            default:
                viewModel.changeMusicVolume(toValue: musicVolumeSlider.value)
            }
        }
    }
    
    @objc private func soundEffectsVolumeSliderDidChangeValue(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .ended:
                viewModel.changeSoundEffectsVolume(toValue: soundEffectsVolumeSlider.value,
                                                   needToSave: true)
            default:
                viewModel.changeSoundEffectsVolume(toValue: soundEffectsVolumeSlider.value)
            }
        }
    }
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(musicSliderTitleLabel)
        view.addSubview(musicVolumeSlider)
        view.addSubview(soundEffectsTitleLabel)
        view.addSubview(soundEffectsVolumeSlider)
        
        setupTitleLabel()
        setupMusicSliderTitleLabel()
        setupMusicVolumeSlider()
        setupSoundEffectsTitleLabel()
        setupSoundEffectsVolumeSlider()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
        }
        
        titleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.large))
        titleLabel.text = Strings.settings
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupMusicSliderTitleLabel() {
        musicSliderTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.medium)
        }
        
        musicSliderTitleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.medium))
        musicSliderTitleLabel.text = Strings.musicVolume
        musicSliderTitleLabel.numberOfLines = 0
        musicSliderTitleLabel.textAlignment = .center
    }
    
    private func setupMusicVolumeSlider() {
        musicVolumeSlider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(musicSliderTitleLabel.snp.bottom).offset(Dimensions.standart)
        }
        
        musicVolumeSlider.addTarget(self, action: #selector(musicVolumeSliderDidChangeValue(slider:event:)), for: .valueChanged)
    }
    
    private func setupSoundEffectsTitleLabel() {
        soundEffectsTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(musicVolumeSlider.snp.bottom).offset(Dimensions.medium)
        }
        
        soundEffectsTitleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.medium))
        soundEffectsTitleLabel.text = Strings.soundEffectsVolume
        soundEffectsTitleLabel.numberOfLines = 0
        soundEffectsTitleLabel.textAlignment = .center
    }
    
    private func setupSoundEffectsVolumeSlider() {
        soundEffectsVolumeSlider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(soundEffectsTitleLabel.snp.bottom).offset(Dimensions.standart)
        }
        
        soundEffectsVolumeSlider.addTarget(self, action: #selector(soundEffectsVolumeSliderDidChangeValue(slider:event:)), for: .valueChanged)
    }
    
    private func bindToViewModel() {
        viewModel.didSetMusicVolume = { [weak self] volumeValue in
            self?.musicVolumeSlider.value = volumeValue
        }
        
        viewModel.didSetSoundEffectsVolume = { [weak self] volumeValue in
            self?.soundEffectsVolumeSlider.value = volumeValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Strings {
    static let settings = "Настройки"
    static let musicVolume = "Громкость музыки"
    static let soundEffectsVolume = "Громкость звуковых эффектов"
}
