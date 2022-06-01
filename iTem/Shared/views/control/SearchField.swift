//
//  File.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var body: some View {
        TextField("Search...", text: $text)
            .padding(4)
            .foregroundColor(.green)
            .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.teal)
                            .opacity(0.2)
                            .blur(radius: 3.0))
    }
}

struct SearchFieldV2: View {
    @Binding var text: String
    var body: some View {
        TextField("Search",text: $text)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(BlurView(style: .dark))
            .cornerRadius(10)
            .colorScheme(.dark)
            .padding(.top, 10)
    }
}
