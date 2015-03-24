//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ameenah Burhan on 3/15/15.
//  Copyright (c) 2015 Meena LLC. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
//Stop the playback of audio
    @IBAction func stopAudio(sender: UIButton) {
        audioEngine.stop()
        audioPlayer.stop()
    }
//Increase the speed of the audio playback
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(2.0)
    }
//Decrease the speed of the audio playback
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
//Increase the pitch of the audio playback
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
//Decrease the pitch of the audio playback
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
//Play audio
    func playAudio(speed: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    func playAudioWithVariablePitch(pitch: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
//assign and attach nodes to audio engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
//make connections with audio nodes effects and the audio engine
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

   
}
