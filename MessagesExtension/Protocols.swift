//
//  Protocols.swift
//  MessagesExtension
//
//  Created by Developer on 4/21/20.
//  Copyright © 2020 JwitApps. All rights reserved.
//

import Messages

public protocol OrientationManager {
    func requestPresentationStyle(_: MSMessagesAppPresentationStyle)
}

extension MSMessagesAppViewController: OrientationManager { }
