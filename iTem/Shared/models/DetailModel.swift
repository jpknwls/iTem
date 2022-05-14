//
//  TabModel.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import CoreStore



enum DetailSheet: Equatable {
    case navExpand
    case filterExpand
    case selectionExpand
    case addTagToFilter
    case addTagToSelection
    case addItemToSelection
}

enum DetailAlert: Equatable {
    case deleteConfirm

}

enum DetailSubRoute: Equatable {
    case none
    case sheet(DetailSheet)
    case alert(DetailAlert)
}




struct DetailContent: Equatable {
    let id: UUID?
    
    var subRoute: DetailSubRoute = .none
    
    // passed to the view
    let objectPublisher: ObjectPublisher<Item>
    
    var editing: Bool = false
    var searching: Bool = false
    var filtering: Bool = false
    var search: String = ""
    var sort: Sort = .none
    var filters: Set<Tag> = []

    // bindings?
}
