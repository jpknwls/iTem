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

    rebuild
 
        we want to eventually integrate the mind-map style canvas for "Spaces"
        first, we'll build out "Library" and "Focus"
        
        Library
            data
            - list of all items
 
            features
            - search
            - filter
            - sort
            - select
                - tag editing
            - add
            - focus -> focus
 
        Focus
            data
            - single item
 
 
            features
            - text editing
            - tag editing
        ....
 
        Space
            data
            - space
 
 
 
 models
    (tag)
            id: UUID
            name: String
            emoji: String
            color -> hue, saturation, brightness
            [items]: [Item]
            recentlyFiltered: Date
            recentlyTagged: Date

    (item)
            id: UUID
            text: String
            createdAt: Date
            updatedAt: Date
            visitedAt: Date
             // url
            children: List<Item>
            parents: Set<Item>
            tags: Set<Tag>
        
 
 state
    (content)
            current: Route
            list: [ListState]
            tabs: [TabState]
    (popover)
            popover: Popover?
    (dialog)
            dialog: Dialog?
 

 
 intents
    (navigation)
        content
            to(:id)
            switch(:idx)
            home
        popover
            to
            close
        dialog
            to
            close
 
    (select)
        all
        clear
        select(UUID)
        deselect(UUID)
    (db)
        item
            create
            update
             .text
             .tags
                 .add
                 .remove
              .links
                  .add
                  .remove

            delete
        tag
            create
            update
             .name
             .emoji
             .color
            delete
 
    (toggle) // maybe condense this with update
    (update)
        search
        sort
 
 
 flows
    - add item
        - create new item
            - from bottom right in both list and detail view[
        - open it as tab
        - open focus view
            - full screen text entry
            - sheets for adding media links, item links, tag link
        - if hit done and all fields are empty
            -> delete, close tab and navigate to previous
                (if adding to something, this should be passed in to display at the top. otherwise, go to list view)
        -
        
 
    -
 
 routes + views
    (@ indicates a binding)

    (view)
        list
            -> ListView
        detail(:id)
            -> DetailView
        focus(:id)
            -> FocusView?
    (popover)
        navExpand
            -> NavExpandView
        filterExpand
            -> FilterExpandView?
        selectionExpand
            -> ...?
        addTagToFilter
            -> AddFilterView
        addTagToSelection
            -> View
        addItemToSelection
            ->
        addItemToDetail
 
    (dialog)
        deleteConfirm
        addTag
        focusText(:@text) //
 
 
    
 
 */





/*
 
 Knowledge Base
 
 
 main
    [.started] NavBar
    [.started] ControlBar
    [.started] EditBar
    [.not started] ListView
    [.not started] DetailView
 
 card
 [.start] FilterCard
 [.start] TabCard
 
 sheet
- [.not started] TabList
- [.not started] ItemList

alert
- [] AddItemDialog
 
 common
 - [.start] Button
 - [.start] ScrollContainer
 navigation
 
 - home (trigger) (action)
 - expandNav (trigger) (viewChange->sheet)

 selection
 - DeleteSelection (trigger) (viewChange->alert)
 - AddTagToSelection (trigger) (viewChange->sheet)
 - AddItemToSelection (trigger) (viewChange->sheet)
 - AddAllToSelection (trigger) (action)
 - ClearSelection (trigger) (action)
 - showSelection (viewChange->sheet)

 
 filter
 - addFilter (trigger) (viewChange->sheet)
 - expandFilter (trigger) (viewChange->sheet)
 - Filter (toggle) (viewUpdate->showing)

search
 - clearText (trigger) (action)
 - Search (toggle) (viewUpdate->showing)
 - Sort (trigger) (viewChange->Menu)
 - [.start] SearchField


 
- Edit (toggle) (viewUpdate->showing)
- AddItem (trigger) (viewChange->...)


 */





/*
    logic
 
        Model CRUD
    
            .addItem
            .removeItem
            .updateItem
                .text
                .tags
                    .add
                    .remove
                 .links
                     .add
                     .remove
            
            addTag
            removeTag
            updateTag
                .name
                .emoji
                .color
     
 
 
            sheet
 
            
 
 */


// extensions

