//
//  NewCameraViewController.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit
import Eureka

protocol NewCameraViewControllerDelegate: class {
    func didAddCamera(camera: Camera)
}

fileprivate enum RowTags: String {
    case name = "name"
    case ipAddress = "ip"
    case port = "port"
    case username = "username"
    case password = "password"
}

class NewCameraViewController: FormViewController {
    
    weak var delegate: NewCameraViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                        target: self,
                                        action: #selector(SELdidPressBackButton(sender:)))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                           target: self,
                                           action: #selector(SELdidPressSaveButton(sender:)))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func SELdidPressSaveButton(sender: UIBarButtonItem) {
        guard form.validate().isEmpty else { return }
        guard let name = form.rowBy(tag: RowTags.name.rawValue)?.baseValue as? String,
            let ip = form.rowBy(tag: RowTags.ipAddress.rawValue)?.baseValue as? String,
            let username = form.rowBy(tag: RowTags.username.rawValue)?.baseValue as? String,
            let password = form.rowBy(tag: RowTags.password.rawValue)?.baseValue as? String else {
                return
        }
        let camera = Camera(name: name,
                            ip: ip,
                            port: form.rowBy(tag: RowTags.port.rawValue)?.baseValue as? Int,
                            username: username,
                            password: password)
        delegate?.didAddCamera(camera: camera)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func SELdidPressBackButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupForm() {
        form +++
            Section(){ section in
                var header = HeaderFooterView<UILabel>(.class)
                header.height = { 50.0 }
                
                header.onSetupView = { view, _ in
                    view.textColor = .darkGray
                    view.text = "   CAMERA DETAILS"
                    view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                }
                section.header = header
            }
        
            <<< NameRow() {
                $0.tag = "name"
                $0.title =  "Name"
                $0.placeholder = "Enter a name for the camera"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
            
            <<< TextRow() {
                $0.tag = "ip"
                $0.title = "IP Address"
                $0.placeholder = "___.___.___.___"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleValidIP())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
            
            <<< IntRow() {
                $0.tag = "port"
                $0.title = "PORT"
                $0.formatter = nil
            }
        
            <<< AccountRow() {
                $0.tag = "username"
                $0.title = "Username"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                        row.placeholder = "Enter Username"
                    }
                })
        
            <<< PasswordRow() {
                $0.tag = "password"
                $0.title = "Password"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
    }
}
