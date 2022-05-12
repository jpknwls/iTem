//
//  iTemApp.swift
//  Shared
//
//  Created by Dana Knowles on 5/10/22.
//


/*
 
    
    - Data
        - ObservableStore
        - CoreStore
        - Environment

    - Routes
        - enum Routes
    
    - Intents
        - enum Intents
    
        - state
            - search/sort/filter
            - navigation
                - route
                - mode
                - dialog/sheet
        - db
            - create(
                - item
                - tag
            - delete(ids)
            - update
                - item
                    - text
                -  tag
    
    
    - View
        - navBar
        - toolBar
        - content
        - sheet
        - alert
 
    - Update
        -
         static func update(
             state: State,
             action: Intents,
             environment: Services
         ) -> Update<AppState, Intents> {}
    
 
 */
import SwiftUI

@main
struct iTemApp: App {
    var body: some Scene {
        WindowGroup {
            SceneView()
        }
    }
}

/*
 AppView
     SceneView
         NavigationView
         ContentView
             - ListView
             - [DetailView]
         ControlView
            FilterPicker
            ItemPicker
            
            ConfirmDeleteDialog
            AddItemDialog
    
        

    
 */
