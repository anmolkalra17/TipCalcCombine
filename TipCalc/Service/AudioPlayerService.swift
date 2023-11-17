//
//  AudioPlayerService.swift
//  TipCalc
//
//  Created by Anmol Kalra on 11/11/23.
//

import AVFoundation
import Foundation

protocol AudioPlayerService {
	func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
	
	private var player: AVAudioPlayer?
	
	func playSound() {
		let filePathURL = Bundle.main.url(forResource: "click", withExtension: "m4a")
		
		do {
			player = try AVAudioPlayer(contentsOf: filePathURL!)
			player?.play()
		} catch {
			print(error)
		}
	}
}
