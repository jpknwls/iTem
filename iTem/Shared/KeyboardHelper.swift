//
//  KeyboardHelper.swift
//  iTem
//
//  Created by Dana Knowles on 5/31/22.
//

import UIKit
import Foundation
import SwiftUI

class KeyboardHeightHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        self.listenForKeyboardNotifications()
    }
}

extension KeyboardHeightHelper {
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                guard let userInfo = notification.userInfo,
                                                    let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                                                withAnimation(.spring()) {
                                                    self.keyboardHeight = keyboardRect.height
                                                }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                withAnimation(.spring()) {
                                                    self.keyboardHeight = 0
                                                }
        }
    }
}
