//
//  SecondViewController.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 05.03.2023.
//

import Cocoa

class SecondViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
       
    }
    
    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 150, 150))
        self.view.wantsLayer = true
        
        self.view.window?.contentView = self.view
        self.view.superview?.wantsLayer = true
    }
    
    func setupview() {
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
    }
}
