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


struct SceneSnapshot: Equatable {
    var focus: Route = .list
    var tabs: [DetailContent] = []
    var list: ListContent =  ListContent()
}


extension SceneSnapshot {
    /// State update function
    static func update(
        state: SceneSnapshot,
        action: Intents,
        environment: Services
    ) -> Update<SceneSnapshot, Intents> {
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
            case .null: break
            case .navigate(let to):
                switch to {
                case .back: break
                case .to(let id): break
                }
            case .select(let action):
                switch action {
                case .all: break
                case .clear: break
                }
                
            case .toggle(let destination):
                var copy = state

                switch state.focus {
                case .list:
                    switch destination {
                    case .search: copy.list.searching.toggle()
                    case .edit: copy.list.editing.toggle()
                    case .filter: copy.list.filtering.toggle()
                    }
                case .detail(let idx):
                    switch destination {
                    case .search: copy.tabs[idx].searching.toggle()
                    case .edit: copy.tabs[idx].editing.toggle()
                    case .filter: copy.tabs[idx].filtering.toggle()
                    }
                }
                return Update(state: copy)

                
            case .update(let destination):
                var copy = state
                switch state.focus {
                case .list:
                    switch destination {
                    case .search(let newSearch): copy.list.search = newSearch
                    case .sort(let newSort): copy.list.sort = newSort
                    }
                    
                case .detail(let idx):
                    switch destination {
                    case .search(let newSearch): copy.tabs[idx].search = newSearch
                    case .sort(let newSort): copy.tabs[idx].sort = newSort
                    }
                }
                return Update(state: copy)
            }
        }
        return Update(state: state)
    }
}


