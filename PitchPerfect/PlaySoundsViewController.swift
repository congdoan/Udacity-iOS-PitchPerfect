//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Cong Doan on 10/8/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: - Audio properties
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: - Playback button types (raw values correspond to button tags)
    enum ButtonType: Int {
        case slowrate = 0, fastrate, highpitch, lowpitch, echo, reverb
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    // MARK: - IBActions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .slowrate:
            playSound(rate: 0.5)
        case .fastrate:
            playSound(rate: 1.5)
        case .highpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }
    
    // MARK: - ViewController lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Make image of playback buttons not stretched
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        
        configureUI(.notPlaying)
    }

}
