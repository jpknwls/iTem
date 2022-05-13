//
//  ControlBar.swift
//  iTem
//
//  Created by Dana Knowles on 5/11/22.
//

import Foundation
import SwiftUI


struct ControlBar: View {
    

    @Binding var search: String
    @Binding var sort: Sort
    @Binding var filter: Set<UUID>
    
    
    let toggleEdit: () -> ()
    
    @State var searchShowing: Bool = false
    @State var filterShowing: Bool = false
    
    var body: some View {
        VStack {
            if filterShowing {
                
            }
            if searchShowing {
                SearchField(text: $search)
            }
            HStack {
                // search
                IconButton {
                    Image(systemName: "magnifyingglass")
                } action: {
                    searchShowing.toggle()
                }
                IconButton {
                    Text("Filter")
                    //Image(systemName: "magnifyingglass")
                } action: {
                    filterShowing.toggle()
                }
                // sort
                Menu {
                    
                } label: {
                    Text("Sort")
                }
                // filter
                // edit
                IconButton {
                    Text("Edit")
                    //Image(systemName: "pencil.and.box")
                } action: {
                    toggleEdit()
                }
                
                // add
                IconButton {
                    Text("Add")
                    //Image(systemName: "pencil.and.box")
                } action: {
                    
                }
                
            }
            .font(.caption)
            
        }
        
    }
    
}
