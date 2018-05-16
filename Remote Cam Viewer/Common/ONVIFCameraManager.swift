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
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .defaultError(let error):
            return error
        case .unknownError:
            return "Something went wrong"
        }
    }
}

class ONVIFCameraManager {
    
    static let shared = ONVIFCameraManager()
    private var camera: ONVIFCamera?
    private let license = "nU8Yi3Turrn42DmbDIelGDPvYzatf4ZJTE6SF2GwHtZFcaGzSM+JxCE+YyK7M69KOo58YsA4scb/WqeaKklRgA=="
    
    private init() {
        
    }
    
    func connect(toCamera camera: Camera, completion: @escaping (_ uri: String?, _ error: Error?) -> Void) {
        self.camera = ONVIFCamera(with: camera.ip,
                                  credential: (login: camera.username, password: camera.password),
                                  soapLicenseKey: license)
        self.camera?.getServices {
            self.camera?.getCameraInformation(callback: { camera in
                camera.getProfiles(profiles: { profiles in
                    if profiles.count > 0 {
                        camera.getStreamURI(with: profiles.first!.token, uri: { uri in
                            completion(uri, nil)
                            return
                        })
                    } else {
                        completion(nil, CameraError.unknownError)
                        return
                    }
                })
            }) { (error) in
                completion(nil, CameraError.defaultError(error: error))
            }
        }
    }
}
