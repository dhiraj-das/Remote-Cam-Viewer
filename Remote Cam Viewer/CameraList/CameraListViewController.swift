//
//  CameraListViewController.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

class CameraListViewController: UIViewController {

    @IBOutlet var cameraListView: CameraListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraListView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

extension CameraListViewController: CameraListViewDelegate {
    func didSelectItem() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewCameraViewController") as? NewCameraViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
