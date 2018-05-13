//
//  Camera.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation

struct Camera: Codable {
    var name: String
    var ip: String
    var port: Int?
    var username: String
    var password: String
}

