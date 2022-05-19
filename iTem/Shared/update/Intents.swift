//
//  Intents.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import SwiftUI

enum Intents {
    case null
    case db(DatabaseIntent)
    case select(SelectionAction)
    case update(UpdateDestination)
    case navigate(NavigationDestination)
}

enum UpdateDestination {
    case edit
    case filter
    case search
    case searchText(String)
    case sort(Sort)
}

enum SelectionAction {
    case all
    case clear
    case select(UUID)
    case deselect(UUID)
}

enum NavigationDestination {
    case back //go home
    case left // move index one down or wrap around
    case right // move index one up or wrap around
    case to(UUID) // can open new tab or navigate to already open tab
    case popover(Popover?) // can pass popover route to show, or nil to close
    case dialog(Dialog?) // can pass dialog route to show, or nil to close
}



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
