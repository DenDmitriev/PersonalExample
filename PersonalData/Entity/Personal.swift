//
//  Entity.swift
//  Example
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import Foundation

struct Personal {
    let fullName: String
    let email: String
    let telephone: String
}

extension Personal: CustomStringConvertible {
    var description: String {
        return fullName + "\n" + email + "\n" + telephone
    }
}
