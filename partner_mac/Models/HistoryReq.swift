import Foundation

struct HistoryAmountReq: Codable {
    let token: String
    let direction: Int?
    let period: Int?
    let filter: String?
}

struct HistoryAmountResp: Codable {
    let amount: Int
}

struct HistoryListReq: Codable {
    let token: String
    let offset: Int
    let direction: Int?
    let limit: Int
    let period: Int?
    let filter: String?
}

struct HistoryCall: Codable {
    let id: Int
    let name: String?
    let phone: String
    let time: String
    let duration: Int?
    let direction: Int
    let type: Int?
    let user_id: Int?
    let image: String?
}

struct HistoryListResp: Codable {
    let calls: [HistoryCall]?
}

struct HistoryAddReq: Codable {
    let token: String
    let name: String
    let phone: String
    let time: String
    let duration: Int?
    let direction: Int
    let type: Int?
    let user_id: Int?
}

struct HistoryAddRespItem: Codable {
    let id: Int
    let name: String?
    let phone: String
    let time: String
    let duration: Int?
    let direction: Int
    let type: Int?
    let user_id: Int?
}

struct HistoryAddResp: Codable {
    let call: HistoryAddRespItem
}

struct HistoryRemoveReq: Codable {
    let token: String
    let id: Int
}

struct HistoryRemoveResp: Codable {
}
