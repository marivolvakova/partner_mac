//
//  Refresh.swift
//  ifaceDevelopment
//
//  Created by Alexander Kuznetsov on 15.04.2022.
//

import Foundation

struct RefreshReq: Codable {
    let token: String
}

struct RefreshResp: Codable {
    struct Auth: Codable {
        let user_id: Int
        let token: String
        let refresh_token: String
        let refresh_token_expired: Int
        let must_reset_password : Bool
    }
    let auth: Auth
}
