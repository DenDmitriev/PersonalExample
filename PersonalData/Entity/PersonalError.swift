//
//  PersonalError.swift
//  PersonalData
//
//  Created by Denis Dmitriev on 31.10.2023.
//

import Foundation

enum PersonalError: Error {
    case email, telephone, empty, unknown
}

extension PersonalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .email:
            return "Не верный email"
        case .telephone:
            return "Не верный номер телефона"
        case .empty:
            return "Пустое поле"
        case .unknown:
            return "Ошибка"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .email:
            return "Введите существующий адрес электронной почты"
        case .telephone:
            return "Телефон должен начинаться на +7 или 8 и состоять из цифр"
        case .empty:
            return "Заполните все поля"
        case .unknown:
            return "Попробуйте снова"
        }
    }
}
