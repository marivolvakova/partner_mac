//
//  main.swift
//  partner_mac
//
//  Created by Мария Вольвакова on 26.02.2023.
//

import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
