//
//  State.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import ObservableStore


enum Sort {
    case none
    case a2z
    case z2a
    case youngest
    case oldest
}

/*
    Find (search, sort, filter)
    Route (list, detail)
    Mode  (idle, edit, sheet, dialog)
    
 
 */
struct StateSnapshot: Equatable {
    var search: String = ""
    var sort: Sort = .none
    var filter: Set<UUID> = []
    
    var currentRoute: Route = .list
    var tabs: [Route] = []
    
    
    var mode: Mode = .idle
}

extension StateSnapshot {
    /// State update function
    static func update(
        state: StateSnapshot,
        action: Intents,
        environment: Services
    ) -> Update<StateSnapshot, Intents> {
        switch action {
            //
        case .db(let action):
            switch action {
            case .create(let action):
                switch action {
                case .tag(let name, let emoji, let color):
                    environment.database.createTag(name: name, emoji: emoji, color: color)
                case .item(let text, let links, let tags):
                    environment.database.createItem(text: text, links: links, tags: tags)
                }
            case .delete(let action):
                switch action {
                case .tag(let ids):
                    environment.database.deleteTags(incomingIDs: ids)
                case .item(let ids):
                    environment.database.deleteItems(incomingIDs: ids)
                }
            case .update(let action):
                switch action {
                case .tag(let id, let tagUpdate):
                    switch tagUpdate {
                    case .color(let newColor): break
                    case .name(let newName): break
                    case .emoji(let newEmoji): break

                    }
                case .item(let id, let itemUpdate):
                    switch itemUpdate {
                    case .text(let newText): break
                    }
                }
            }
        case .state(let action):
            switch action {
            
            }
        }
        return Update(state: state)
    }
}

enum Route: Equatable {
    case list
    case detail(UUID)
}

enum Mode: Equatable {
    case alert(AlertRoute)
    case sheet(SheetRoute)
    case idle
    case editing
}
enum SheetRoute: Equatable {
    
}

enum AlertRoute: Equatable {
        
}


