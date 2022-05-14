//
//  CardView.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import SwiftUI

struct CardView<Content: View>: View {
    let onTap: () -> ()
    let onPress: () -> ()
    let content: () -> Content
    var body: some View {
          content()
            .onTapGesture {
                onTap()
            }.onLongPressGesture {
                onPress()
            }
    }
}
