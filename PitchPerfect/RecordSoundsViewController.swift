//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Cong Doan on 10/6/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Audio properties
    var audioRecorder: AVAudioRecorder!

    // MARK: - IBOutlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!

    // MARK: - ViewController lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

    // MARK: - IBActions
    @IBAction func recordAudio(_ sender: Any) {
        updateUIState(recording: true)
        startRecordingSounds()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        updateUIState(recording: false)
        stopRecordingSounds()
    }

    // MARK: - Audio functions
    fileprivate func startRecordingSounds() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    fileprivate func stopRecordingSounds() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording is Not successful")
        }
    }
    
    // MARK: - Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

    // MARK: - UI functions
    fileprivate func updateUIState(recording: Bool) {
        recordButton.isEnabled = !recording
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
        stopRecordingButton.isEnabled = recording
    }
    
}

