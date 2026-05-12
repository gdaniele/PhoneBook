//
//  APIClient.swift
//  PhoneBook
//
//  Created by Giancarlo Daniele on 5/12/26.
//

import Foundation

protocol APIClient {
    func fetchUsers() async throws -> [APIUser]
}

protocol APIError {
    
}
