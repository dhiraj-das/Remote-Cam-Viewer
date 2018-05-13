//
//  CameraListDataProvider.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

class CameraListDataProvider {
    
    var cameras: [Camera] = []
    
    init(cameras: [Camera]) {
        self.cameras = cameras
    }
}
