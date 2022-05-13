//
//  ToDo.swift
//  iTem
//
//  Created by Dana Knowles on 5/12/22.
//

import Foundation
import SwiftUI
import CoreStore
/*
 main
    [.started] NavBar
    [.started] ControlBar
    [.started] EditBar
    [.not started] ListView
    [.not started] DetailView
 
 sheet
    [.not started] TabList
    [.not started] ItemList

alert
    [] AddItemDialog
 
 common
    [.start] Button
    - home (trigger) (action)
    - expandNav (trigger) (viewChange->sheet)
    - addFilter (trigger) (viewChange->sheet)
    - expandFilter (trigger) (viewChange->sheet)
    - clearText (trigger) (action)
    - DeleteSelection (trigger) (viewChange->alert)
    - AddTagToSelection (trigger) (viewChange->sheet)
    - AddItemToSelection (trigger) (viewChange->sheet)
    - AddAllToSelection (trigger) (action)
    - ClearSelection (trigger) (action)
    - Search (toggle) (viewUpdate->showing)
    - Sort (trigger) (viewChange->Menu)
    - Filter (toggle) (viewUpdate->showing)
    - Edit (toggle) (viewUpdate->showing)
    - AddItem (trigger) (viewChange->...)
    - showSelection (viewChange->sheet)
    [.start] ScrollContainer
    [.start] FilterCard
    [.start] TabCard
    [.start] SearchField
 */

enum TabSheet: Equatable {
    case navExpand
    case filterExpand
    case selectionExpand
    case addTagToFilter
    case addTagToSelection
    case addItemToSelection
}

enum TabAlert: Equatable {
    case deleteConfirm

}

enum TabSubRoute: Equatable {
    case none
    case sheet(TabSheet)
    case alert(TabAlert)
}

struct TabState: Equatable {
    let id: UUID?
    
    var subRoute: TabSubRoute = .none
    
    // passed to the view
    let objectPublisher: ObjectPublisher<Item>
    
    var editing: Bool = false
    var searching: Bool = false
    var filtering: Bool = false
    var filters: Set<Tag> = []
}

struct IconButton<Content: View>: View {
    let content: () -> Content
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            content()
        }

    }
}

struct HorizontalScrollContainer<Content: View>: View {
    let content: () -> Content
    let showsIndicators = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: showsIndicators) {
          content()
        }
    }
}

struct SearchField: View {
    @Binding var text: String
    var body: some View {
        TextField("Search...", text: $text)
    }
}

struct CardView<Content: View>: View {
    let onTap: () -> ()
    let onPress: () -> ()
    let content: () -> Content
    var body: some View {
          content()
            .onTapGesture {
                onTap()
            }.onLongPressGesture {
                onPress()
            }
    }
}


enum Icons: String {
    // navbar
    case home = "house"
    case expand = "ellipsis.circle"
    // editbar
    case selection = "lasso"
    case clear = "xmark.circle"
    case delete = "trash"
    case tag = "tag"
    case addItem = "doc.badge.plus"
    // control bar
    case searchMini = "magnifyingglass.circle"
    case search = "magnifyingglass"
    case sort = "arrow.up.arrow.down"
    case filter = "line.3.horizontal.decrease"
    case edit = "square.and.pencil"
    case add = "plus"
    // media
    case document = "doc"
    case music = "music.note"
    case audio = "waveform"
    case link = "link"
    case image = "photo"
    case video = "video"
}
