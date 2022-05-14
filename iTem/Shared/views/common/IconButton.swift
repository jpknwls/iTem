//
//  IconButton.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import SwiftUI

struct IconButton<Content: View>: View {
    let content: () -> Content
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            content()
        }
        .frame(height: 40)
        .padding()
        .foregroundColor(.green)
        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                        .opacity(0.6)
                        .blur(radius: 2.0))

    }
}
