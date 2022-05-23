//
//  CacheRepository.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import RxSwift

typealias Key = UserDefaults.TodoList.UserDefaultKey

protocol CacheRepository {
    
    func save<T: Encodable>(_ key: Key, value: T)
    func load<T: Decodable>(_ key: Key) -> T?
    
}
