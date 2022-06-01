//
//  State.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import ObservableStore
import SwiftUI


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



extension SceneV2Snapshot {
    /// State update function
    static func update(
        state: SceneV2Snapshot,
        action: IntentsV2,
        environment: Services
    ) -> Update<SceneV2Snapshot, IntentsV2> {
        switch action {
        case .update(let action):
            switch action {
            case .search(let newSearch):
                var copy = state
                copy.searchText = newSearch
                return Update(state: copy)
            case .focus(let newFocus):
                var copy = state
                copy.focusOn = newFocus
                return Update(state: copy)
            case .tab(let tab):
                var copy = state
                withAnimation(.spring()) {
                    copy.tabPosition = tab
                }
                return Update(state: copy)
            default: return Update(state: state)
            }
            
        default: return Update(state: state)

        }
    }
}
















struct SceneSnapshot: Equatable {
    
    var main: Route = .list
    var popover: Popover? = nil
    var dialog: Dialog? = nil
    
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


        case .null: break
        case .navigate(let to):
            var copy = state
            switch to {
            case .back: break
            case .left: break
            case .right: break
            case .to(let id): break
            case .dialog(let dialog):
                copy.dialog = dialog
                return Update(state: copy, transaction: .init(animation: .spring()))

            case .popover(let popover):
                copy.popover = popover
                return Update(state: copy, transaction: .init(animation: .spring()))
            
            }
            return Update(state: copy)
           

        case .select(let action):
            var copy = state
            switch action {
            case .all:
                switch state.main {
                case .list: break
                case .detail(let id): break
                }
            case .clear:
                switch state.main {
                case .list: break
                case .detail(let id): break
                }
            case .select(let id):
                switch state.main {
                case .list: break
                case .detail(let id): break
                }
            case .deselect(let id):
                switch state.main {
                case .list: break
                case .detail(let id): break
                }
            }
            return Update(state: copy)

            case .update(let destination):
                var copy = state
                switch state.main {
                case .list:
                    switch destination {
                    case .searchText(let newSearch): copy.list.search = newSearch
                    case .sort(let newSort): copy.list.sort = newSort
                    case .search: copy.list.searching.toggle()
                    case .edit: copy.list.editing.toggle()
                    case .filter: copy.list.filtering.toggle()
                        
                    }
                    
                case .detail(let idx):
                    switch destination {
                    case .searchText(let newSearch): copy.tabs[idx].search = newSearch
                    case .sort(let newSort): copy.tabs[idx].sort = newSort
                    case .search: copy.tabs[idx].searching.toggle()
                    case .edit: copy.tabs[idx].editing.toggle()
                    case .filter: copy.tabs[idx].filtering.toggle()
                    }
                }
                return Update(state: copy)
            }
        
        return Update(state: state)
    }
}


