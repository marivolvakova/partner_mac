//
//  FPService.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 05.03.2023.
//

import Foundation

class FPService {
    let server: String
    private var token: String {
        get {
            return LocalSettings.shared.fpsToken ?? ""
        }
        set {
            if !newValue.isEmpty {
                LocalSettings.shared.fpsToken = newValue
            }
        }
    }
    private var refreshToken: String {
        get {
            return LocalSettings.shared.fpsRefreshToken ?? ""
        }
        set {
            if !newValue.isEmpty {
                LocalSettings.shared.fpsRefreshToken = newValue
            }
        }
    }
    private var lastUpdateDate: TimeInterval {
        get {
            return LocalSettings.shared.fpsTokenDate ?? 0
        }
        set {
            LocalSettings.shared.fpsTokenDate = newValue
        }
    }
    private let timeOut: TimeInterval = 800.0

    struct Path {
        let name: String
        let method: String
    }
    
    required init(server: String) {
        self.server = server
    }
    
    func login(user: String, password: String, completionHandler: @escaping (LoginResponse?, Error?) -> Void) {
        let fxn = Path(name: "/auth/signin", method: "POST")
        let obj = LoginRequest(login: user, pwd: password)
        send(fxn, request: obj) { (response: LoginResponse?, err: Error?) in
            if let response = response {
                self.token = response.auth.token
                self.refreshToken = response.auth.refresh_token
                self.lastUpdateDate = Date().timeIntervalSince1970
            }
            completionHandler(response, err)
        }
    }
    
    func refresh(completionHandler: @escaping (RefreshResp?, Error?) -> Void) {
        let fxn = Path(name: "/auth/refresh_token", method: "PUT")
        let obj = RefreshReq(token: refreshToken)
        send(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func logout(completionHandler: @escaping (LogoutResp?, Error?) -> Void) {
        let fxn = Path(name: "/auth/signout", method: "PUT")
        let obj = LogoutReq(token: token)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func setStatus(status: ServerUserStatus, completionHandler: @escaping (StatusResp?, Error?) -> Void) {
        let fxn = Path(name: "/auth/set_status", method: "PUT")
        let obj = StatusReq(token: token, status: status.rawValue)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    private func sendRequest<Request: Codable, Response: Codable>(_ path: Path, request: Request, completionHandler: @escaping (Response?, Error?) -> Void) {
        let currentDateTime = Date().timeIntervalSince1970
        if (currentDateTime - lastUpdateDate) >= timeOut {
            print("Get token ")
            refresh() { (resp: RefreshResp?, err: Error?) in
                guard err == nil else {
                    completionHandler(nil, err)
                    return
                }
                
                if let resp = resp {
                    self.token = resp.auth.token
                    print("New token \(resp.auth.token)")
                    self.refreshToken = resp.auth.refresh_token
                    self.lastUpdateDate = currentDateTime
                    self.send(path, request: request, completionHandler: completionHandler)
                } else {
                    completionHandler(nil, nil)
                }
            }
        } else {
            send(path, request: request, completionHandler: completionHandler)
        }
    }
    
    private func send<Request: Codable, Response: Codable>(_ path: Path, request: Request, completionHandler: @escaping (Response?, Error?) -> Void) {
        if let jsonData = try? JSONEncoder().encode(request) {
            _ = RestRequest(server + path.name, method: path.method, jsonBodyData: jsonData) { data, error in
                var decodedData: Response?
                if let data = data {
                    //let str = String(decoding: data, as: UTF8.self)
                    //print("JSON \(str)")
                    do {
                        let decoder = JSONDecoder()
                        decodedData = try decoder.decode(Response.self, from: data)
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key,context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type,context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value,context))
                    } catch let error{
                        print(error)
                    }
                }
                completionHandler(decodedData, error)
            }
        } else {
            completionHandler(nil, nil)
        }
    }
}
    
extension FPService: FlatServerContactsProtocol {
    func getContactsAmount(filter: String?, completionHandler: @escaping (ContactsAmountResp?, Error?) -> Void) {
        let fxn = Path(name: "/users/amount", method: "POST")
        let obj = ContactsAmountReq(token: token, filter: filter)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func getContacts(filter: String?, offset: Int, limit size: Int, completionHandler: @escaping (ContactsResp?, Error?) -> Void) {
        let fxn = Path(name: "/users/list", method: "POST")
        let obj = ContactsReq(token: token, filter: filter, offset: offset, limit: size)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func getContact(id: Int, offset: Int?, size: Int?, completionHandler: @escaping (ContactResponse?, Error?) -> Void) {
        let fxn = Path(name: "/users/" + String(id), method: "POST")
        let obj = ContactReq(token: token, user_id: id, offset: offset, limit: size)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
}
    
extension FPService: FlatServerFavProtocol {
    func getFavContactsAmount(filter: String?, completionHandler: @escaping (ContactsAmountResp?, Error?) -> Void) {
        let fxn = Path(name: "/fav_users/amount", method: "POST")
        let obj = ContactsAmountReq(token: token, filter: filter)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func getFavContacts(filter: String?, offset: Int, size: Int, completionHandler: @escaping (ContactsResp?, Error?) -> Void) {
        let fxn = Path(name: "/fav_users/list", method: "POST")
        let obj = ContactsReq(token: token, filter: filter, offset: offset, limit: size)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func addFavContacts(user_id: Int, completionHandler: @escaping (FavContactAddResponse?, Error?) -> Void) {
        let fxn = Path(name: "/fav_users/add", method: "POST")
        let obj = FavContactAddReq(token: token, user_id: user_id)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func removeFavContacts(user_id: Int, completionHandler: @escaping (FavoriteContactRemoveResponse?, Error?) -> Void) {
        let fxn = Path(name: "/fav_users/" + String(user_id), method: "DELETE")
        let obj = FavoriteContactsRemoveReqest(token: token, user_id: user_id)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
}
    
extension FPService: FlatServerHistoryProtocol {
    func getHistoryAmount(direction: Int?, period: Int?, filter: String?, completionHandler: @escaping (HistoryAmountResp?, Error?) -> Void) {
        let fxn = Path(name: "/history/amount", method: "POST")
        let obj = HistoryAmountReq(token: token, direction: direction, period: period, filter: filter)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func getHistoryList(direction: Int?, offset: Int, limit: Int, period: Int?, filter: String?, completionHandler: @escaping (HistoryListResp?, Error?) -> Void) {
        let fxn = Path(name: "/history/list", method: "POST")
        let obj = HistoryListReq(token: token, offset: offset, direction: direction, limit: limit, period: period, filter: filter)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func removeHistoryItem(id: Int, completionHandler: @escaping (HistoryListResp?, Error?) -> Void) {
        let fxn = Path(name: "/history/delete", method: "POST")
        let obj = HistoryRemoveReq(token: token, id: id)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func addHistoryItem(name: String, phone: String, user_id: Int?, time: String, duration: Int?, direction: Int, type: Int, completionHandler: @escaping (HistoryAddResp?, Error?) -> Void) {
        let fxn = Path(name: "/history/create", method: "POST")
        let obj = HistoryAddReq(token: token, name: name, phone: phone, time: time, duration: duration, direction: direction, type: type, user_id: user_id)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
}
    
extension FPService: FlatServerPhonesProtocol {
    func getPhonesAmount(request: String?, completionHandler: @escaping (PhonesAmountResp?, Error?) -> Void) {
        let fxn = Path(name: "/phones/amount", method: "POST")
        let obj = PhonesAmountReq(token: token, phone_num: request ?? "")
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
    
    func getPhonesList(request: String?, offset: Int, size: Int, completionHandler: @escaping (PhonesListResp?, Error?) -> Void) {
        let fxn = Path(name: "/phones/list", method: "POST")
        let obj = PhonesListReq(token: token, phone_num: request ?? "", offset: offset, limit: size)
        sendRequest(fxn, request: obj, completionHandler: completionHandler)
    }
}
