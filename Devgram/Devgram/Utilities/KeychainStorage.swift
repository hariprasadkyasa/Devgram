//
//  KeychainStorage.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Security
import Foundation
class KeychainStorage{
    
    static func save(key: String, value: String) -> Bool {
        // Convert the value to Data
        let valueData = value.data(using: .utf8)
        
        // Define a query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: valueData!
        ]
        
        // Delete any existing item with the same key
        SecItemDelete(query as CFDictionary)
        
        // Add the new item to the Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func retrieve(key: String) -> String? {
        // Define a query to search for the item
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    static func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }


}
