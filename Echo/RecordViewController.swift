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
    @IBOutlet weak var recordAgainBtn: UIButton!
    
    var audioRecorder: AVAudioRecorder!

    var recordingSession: AVAudioSession!
    
    
    //TODO: Generate file name for each recording
    var audioFilename: NSURL!
    
    var recordSuccess: Bool!
    
    var dataToUpload: NSData!
    
    var player: AVAudioPlayer!
    
    var uid: String!
    
    var recordBtnView: RecordBtnView?
    
    let ref = Firebase(url:"https://burning-fire-8901.firebaseio.com")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveBtnState", name: "com.yingqi.Echo.RecordButtonState", object: nil)
        
        /* Request user permission to access microphone */
        recordBtnView = RecordBtnView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleBtnTap:"))
        self.recordBtnView!.addGestureRecognizer(gestureRecognizer)
        //self.view.addGestureRecognizer(gestureRecognizer)
        self.view.addSubview(recordBtnView!)
        
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission(){
                [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                       // self.loadRecordingUI()
                        
                    } else {
                       // self.loadFailUI()
                    }
                }
                
            }
            
        } catch {
            
           // self.loadFailUI()
            
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
    
    func receiveBtnState(){
            self.recordBtnView!.currentState = .Done
            self.recordBtnView?.stopPlaying()
           // self.stopListening()
        
        
    }
    
    func handleBtnTap(sender: RecordBtnView){
        print("called...")
        switch self.recordBtnView!.currentState {
        case .Ready:
            self.recordBtnView?.beginRecording()
            print("ready- > recording ...")
            self.startRecording()
            break
            
        case .Recording:
            self.finishRecording(true)
            self.recordBtnView?.stopRecording()
            print("recording - > done ... ")

            break
        case .Playing:
            print("playing - > done...")
            self.recordBtnView?.stopPlaying()
            self.stopListening()

            break
            
        case.Done:
            print("done - > playing...")
            self.listenToRecording()
            self.recordBtnView?.play()
         
            break
        default:
            break
        }
    }
    
    func startRecording(){
        
        // Create unique name for each voice

        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingTime = formatter.stringFromDate(currentDateTime)
        uid =  ref.authData.uid + recordingTime

        audioFilename = NSURL(fileURLWithPath: getCacheDirectory()).URLByAppendingPathComponent(uid)
        // http://stackoverflow.com/questions/29739930/how-to-upload-recorded-audio-file-to-parse
        
        
        
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
    
    
    
    
    func finishRecording(success: Bool) {
        
        
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {

            
            dataToUpload = NSData(contentsOfURL: self.audioFilename)!

            self.recordSuccess = true
  
            
        } else {
            // restore to pre-recording state
           
            self.recordSuccess = false

        }
        

    }
    
    @IBAction func test(sender: UIButton) {
        print("testing")
    }
    @IBAction func recordAgain(sender: UIButton) {
        
        //self.recordBtnView?.beginRecording()
        print("ready- > recording ...")
        self.recordBtnView?.recordAgain()
       // self.startRecording()

        
    }
    
    /*

    @IBAction func listen(sender: AnyObject) {
        self.listenToRecording()

    }
*/
    
    
    func listenToRecording(){
        if (self.recordSuccess!){
            
            do {
                // var player = AVAudioPlayer()
                player = try AVAudioPlayer(data: self.dataToUpload)
                player.prepareToPlay()
                self.recordBtnView?.setRecordedVoiceDuration(player.duration)
                player.volume = 1.0
                player.delegate = self
                player.play()
                
                
            } catch {
                print ("Error getting the audio file")
            }
            
        } else {
            
        }
        
    }
    
    func stopListening(){
        player.stop()
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
            uploadVC.voiceUID = self.uid
        }
    }
    

}
