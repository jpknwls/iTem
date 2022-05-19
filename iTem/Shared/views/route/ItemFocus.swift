//
//  ItemFocus.swift
//  iTem
//
//  Created by Dana Knowles on 5/16/22.
//

import Foundation
import SwiftUI

struct ItemFocus: View {
    // data
    @Binding var text: String
    
    // callbacks
    // back
    let back: () -> ()
    
    var body: some View {
        TextEditor(text: $text)
        // control bar
    }
}


