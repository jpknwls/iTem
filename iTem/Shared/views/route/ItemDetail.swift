//
//  ItemDetail.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import SwiftUI

struct ItemDetail: View {
    
    /*
        data
        -
     */
    
    let id: UUID
    let mode: Mode
    let search: String
    let sort: Sort
    let filter: Set<UUID>
    
    /*
        events
        -
     */
    
    var body: some View { EmptyView() }
    
    var itemFocus: some View { EmptyView() }
    var itemCard: some View { EmptyView() }

}
