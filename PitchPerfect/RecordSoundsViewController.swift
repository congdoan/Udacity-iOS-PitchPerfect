//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Cong Doan on 10/6/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordButton.isEnabled = false
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
    }

    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        recordingLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
    }

}

