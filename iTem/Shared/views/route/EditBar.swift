//
//  EditBar.swift
//  iTem
//
//  Created by Dana Knowles on 5/12/22.
//

import Foundation
import SwiftUI


struct EditBar: View {
    
    @Binding var deleteConfirm: Bool
    @Binding var addTag: Bool
    @Binding var addItem: Bool

    let selectionCount: Int
    let selectAll: () -> ()
    let clearSelection: () -> ()
    
    var body: some View {
        HStack {
            // search
            IconButton {
                Image(systemName: Icon.delete)
                    // .badge { Text(selectionCount) }
            } action: {
                deleteConfirm.toggle()
            }
 
            IconButton {
                Text("Tag")
                //Image(systemName: "trash")
                    // .badge { Text(selectionCount) }
            } action: {
                addTag.toggle()
            }
          
            IconButton {
                Text("Item")
                //Image(systemName: "trash")
                    // .badge { Text(selectionCount) }
            } action: {
                addItem.toggle()
            }
         
            IconButton {
                Text("Select All")
                //Image(systemName: "trash")
                    // .badge { Text(selectionCount) }
            } action: {
                selectAll()
            }
        
            IconButton {
                Text("Clear Selection")
                //Image(systemName: "trash")
                    // .badge { Text(selectionCount) }
            } action: {
                clearSelection()
            }
        }
    }
}
