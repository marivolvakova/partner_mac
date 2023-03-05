import Foundation

struct ContactsAmountReq: Codable {
    let token: String
    let filter: String?
}

struct ContactsAmountResp: Codable {
    let amount: Int
}

struct ContactsReq: Codable {
    let token: String
    let filter: String?
    let offset: Int
    let limit: Int
}

struct Contact: Codable {
    let id: Int
    let login: String?
    let name: String
    let status: Int
    let is_fav: Bool?
    let image: String
}

struct ContactsResp: Codable {
    let users: [Contact]?
}

struct ContactReq: Codable {
    let token: String
    let user_id: Int
    let offset: Int?
    let limit: Int?
}

struct ContactPhone: Codable {
    let name: String
    let number: String
    let is_main: Bool
}

struct ContactMail: Codable {
    let name: String
    let email: String
}

struct ContactGroup: Codable {
    let id: Int
    let name: String
}

struct ContsctDepartment: Codable {
    let id: Int
    let name: String
}

struct ContactPosition: Codable {
    let id: Int
    let name: String
}

struct ContactResponse: Codable {
    let id: Int
    let login: String?
    let name: String
    let status: Int
    let position: ContactPosition?
    let department: ContsctDepartment?
    let group: ContactGroup?
    let numbers: [ContactPhone]?
    let emails: [ContactMail]?
    let is_fav: Bool
    let image: String
}

struct FavContactAddReq: Codable {
    let token: String
    let user_id: Int
}

struct FavContactAddResponse: Codable {
}

struct FavoriteContactsRemoveReqest: Codable {
    let token: String
    let user_id: Int
}

struct FavoriteContactRemoveResponse: Codable {
}
