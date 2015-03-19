//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ameenah Burhan on 3/15/15.
//  Copyright (c) 2015 Meena LLC. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(_ filePathUrl: NSURL, _ title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}