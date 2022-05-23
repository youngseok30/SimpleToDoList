//
//  DefaultCacheRepository.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import Foundation
import RxSwift


final class DefaultCacheRepository: CacheRepository {
    
    func save<T: Encodable>(_ key: Key, value: T) {
        do {
            try UserDefaults.TodoList.setObject(object: value, forKey: key)
        } catch (let error) {
            print(error)
        }
    }
    
    func load<T: Decodable>(_ key: Key) -> T? {
        do {
            return try UserDefaults.TodoList.getObject(forKey: key, castTo: T.self)
        } catch {
            return nil
        }
    }    
    
}
