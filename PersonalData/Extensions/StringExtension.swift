//
//  StringExtension.swift
//  PersonalData
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import Foundation

extension String {
    var isTelephoneNumber: Bool {
        var telephone = self
        telephone.removeAll(where: { $0 == " " })
        telephone.removeAll(where: { $0 == "(" })
        telephone.removeAll(where: { $0 == ")" })
        telephone.removeAll(where: { $0 == "-" })
        guard 11...12 ~= telephone.count else { return false }
        guard telephone.prefix(3) == "+79" || telephone.prefix(2) == "89" else { return false }
        
        let okayChars = Set("+0123456789")
        if !telephone.filter({ value in
            !okayChars.contains(value)
        }).isEmpty {
            return false
        }
        
        return true
    }
    
    var isEmail: Bool {
        let emailPredicateFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPredicateFormat)
        return emailPredicate.evaluate(with: self)
    }
}
