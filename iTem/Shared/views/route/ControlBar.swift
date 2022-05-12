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
                TextField("Search...", text: $search)
            }
            HStack {
                // search
                Text("Search")
                    .onTapGesture {
                        searchShowing.toggle()
                    }
                // sort
                Menu {
                    
                } label: {
                    Text("Sort")
                }
                // filter
                
                Text("Filter")
                    .onTapGesture {
                        filterShowing.toggle()
                    }
                // edit
                Text("Edit")
                    .onTapGesture {
                        toggleEdit()
                    }
                // add
                
            }
            .font(.caption)
            
        }
        
    }
    
}
