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
            .padding()
            .foregroundColor(.green)
            .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.green)
                            .opacity(0.3)
                            .blur(radius: 1.0))

    }
}

