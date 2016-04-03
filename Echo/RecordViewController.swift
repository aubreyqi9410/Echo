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

class RecordViewController: UIViewController,  AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!

    var recordingSession: AVAudioSession!
    
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var listenBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    //TODO: Generate file name for each recording
    var audioFilename: NSURL!
    
    var recordSuccess: Bool!
    
    var dataToUpload: NSData!
    
    var player: AVAudioPlayer!
    
    
    
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRecording(){
        
        

        
        audioFilename = NSURL(fileURLWithPath: getCacheDirectory()).URLByAppendingPathComponent("recording.m4a")
        // http://stackoverflow.com/questions/29739930/how-to-upload-recorded-audio-file-to-parse
        
        
        print(audioFilename)
        
        let audioURL = audioFilename
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordBtn.setTitle("Tap to Stop", forState: .Normal)
        } catch {
            finishRecording(false)
        }
        
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    @IBAction func record(sender: AnyObject) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(true)
        }
    }
    
    func loadRecordingUI(){
        self.listenBtn.enabled = false
        self.nextBtn.enabled = false
        
        
    }
    
    func loadFailUI(){
        
    }
    
    
    
    func finishRecording(success: Bool) {
        
        
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            //var myRootRef = Firebase(url: "https://burning-fire-8901.firebaseio.com")
            //myRootRef.setValue("Hi");
            
            //let name = "test"
            
            dataToUpload = NSData(contentsOfURL: self.audioFilename)!
            
            /*
            let base64String = dataToUpload.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            
            let recording: NSDictionary = ["name": name, "photoBase64":base64String]
            
            let voice = myRootRef.ref.childByAppendingPath(name)
            
            voice.setValue(recording)
            */

            recordBtn.setTitle("Tap to Re-record", forState: .Normal)
            self.recordSuccess = true
            self.listenBtn.enabled = true
            self.nextBtn.enabled = true
            
        } else {
            // restore to pre-recording state
            recordBtn.setTitle("Tap to Record", forState: .Normal)
            self.recordSuccess = false

        }
        

    }
    

    @IBAction func listen(sender: AnyObject) {
        
        if (self.recordSuccess!){
            self.listenBtn.enabled = true
            do {
               // var player = AVAudioPlayer()
                player = try AVAudioPlayer(data: self.dataToUpload)
                player.prepareToPlay()
                player.volume = 1.0
                player.delegate = self
                player.play()
                
                
            } catch {
                print ("Error getting the audio file")
            }
            
        } else {
            
        }
        
    }
    
    
    @IBAction func goToUpload(sender: UIButton) {
        self.performSegueWithIdentifier("showUploadVC", sender: self)
        
    }

    func encodeRecording(){
        /*
        encodeFileName = "temp";
        var error: NSError?

        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(encodeFileName, ofType: "mp3")!)

        let fileData = NSData(contentsOfFile: fileLocation, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)

        let base64String = fileData?.base64EncodedStringWithOptions(.allZeros)
        println(base64String!)
        */
    }

    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(false)
        }
    }

        
    
    /* Helper Methods */
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [String]
         return paths[0]
    }
    
    /*
    
    func getFileURL() -> NSURL {
        let path = getCacheDirectory().stringByAppendingString(fileName)
        let filePath = NSURL(fileURLWithPath: path)
        return filePath
       
    }
*/
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "showUploadVC"){
            let uploadVC = segue.destinationViewController as!UploadViewController
            uploadVC.voiceData = self.dataToUpload
        }
    }
    

}
