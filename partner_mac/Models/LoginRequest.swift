import Foundation

struct LoginRequest: Codable {
    let login: String
    let pwd: String
}

struct LoginResponse: Codable {
    let auth: Authorization
    let user: User
    let settings: Settings
}

struct Authorization: Codable {
    let user_id: Int
    let token: String
    let refresh_token: String
    let refresh_token_expired: Int
    let must_reset_password: Bool
}

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let status: Int
    let image: String
    let position: UserPosition
    let department: UserDepartment
    let numbers: [UserNumbers]
    let emails: [UserEmails]
}

struct UserNumbers: Codable {
    let number: String
    let is_main: Bool
    let name: String
}

struct UserPosition: Codable {
    let id: Int
    let name: String
}

struct UserDepartment: Codable {
    let id: Int
    let name: String
}

struct UserEmails: Codable {
    let email: String
    let name: String
}

struct Settings: Codable {
    let is_call: Bool?
    let is_vcall: Bool?
    let is_chat: Bool?
    let chat_ip: String?
    let sip_uri: String?
    let sip_pwd: String?
    let sip_ip: String?
    let sip_port: Int?
    let sip_proxy: String?
    let sip_num: String?
    let is_stun: Bool?
    let stun_srv: String?
    let transport: String?
    let sip_expires: Int
    let logger_ip: String?
    let logger_level: Int?
}




