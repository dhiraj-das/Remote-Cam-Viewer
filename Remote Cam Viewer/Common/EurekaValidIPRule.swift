//
//  EurekaValidIPRule.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import Eureka

public struct RuleValidIP<T: Equatable>: RuleType {
    public var id: String?
    public var validationError: ValidationError = ValidationError(msg: "Invalid IP Address.")
    
    public init() {}
    
    public func isValid(value: T?) -> ValidationError? {
        if let str = value as? String {
            return str.isvalidIpAddress() ? nil : validationError
        }
        return validationError
    }
}
