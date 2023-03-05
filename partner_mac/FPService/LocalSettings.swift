//
//  LocalSettings.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 05.03.2023.
//

import Foundation

enum RedirectMode: String, CaseIterable {
    case always = "всегда (сразу переводить все звонки)"
    case busy = "при занятости"
    case nonanswer = "при неответе"
    case busy_nonanswer = "при занятости и неответе"
}

enum HistoryPeriod: String, CaseIterable {
    case week = "неделя"
    case month = "месяц"
    case quarter = "квартал"
    case year = "год"
}

enum SettingsKey: String {
    case token = "token"
    case refreshToken = "refresh_token"
    case tokenDate = "token_date"
    
    case response = "login_response"
    case version = "app_ver"
    
    case isRedirectOn = "is_redirect_on"
    case isDontDisturbOn = "isDontDisturbOn"
    
    case redirectPhone = "redirect_phone"
    case redirectModel = "redirect_model"
    case redirectTimeout = "redirect_timeout"
    
    case selectedController = "last_controller"
    case isSignedIn = "is_signed_in"
    case callHistory = "call_history"
    case status = "status"
    case darkMode = "dark_mode"
}

class LocalSettings {
    static let shared = LocalSettings()
    let defaults = UserDefaults.standard
    
    init() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            defaults.set(version, forKey: SettingsKey.version.rawValue)
        }
    }
    var loginResponse: LoginResponse? {
        get {
            return defaults.getDecodable(for: SettingsKey.response.rawValue)
        }
        set(newValue) {
            try? defaults.setEncodable(newValue, for: SettingsKey.response.rawValue)
        }
    }
    
    var fpsToken: String? {
        get {
            return defaults.string(forKey: SettingsKey.token.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.token.rawValue)
        }
    }
    var fpsRefreshToken: String? {
        get {
            return defaults.string(forKey: SettingsKey.refreshToken.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.refreshToken.rawValue)
        }
    }
    var fpsTokenDate: TimeInterval? {
        get {
            return defaults.double(forKey: SettingsKey.tokenDate.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.tokenDate.rawValue)
        }
    }
    var app_version: String {
        if let version = defaults.string(forKey: SettingsKey.version.rawValue) {
            return version
        }
        return ""
    }
    
    var isRedirectOn: Bool {
        get {
            return defaults.bool(forKey: SettingsKey.isRedirectOn.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.isRedirectOn.rawValue)
        }
    }
    
    var isDontDisturbOn: Bool {
        get {
            return defaults.bool(forKey: SettingsKey.isDontDisturbOn.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.isDontDisturbOn.rawValue)
        }
    }
    
    var isSignedIn: Bool {
        get {
            return defaults.bool(forKey: SettingsKey.isSignedIn.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.isSignedIn.rawValue)
        }
    }
    
//    var darkMode: [DarkModeModel]? {
//        get {
//            return defaults.getDecodable(for: SettingsKey.darkMode.rawValue)
//        }
//        set(newValue) {
//            try? defaults.setEncodable(newValue, for: SettingsKey.darkMode.rawValue)
//        }
//    }
    
//    var redirectMode: RedirectMode? {
//        get {
//            var value = RedirectMode(rawValue: "")
//            
//            if let redirectModel = self.redirectModel {
//                for sections in redirectModel {
//                    for selectedRedirect in sections {
//                        if selectedRedirect.isSelected != nil {
//                            
//                            switch selectedRedirect.title {
//                            case RedirectMode.busy.rawValue:
//                                value = .busy
//                            case RedirectMode.nonanswer.rawValue:
//                                value = .nonanswer
//                            case RedirectMode.busy_nonanswer.rawValue:
//                                value = .busy_nonanswer
//                            case RedirectMode.always.rawValue:
//                                value = .always
//                            default:
//                                value = .busy
//                            }
//                        }
//                    }
//                }
//            }
//            return value
//        }
//    }
    
    var redirectPhone: String? {
        get {
            return defaults.string(forKey: SettingsKey.redirectPhone.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.redirectPhone.rawValue)
        }
    }
    
    var redirectTimeout: Double? {
        get {
            return defaults.double(forKey: SettingsKey.redirectTimeout.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.redirectTimeout.rawValue)
        }
    }
    
    var lastSelectedController: Int? {
        get {
            return defaults.integer(forKey: SettingsKey.selectedController.rawValue)
        }
        set(newValue) {
            defaults.set(newValue, forKey: SettingsKey.selectedController.rawValue)
        }
    }

//    var callHistory: [CallHistoryModel]? {
//        get {
//            return defaults.getDecodable(for: SettingsKey.callHistory.rawValue)
//        }
//        set(newValue) {
//            try? defaults.setEncodable(newValue, for: SettingsKey.callHistory.rawValue)
//        }
//    }
//    
//    var redirectModel: [[RedirectModel]]? {
//        get {
//            return defaults.getDecodable(for: SettingsKey.redirectModel.rawValue)
//        }
//        set(newValue) {
//            try? defaults.setEncodable(newValue, for: SettingsKey.redirectModel.rawValue)
//        }
//    }
//    
//    var status: [StatusModel]? {
//        get {
//            return defaults.getDecodable(for: SettingsKey.status.rawValue)
//        }
//        set(newValue) {
//            try? defaults.setEncodable(newValue, for: SettingsKey.status.rawValue)
//        }
//    }
    
    func removeAllSettings() {
        defaults.removeObject(forKey: SettingsKey.token.rawValue)
        defaults.removeObject(forKey: SettingsKey.refreshToken.rawValue)
        defaults.removeObject(forKey: SettingsKey.tokenDate.rawValue)
        defaults.removeObject(forKey: SettingsKey.response.rawValue)
        defaults.removeObject(forKey: SettingsKey.version.rawValue)
        defaults.removeObject(forKey: SettingsKey.isRedirectOn.rawValue)
        defaults.removeObject(forKey: SettingsKey.redirectPhone.rawValue)
        defaults.removeObject(forKey: SettingsKey.redirectModel.rawValue)
        defaults.removeObject(forKey: SettingsKey.redirectTimeout.rawValue)
        defaults.removeObject(forKey: SettingsKey.selectedController.rawValue)
        defaults.removeObject(forKey: SettingsKey.isSignedIn.rawValue)
        defaults.removeObject(forKey: SettingsKey.callHistory.rawValue)
        defaults.removeObject(forKey: SettingsKey.status.rawValue)
        defaults.removeObject(forKey: SettingsKey.darkMode.rawValue)
        defaults.removeObject(forKey: SettingsKey.isDontDisturbOn.rawValue)
    }
}
