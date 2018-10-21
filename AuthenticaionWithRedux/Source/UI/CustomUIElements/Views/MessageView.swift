//
//  MessageView.swift
//  AuthenticaionWithRedux
//
//  Created by Haroon Ur Rasheed on 21/10/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import Toast_Swift

protocol MessageViewable {
    func show(withMessage message:String)
}

class MessageView: MessageViewable {
    
    func show(withMessage message:String) {
        UIApplication.shared.keyWindow?.makeToast(message)
    }

}
