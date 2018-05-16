//
//  CameraStreamViewController.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/15/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

class CameraStreamViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    var URI: String?
    let mediaPlayer = VLCMediaPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaPlayer.drawable = self.cameraView
        mediaPlayer.libraryInstance.debugLogging = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            // Create `VLCMedia` with the URI retrieved from the camera
            if let _URI = self.URI, let url = URL(string: _URI) {
                let media = VLCMedia(url: url)
                self.mediaPlayer.media = media
                self.mediaPlayer.play()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaPlayer.stop()
    }
    
}
