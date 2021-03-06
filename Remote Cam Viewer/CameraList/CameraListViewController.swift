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
    
    private var dataprovider: CameraListDataProvider! {
        didSet {
            cameraListView.dataprovider = dataprovider
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraListView.delegate = self
        fetchCameras()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func fetchCameras() {
        DatabaseManager.shared.fetchCamerasForCurrentUser { [weak self] (camera) in
            self?.dataprovider = CameraListDataProvider(cameras: camera ?? [])
        }
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
    
    private func connectTo(camera: Camera) {
        ONVIFCameraManager.shared.connect(toCamera: camera) { [weak self] (uri, error) in
            if let _error = error {
                self?.showErrorAlert(forError: _error)
                return
            }
            guard let _uri = uri else {
                return
            }
            self?.showCameraStream(withURI: _uri)
        }
    }
    
    private func showCameraStream(withURI uri: String) {
        guard let cameraStreamViewController = storyboard?.instantiateViewController(withIdentifier: "CameraStreamViewController") as? CameraStreamViewController else { return }
        cameraStreamViewController.URI = uri
        navigationController?.pushViewController(cameraStreamViewController, animated: true)
    }
}

extension CameraListViewController: CameraListViewDelegate {
    func didSelectCamera(camera: Camera) {
        connectTo(camera: camera)
    }
}

extension CameraListViewController: NewCameraViewControllerDelegate {
    func didAddCamera(camera: Camera) {
        DatabaseManager.shared.addCamera(camera: camera)
        fetchCameras()
    }
}
