//
//  UsersID.swift
//  flat-ios
//
//  Created by mobile on 14.12.2022.
//

import Foundation

struct UsersIdRequest: Codable {
    let token: String
}
 
struct UsersIdResponse: Codable {
    let id: Int
    let login: String
    let name: String
    let group: UsersIdGroup
    let numbers: [Numbers]
    let emails: Emails
    let is_fav: Bool
    let image: String
}


struct UsersIdGroup: Codable {
    let id: Int
    let name: String
}

struct Numbers: Codable {
    let number: String
    let name: String
    let is_main: Bool
}

struct Emails: Codable {
    let email: String
    let name: String
}
