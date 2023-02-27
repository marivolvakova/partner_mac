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
    
    lazy var firstLine = createLine()
    lazy var secondLine = createLine()
    lazy var thirdLine = createLine()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupview()
        setupHierarchy()
        setupLayout()
    }
    
    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 480, 270))
        self.view.wantsLayer = true
        self.view.window?.contentView = self.view
        self.view.superview?.wantsLayer = true
    }
    
    func setupview() {

 //       loginButton.bezelColor = NSColor(named: "blue")
 //
 //       firstLine.wantsLayer = true
 //       firstLine.layer?.backgroundColor = .black
 //
 //       secondLine.wantsLayer = true
 //       secondLine.layer?.backgroundColor = .black
 //
 //       therdLine.wantsLayer = true
 //       therdLine.layer?.backgroundColor = .black
        

     }
     func setupHierarchy() {
         view.addSubview(backgroundView)
         view.addSubview(firstLine)
         view.addSubview(secondLine)
         view.addSubview(thirdLine)
     }
     
     func setupLayout() {
         backgroundView.snp.makeConstraints { make in
             make.left.right.bottom.top.equalToSuperview()
         }
         
         firstLine.snp.makeConstraints { make in
             make.top.equalTo(view.snp.centerY)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
         secondLine.snp.makeConstraints { make in
             make.top.equalTo(firstLine.snp.bottom).offset(61)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
         thirdLine.snp.makeConstraints { make in
             make.top.equalTo(firstLine.snp.bottom).inset(61)
             make.height.equalTo(1)
             make.width.equalTo(392)
             make.centerX.equalTo(view.snp.centerX)
         }
     }
    
    func createLine() -> NSView {
        let line = NSView()
        line.wantsLayer = true
        line.layer?.backgroundColor = NSColor.black.cgColor
        
//        line.shadow = NSShadow()

//        line.layer?.cornerRadius = 5.0
//        line.layer?.shadowOpacity = 20
//        line.layer?.shadowColor = NSColor.white.cgColor
//        line.layer?.shadowOffset = CGSize(width: 0, height: 0)
//        line.layer?.shadowRadius = 20

        return line
    }
    
    func createTextfield() -> NSTextField {
        let textfield = NSTextField()
        
        return textfield
    }
}

