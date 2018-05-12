//
//  UserSetupView.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

protocol UserSetupViewDelegate: class {
    func didTapProceedButton(sender: UIButton)
}

class UserSetupView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet var proceedButtonBottomConstraint: NSLayoutConstraint!
    
    weak var delegate: UserSetupViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        proceedButton.alpha = 0
        proceedButton.addTarget(self,
                                action: #selector(didTapProceedButton(sender:)),
                                for: .touchUpInside)
        startOpacityAnimation()
    }
    
    @objc private func didTapProceedButton(sender: UIButton) {
        delegate?.didTapProceedButton(sender: sender)
    }

    private func startOpacityAnimation() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       options: .curveLinear,
                       animations: {
                        self.proceedButton.alpha = 1
        }) { _ in
            self.startProceedButtonAnimation()
        }
    }
    
    private func startProceedButtonAnimation() {
        proceedButtonBottomConstraint.constant = 150
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.layoutIfNeeded()
        }, completion: nil)
    }
}
