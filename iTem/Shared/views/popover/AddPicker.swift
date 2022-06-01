//
//  AddPicker.swift
//  iTem
//
//  Created by Dana Knowles on 5/30/22.
//

import Foundation
import SwiftUI

struct AddPicker: View {
    
    let createSpace: (String) -> ()
    let createItem: (MediaType) -> ()
    
    var body: some View {
        Form {
            Section("Space") {
                // textfield to name
                // option to add tags?
            }
            Section("Item") {
                // grid of icons
                
            }
        }
    }
}
