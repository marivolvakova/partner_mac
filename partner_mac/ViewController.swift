//
//  ViewController.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 26.02.2023.
//

import Cocoa
import SnapKit

class FirstViewController: NSViewController {

    lazy var backgroundView: NSImageView = {
        let view = NSImageView()
        view.image = NSImage(named: "background")
        view.imageScaling = .scaleAxesIndependently
        return view
    }()
    
    lazy var loginButton: NSButton = {
        let button = NSButton()
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor(named: "blue")?.cgColor
        button.title = "Войти"
        button.layer?.cornerRadius = 10
        button.isBordered = false
        button.bezelColor = .white
        button.contentTintColor = .white
        button.font = NSFont.systemFont(ofSize: 25)
        
        button.layer?.cornerRadius = 5.0
        button.layer?.shadowOpacity = 1.0
        button.layer?.shadowColor = NSColor.black.cgColor
        button.layer?.shadowOffset = NSMakeSize(5, 5)
        button.layer?.shadowRadius = 20
        return button
    }()
    
    lazy var passwordLine = createLine()
    lazy var serverLine = createLine()
    lazy var loginLine = createLine()
    
    lazy var loginTextfield: NSTextField = {
        let textfield = NSTextField()
        textfield.placeholderAttributedString = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: Asset.Authorization.grey!])
        textfield.isBordered = false
        textfield.isEditable = true
        textfield.textColor = Asset.Authorization.grey
        textfield.font = NSFont.systemFont(ofSize: 18)
        textfield.backgroundColor = .clear
        return textfield
    }()
    
    lazy var passwordTextfield: NSTextField = {
        let textfield = NSTextField()
        textfield.placeholderAttributedString = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: Asset.Authorization.grey!])
        textfield.isBordered = false
        textfield.isEditable = true
        textfield.textColor = Asset.Authorization.grey
        textfield.font = NSFont.systemFont(ofSize: 18)
        textfield.backgroundColor = .clear
        return textfield
    }()
    lazy var serverTextfield: NSTextField = {
        let textfield = NSTextField()
        textfield.placeholderAttributedString = NSAttributedString(string: "Сервер", attributes: [NSAttributedString.Key.foregroundColor: Asset.Authorization.grey!])
        textfield.isBordered = false
        textfield.isEditable = true
        textfield.textColor = Asset.Authorization.grey
        textfield.font = NSFont.systemFont(ofSize: 12)
        textfield.backgroundColor = .clear
        return textfield
    }()
    
    lazy var errorMessage: NSTextField = {
        let label = NSTextField()
        label.stringValue = "Не заполнены обязательные поля"
        label.isBordered = false
        label.isEditable = false
        label.textColor = .red
        label.font = NSFont.systemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.alignment = .center
        label.maximumNumberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupHierarchy()
        setupLayout()
    }
    
    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 150, 150))
        self.view.wantsLayer = true
     
        self.view.window?.contentView = self.view
        self.view.superview?.wantsLayer = true
        
        
    }
    
    func setupview() {
        loginButton.action = #selector(loginCheck)
     }
    
     func setupHierarchy() {
         view.addSubview(backgroundView)
         view.addSubview(passwordLine)
         view.addSubview(serverLine)
         view.addSubview(loginLine)
         view.addSubview(loginButton)
         view.addSubview(loginTextfield)
         view.addSubview(passwordTextfield)
         view.addSubview(serverTextfield)
        view.addSubview(errorMessage)
     }
     
     func setupLayout() {
         backgroundView.snp.makeConstraints { make in
             make.left.right.bottom.top.equalToSuperview()
         }
         
         passwordLine.snp.makeConstraints { make in
             make.top.equalTo(view.snp.centerY)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
         serverLine.snp.makeConstraints { make in
             make.top.equalTo(passwordLine.snp.bottom).offset(61)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
         loginLine.snp.makeConstraints { make in
             make.top.equalTo(passwordLine.snp.bottom).inset(61)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
         loginButton.snp.makeConstraints { make in
             make.top.equalTo(serverLine.snp.bottom).offset(75)
             make.height.equalTo(50)
             make.width.equalTo(240)
             make.centerX.equalTo(view.snp.centerX)
         }
         loginTextfield.snp.makeConstraints { make in
             make.bottom.equalTo(loginLine).inset(6)
             make.centerX.equalTo(loginLine.snp.centerX)
             make.width.equalTo(189)
             make.height.equalTo(24)
         }
         passwordTextfield.snp.makeConstraints { make in
             make.bottom.equalTo(passwordLine).inset(6)
             make.centerX.equalTo(passwordLine.snp.centerX)
             make.width.equalTo(189)
             make.height.equalTo(24)
         }
         serverTextfield.snp.makeConstraints { make in
             make.bottom.equalTo(serverLine).inset(6)
             make.centerX.equalTo(serverLine.snp.centerX)
             make.width.equalTo(189)
             make.height.equalTo(24)
         }
         errorMessage.snp.makeConstraints { make in
             make.top.equalTo(serverLine.snp.bottom).offset(12)
             make.centerX.equalTo(serverLine.snp.centerX)
             make.width.equalTo(392)
             make.height.equalTo(56)
         }
     }
    
    @objc func loginCheck() {
        self.view.window?.contentViewController = SecondViewController()
        
//        if loginTextfield.stringValue != "", passwordTextfield.stringValue != "", serverTextfield.stringValue != "" {
//                let fps = FPService(server: serverTextfield.stringValue)
//                fps.login(user: loginTextfield.stringValue, password: passwordTextfield.stringValue) { [weak self] response, error in
//                    DispatchQueue.main.async {
//                        if error == nil && response != nil {
//                            self?.view.window?.contentViewController = SecondViewController()
//                        } else {
//                            self?.errorMessage.isHidden = false
//                        }
//                }
//            }
//        } else {
//            self.errorMessage.isHidden = false
//        }
    }
   
    
    func createLine() -> NSView {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        return view
    }
}

