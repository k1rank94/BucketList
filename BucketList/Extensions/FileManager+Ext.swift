//
//  FileManager+Ext.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//

import Foundation

extension FileManager {
    
    // MARK: - File Helper
    
    private static func getDocumentsDirectory() -> URL {
        return self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // MARK: - Static Save
    
    /// Saves a Codable object to the Documents directory as a .txt file.
    /// Usage: try FileManager.save(user, withName: "userProfile")
    static func save<T: Encodable>(_ object: T, withName fileName: String) throws {
        let url = getDocumentsDirectory()
            .appendingPathComponent(fileName)
            .appendingPathExtension("txt")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode(object)
        try data.write(to: url, options: .atomic)
    }
    
    // MARK: - Static Get
    
    /// Retrieves a Codable object from a .txt file in the Documents directory.
    /// Usage: let user = try FileManager.get("userProfile", as: User.self)
    static func get<T: Decodable>(_ fileName: String, as type: T.Type) throws -> T {
        let url = getDocumentsDirectory()
            .appendingPathComponent(fileName)
            .appendingPathExtension("txt")
        
        guard self.default.fileExists(atPath: url.path) else {
            throw CocoaError(.fileReadNoSuchFile)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
    
    // MARK: - Static Remove
    
    /// Removes the .txt file from the Documents directory.
    static func remove(_ fileName: String) {
        let url = getDocumentsDirectory()
            .appendingPathComponent(fileName)
            .appendingPathExtension("txt")
        
        if self.default.fileExists(atPath: url.path) {
            try? self.default.removeItem(at: url)
        }
    }
}
