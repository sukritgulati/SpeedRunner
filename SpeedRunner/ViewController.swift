//
//  ViewController.swift
//  SpeedRunner
//
//  Created by Sukrit Gulati on 4/6/17.
//  Copyright © 2017 Sukrit Gulati. All rights reserved.
//

import UIKit
import MediaPlayer


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, MPMediaPickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var tableView:UITableView!
    
    var songsArray = [Song]()
    var bmpDetector = BPMDetector()
    
    let mediaPickerController = MPMediaPickerController(mediaTypes: .music)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mediaPickerController.delegate = self
        mediaPickerController.allowsPickingMultipleItems = true
        self.present(mediaPickerController, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        //procees in background thread
        for mediaItem in mediaItemCollection.items {
           print(mediaItem.assetURL?.absoluteURL)
            if let url = mediaItem.assetURL! as? URL{
                let fUrl = getUrl(assetUrl: url)
                print(bmpDetector.getBPM(fUrl))
               // deleteFile(path: )
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
    //http://stackoverflow.com/questions/11364997/pick-music-from-ios-library-and-send-save?rq=1
    //above is the reference code
    func getUrl(assetUrl: URL) -> URL {
        let songAsset = AVAsset.init(url: assetUrl)
        let exporter = AVAssetExportSession(asset: songAsset, presetName: AVAssetExportPresetPassthrough)
        exporter!.outputFileType = "com.apple.quicktime-movie";
     
        let exportFile = "\(NSHomeDirectory())/exported.mov"
        //deleteFile(path: exportFile)
        
        let exportUrl = URL(fileURLWithPath: exportFile)

        exporter?.outputURL = exportUrl
        exporter?.exportAsynchronously(completionHandler: {
            if let exportStatus = exporter?.status {
                switch exportStatus {
                case AVAssetExportSessionStatus.completed:
                    break
                default:
                    break
                    
                }
            }
            
        })
        return exportUrl
    }
    
    //where to save
    func documentDirectory() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return path[0]
    }
    
    func deleteFile(path:String){
        if FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.removeItem(atPath: path)
        }
    }

}

