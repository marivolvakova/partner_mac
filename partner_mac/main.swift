//
//  main.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 26.02.2023.
//

import Cocoa

// 1
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// 2
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
