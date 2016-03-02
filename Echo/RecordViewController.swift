//
//  RecordViewController.swift
//  Echo
//
//  Created by Ying Qi on 3/2/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    //TODO: Generate file name for each recording
    let fileName = "demo.caf"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* Set the settings for recorder */
    func setupRecorderAndRecord() {
        let recordSettings: [String: AnyObject] =
        [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue as NSNumber,
            AVEncoderBitRateKey : 320000 as NSNumber,
            AVNumberOfChannelsKey: 2 as NSNumber,
            AVSampleRateKey : 44100.0 as NSNumber
        ]
        
        do {
            
            audioRecorder = try AVAudioRecorder(URL: getFileURL(), settings: recordSettings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            //TODO: Change button state
        } catch {
            finishRecording(false)
            
        }
    }
    
    func finishRecording(success: Bool) {
        
    }
    
    func recordEcho() {
        
    }
    
    /* Helper Methods */
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [String]
         return paths[0]
    }
    
    func getFileURL() -> NSURL {
        let path = getCacheDirectory().stringByAppendingPathComponent(fileName)
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
