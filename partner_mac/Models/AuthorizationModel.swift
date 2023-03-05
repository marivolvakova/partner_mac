//
//  AuthorizationModel.swift
//  flat-ios
//
//  Created by Alexander Kuznetsov on 13.04.2022.
//

import Foundation

struct AuthorizationModel: Encodable, Decodable {
    let user: String?
    let password: String?
    let url: String?
}
