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
    let mode: Mode
    let search: String
    let sort: Sort
    let filter: Set<UUID>
    
    
    /*
        events
        -
     */
    
    var body: some View {
        switch mode {
        case .idle: EmptyView()
        case .alert(let route): EmptyView()
        case .sheet(let route): EmptyView()
        case .editing: EmptyView()
        }
        
    }
    
    func itemCard() -> some View {
        EmptyView()
    }
}
