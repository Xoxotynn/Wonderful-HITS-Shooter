//
//  SettingsViewModel.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 16.01.2022.
//

import Foundation

final class SettingsViewModel {
    // MARK: - Properties
    var didSetMusicVolume: ((Float) -> Void)?
    var didSetSoundEffectsVolume: ((Float) -> Void)?
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        didSetMusicVolume?(dependencies.userDefaultsManager.getMusicVolume() ?? 1.0)
        didSetSoundEffectsVolume?(dependencies.userDefaultsManager.getSoundEffectsVolume() ?? 1.0)
    }
    
    func changeMusicVolume(toValue value: Float) {
        dependencies.audioManager.setMusicVolume(toValue: value)
    }
    
    func changeSoundEffectsVolume(toValue value: Float) {
        dependencies.audioManager.setSoundEffectsVolume(toValue: value)
    }
    
    func saveMusicVolumeToUserDefaults(value: Float) {
        dependencies.userDefaultsManager.setMusicVolume(value: value)
    }
    
    func saveSoundEffectsVolumeToUserDefaults(value: Float) {
        dependencies.userDefaultsManager.setSoundEffectsVolume(value: value)
    }
}
