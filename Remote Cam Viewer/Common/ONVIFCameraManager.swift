//
//  ONVIFCameraManager.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import ONVIFCamera

enum CameraError: Error {
    case defaultError(error: String)
    
    var localizedDescription: String {
        switch self {
        case .defaultError(let error):
            return error
        }
    }
}

class ONVIFCameraManager {
    
    static let shared = ONVIFCameraManager()
    var camera: ONVIFCamera?
    
    private init() {
        
    }
    
    func connect(toCamera camera: Camera, completion: @escaping (_ camera: ONVIFCamera?, _ error: Error?) -> Void) {
        self.camera = ONVIFCamera(with: camera.ip,
                                      credential: (login: camera.username, password: camera.password))
        self.camera?.getServices {
            self.camera?.getCameraInformation(callback: { (camera) in
                completion(camera, nil)
            }) { (error) in
                completion(nil, CameraError.defaultError(error: error))
            }
        }
    }
}
