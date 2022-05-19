//
//  TabModel.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import CoreStore




struct DetailContent: Equatable {
    let id: UUID?
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

struct ListContent: Equatable {

    // listPublisher?
    
    var editing: Bool = false
    var searching: Bool = false
    var filtering: Bool = false
    var filters: Set<Tag> = []
    var search: String = ""
    var sort: Sort = .none
    
    // bindings?
    
}
