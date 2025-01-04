//
//  KeychainStorage.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import Security
import Foundation
/**
 A utility class for securely storing, retrieving, and deleting data in the iOS Keychain.
 */

class KeychainStorage{
    /**
     Saves a string value for a given key in the Keychain.
     - Parameters:
        - key: String to use as key in the Keychain
        - value: String to be saved
     - Returns: Returns true if the save operation is successful
     */
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
    
    /**
     Retrieves the string value for the provided key from the Keychain.
     - Parameters:
        - key: String to use as key in the Keychain
     - Returns: value from the keychain if exists else nil
     */
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
    
    /**
     Deletes the string value for the provided key in the Keychain.
     - Parameters:
        - key: the key for the value to be deleted.
        - Returns: true if the delete operation is successful
     */
    static func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }


}
