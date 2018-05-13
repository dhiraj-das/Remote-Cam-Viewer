//
//  NewCameraViewController.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit
import Eureka

class NewCameraViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: self,
                                         action: #selector(SELdidPressBackButton(sender:)))
        let saveButton = UIBarButtonItem(title: "Save",
                                         style: .done,
                                         target: self,
                                         action: #selector(SELdidPressSaveButton(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func SELdidPressSaveButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func SELdidPressBackButton(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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
                $0.title = "IP Address"
                $0.placeholder = "___.___.___.___"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }.cellUpdate({ (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                })
        
            <<< AccountRow() {
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
