import Foundation

enum ServerUserStatus: Int, Codable {
    case offline = 0
    case online = 1
    case busy = 2
}

protocol FlatServerProtocol {
    init(server: String)
    func login(user: String, password: String, completionHandler: @escaping (LoginResponse?, Error?) -> Void)
    func setStatus(status: ServerUserStatus, completionHandler: @escaping (StatusResp?, Error?) -> Void)
    func logout(completionHandler: @escaping (LogoutResp?, Error?) -> Void)
}

protocol FlatServerContactsProtocol {
    func getContactsAmount(filter: String?, completionHandler: @escaping (ContactsAmountResp?, Error?) -> Void)
    func getContacts(filter: String?, offset: Int, limit: Int, completionHandler: @escaping (ContactsResp?, Error?) -> Void)
    func getContact(id: Int, offset: Int?, size: Int?, completionHandler: @escaping (ContactResponse?, Error?) -> Void)
}

protocol FlatServerFavProtocol {
    func getFavContactsAmount(filter: String?, completionHandler: @escaping (ContactsAmountResp?, Error?) -> Void)
    func getFavContacts(filter: String?, offset: Int, size: Int, completionHandler: @escaping (ContactsResp?, Error?) -> Void)
    func addFavContacts(user_id: Int, completionHandler: @escaping (FavContactAddResponse?, Error?) -> Void)
    func removeFavContacts(user_id: Int, completionHandler: @escaping (FavoriteContactRemoveResponse?, Error?) -> Void)
}

protocol FlatServerHistoryProtocol {
    func getHistoryAmount(direction: Int?, period: Int?, filter: String?, completionHandler: @escaping (HistoryAmountResp?, Error?) -> Void)
    func getHistoryList(direction: Int?, offset: Int, limit: Int, period: Int?, filter: String?, completionHandler: @escaping (HistoryListResp?, Error?) -> Void)
    func removeHistoryItem(id: Int, completionHandler: @escaping (HistoryListResp?, Error?) -> Void)
    func addHistoryItem(name: String, phone: String, user_id: Int?, time: String, duration: Int?, direction: Int, type: Int, completionHandler: @escaping (HistoryAddResp?, Error?) -> Void)
}

protocol FlatServerPhonesProtocol {
    func getPhonesAmount(request: String?, completionHandler: @escaping (PhonesAmountResp?, Error?) -> Void)
    func getPhonesList(request: String?, offset: Int, size: Int, completionHandler: @escaping (PhonesListResp?, Error?) -> Void)
}
