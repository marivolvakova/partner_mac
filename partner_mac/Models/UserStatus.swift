//
//  UserStatus.swift
//  flat-ios
//
//  Created by Кирилл on 26.11.2020.
//

import Foundation

enum UserStatus: String, CaseIterable {
	case active = "Активен"
	case notActive = "Не активен"
	case busy =  "Занят"
}


struct StatusRequest: Codable {
    let token: String
    let status: String
}

struct StatusResponse: Codable {

}
