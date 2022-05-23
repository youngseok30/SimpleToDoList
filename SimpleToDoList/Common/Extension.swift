//
//  Extension.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import Foundation

protocol UserDefaultNameSpace {}

extension UserDefaultNameSpace {
    
    static func namespace<T>(_ key: T) -> String where T :RawRepresentable {
        return "\(Self.self).\(key.rawValue)"
    }
    
}

protocol UserDefaultSettable: UserDefaultNameSpace {
    
    associatedtype UserDefaultKey: RawRepresentable
    
}

extension UserDefaultSettable where UserDefaultKey.RawValue == String {
    
    static func setObject<Object>(object: Object, forKey key: UserDefaultKey) throws where Object: Encodable {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: namespace(key))
        } catch {
            throw UserDefaultSettableError.unableToEncode
        }
    }
    
    static func getObject<Object>(forKey key: UserDefaultKey, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = UserDefaults.standard.data(forKey: namespace(key)) else {
            throw UserDefaultSettableError.invalidValue
        }
        
        do {
            let object = try JSONDecoder().decode(type, from: data)
            return object
        } catch {
            throw UserDefaultSettableError.unableToDecode
        }
    }
    
    static func set(value: Any?, forKey key: UserDefaultKey){
        UserDefaults.standard.set(value, forKey: namespace(key))
    }
    
    static func get(forKey key: UserDefaultKey) -> Any? {
        return UserDefaults.standard.object(forKey: namespace(key))
    }
    
}

extension UserDefaults {
    
    struct TodoList: UserDefaultSettable {
        enum UserDefaultKey: String {
            case list
        }
    }
    
}
