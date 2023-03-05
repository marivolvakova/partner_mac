import Foundation

struct PhonesAmountReq: Codable {
    let token: String
    let phone_num: String
}

struct PhonesAmountResp: Codable {
    let amount: Int
}

struct PhonesListReq: Codable {
    let token: String
    let phone_num: String
    let offset: Int
    let limit: Int
}

struct Phone: Codable {
    let user_id: Int?
    let name: String?
    let phone: String
}

struct PhonesListResp: Codable {
    let phones: [Phone]?
}
