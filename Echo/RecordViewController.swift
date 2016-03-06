//
//  RecordViewController.swift
//  Echo
//
//  Created by Ying Qi on 3/2/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    var recordingSession: AVAudioSession!
    
    //TODO: Generate file name for each recording
    let fileName = "demo.caf"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Request user permission to access microphone */
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission(){
                [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.loadRecordingUI()
                        
                    } else {
                        self.loadFailUI()
                    }
                }
                
            }
            
        } catch {
            
            self.loadFailUI()
            
        }

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* UI loader */
    
    func loadRecordingUI(){
        
    }
    
    func loadFailUI(){
        
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
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            var myRootRef = Firebase(url: "https://burning-fire-8901.firebaseio.com")
            myRootRef.setValue("Hi");
            
        } else {
            // restore to pre-recording state
        }

    }
    


    func encodeRecording(){
        encodeFileName = "temp";
        var error: NSError?

        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(encodeFileName, ofType: "mp3")!)

        let fileData = NSData(contentsOfFile: fileLocation, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)

        let base64String = fileData?.base64EncodedStringWithOptions(.allZeros)
        println(base64String!)
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if (!flag) {
            finishRecording(success: false)
        }
    }

        
    
    /* Helper Methods */
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [String]
         return paths[0]
    }
    
    func getFileURL() -> NSURL {
        let path = getCacheDirectory().stringByAppendingString(fileName)
        let filePath = NSURL(fileURLWithPath: path)
        return filePath
       
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
