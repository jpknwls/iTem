//
//  RouteMode.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation

enum ListSheet: Equatable {
    case navExpand
    case filterExpand
    case selectionExpand
    case addTagToFilter
    case addTagToSelection
    case addItemToSelection
}

enum ListAlert: Equatable {
    case deleteConfirm

    
}

enum ListSubRoute: Equatable {
    case none
    case sheet(ListSheet)
    case alert(ListAlert)
}

struct ListContent: Equatable {
    var subRoute: ListSubRoute = .none
    
    // listPublisher?
    
    var editing: Bool = false
    var searching: Bool = false
    var filtering: Bool = false
    var filters: Set<Tag> = []
    var search: String = ""
    var sort: Sort = .none
    
    // bindings?
    
}
