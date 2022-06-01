//
//  ItemList.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import SwiftUI
import CoreStore

struct ItemList: View {
    
    /*
        data
        - routes
     */
    let state: ListContent

    /*
        events
        -
     */
    
    var body: some View {
       EmptyView()
        
    }
    
    func itemCard() -> some View {
        EmptyView()
    }
}

struct ItemListView: View {
    @ListState
    var items: ListSnapshot<Item>

    var body: some View {
        List {
                ForEach(objectIn: items) { item in
                        // ...
                    //Text(item.text ?? "")
                }
            }
        
    
        .animation(.default)
    }
}
