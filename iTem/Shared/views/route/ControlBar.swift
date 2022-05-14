//
//  ControlBar.swift
//  iTem
//
//  Created by Dana Knowles on 5/11/22.
//

import Foundation
import SwiftUI


struct ControlBar: View {
    


    @Binding var sort: Sort
    @Binding var editing: Bool
    @Binding var searchShowing: Bool
    @Binding var filterShowing: Bool
    
    // add action
    
    var body: some View {
        VStack {
            HStack {
                // search
                IconButton {
                    Image(systemName: Icon.search)
                } action: {
                    searchShowing.toggle()
                }
                IconButton {
                    Image(systemName: Icon.filter)
                } action: {
                    filterShowing.toggle()
                }
                // sort
                Menu {
                    Picker(selection: $sort, label: Text("Sorting")) {
                        Text("None").tag(Sort.none)
                        Text("Youngest").tag(Sort.youngest)
                        Text("Oldest").tag(Sort.oldest)
                        Text("Alphabetical").tag(Sort.a2z)
                        Text("Reverse Alphabetical").tag(Sort.z2a)
                        }
                    
                } label: {
                    Image(systemName: Icon.sort)
                        .frame(height: 40)
                        .padding()
                        .foregroundColor(.green)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.green)
                                        .opacity(0.6)
                                        .blur(radius: 2.0))
                }
                // filter
                // edit
                IconButton {
                    Image(systemName: Icon.edit)
                } action: {
                    editing.toggle()
                }
                
                // add
                IconButton {
                    Image(systemName: Icon.add)
                } action: {
                    
                }
                
            }
            .font(.title)
            
        }
        
    }
    
}
