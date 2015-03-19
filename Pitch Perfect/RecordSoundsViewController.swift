//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ameenah Burhan on 3/15/15.
//  Copyright (c) 2015 Meena LLC. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            
            let data =  sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    @IBAction func stopAudio(sender: UIButton) {
        stopRecording.hidden = true
        recordAudio.enabled = true
        recordLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    @IBAction func recordAudio(sender: UIButton) {
        stopRecording.hidden = false
        recordAudio.enabled = false
        recordLabel.text = "Recording in Progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        //Setup  audio  session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        //Initializee and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
      
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){
        if(flag){
            recordedAudio = RecordedAudio(recorder.url,recorder.url.lastPathComponent!)
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("Recording was not successful")
            recordAudio.enabled = true
            stopRecording.hidden = true
        }
        
    }
}

