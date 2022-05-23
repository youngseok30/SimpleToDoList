//
//  Enum.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import Foundation

enum HomeUseCaseError: Error {
    case loadCacheError
}

enum UserDefaultSettableError: Error {
    case invalidValue, unableToEncode, unableToDecode
}
