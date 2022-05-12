//
//  Intents.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import SwiftUI

enum Intents {
    case db(DatabaseIntent)
    case state(StateIntent)
}

enum StateIntent {
        
}

/*
    search
        toggleView(closed, open)
        binding

    sort
        binding

    filter
        toggleView(closed, open, expanded)
        add
        remove
 
    route
        pop
        back
 */

enum DatabaseIntent {
    case create(DatabaseCreate)
    case delete(DatabaseDelete)
    case update(DatabaseUpdate)
}

enum DatabaseCreate {
    case tag(String?, String?, Color) // name, emoji, color
    case item(String?, Set<UUID>?, Set<UUID>?) // text, links, tags
}

enum DatabaseDelete {
    case tag(Set<UUID>)
    case item(Set<UUID>)
}

enum DatabaseUpdate {
    case tag(UUID, TagUpdate)
    case item(UUID, ItemUpdate)
}

enum TagUpdate {
    case name(String)
    case emoji(String)
    case color(Color)
}

enum ItemUpdate {
    case text(String)
}
