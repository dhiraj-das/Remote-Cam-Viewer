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
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(SELdidPressSaveButton(sender:)))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func SELdidPressSaveButton(sender: UIBarButtonItem) {
        guard let newCameraController = storyboard?.instantiateViewController(withIdentifier: "NewCameraViewController") as? NewCameraViewController else { return }
        newCameraController.delegate = self
        let navigationController = UINavigationController(rootViewController: newCameraController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension CameraListViewController: CameraListViewDelegate {
    func didSelectItem() {
        
    }
}

extension CameraListViewController: NewCameraViewControllerDelegate {
    func didAddCamera(camera: Camera) {
        ONVIFCameraManager.shared.connect(toCamera: camera) { [weak self] (onvifCamera, error) in
            if let _error = error {
                self?.showErrorAlert(forError: _error)
            }
        }
    }
}
