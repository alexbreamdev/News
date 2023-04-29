//
//  Bundle+Extention.swift
//  MyAppleNews
//
//  Created by Oleksii Leshchenko on 28.03.2023.
//

import Foundation


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        do {
            guard let url = self.url(forResource: file, withExtension: nil) else {
                throw URLError(.badURL)
            }
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
