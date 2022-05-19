//
//  ExtensionFarm.swift
//  iTem
//
//  Created by Dana Knowles on 5/14/22.
//

import Foundation
import SwiftUI

extension Binding: Equatable where Value == String {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

