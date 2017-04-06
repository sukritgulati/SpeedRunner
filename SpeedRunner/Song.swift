//
//  Song.swift
//  SpeedRunner
//
//  Created by Sukrit Gulati on 4/6/17.
//  Copyright © 2017 Sukrit Gulati. All rights reserved.
//

import Foundation
import UIKit


class Song {
    
    private var _songTitle: String!
    private var _songArt:UIImage!
    private var _songBPM:String!
    
    var songTitle:String {
        return _songTitle
    }
    var songBPM: String {
        return _songBPM
    }
    
    init(songTitle:String, songArt:UIImage, songBPM:String) {
        _songTitle = songTitle
        _songArt = songArt
        _songBPM = songBPM
        
    }
    
    
    
    
}
