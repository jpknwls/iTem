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
    func tags() -> [TagData]{
        let tags = [TagData(emoji: "π", name: "read later", color: .blue),
                        TagData(emoji: "β€οΈ", name: "favorites", color: .red),
                        TagData(emoji: "πΈ", name: "watch later", color: .purple),
                        TagData(emoji: "π", name: "", color: .orange),
                        TagData(emoji: "", name: "study", color: .white),
                        TagData(emoji: "π¬", name: "to send to max", color: .green),
                        TagData(emoji: "", name: "", color: .yellow),
                        TagData(emoji: "βΎοΈ", name: "baseball", color: .gray),
     
     
     
     ]
        
        var temp: Set<TagData> = []
        for i in 0...Int.random(in: 0...tags.count) {
            if let tag = tags.randomElement() {
                temp.insert(tag)
            }
        }
        
        return temp.reversed()
    }
    
    var body: some Scene {
        WindowGroup {
               SceneViewV2()
            .onAppear {
                for family in UIFont.familyNames.sorted() {
                    guard let first = family.first, first != "." else { continue }
                    let names = UIFont.fontNames(forFamilyName: family)
                    print("Family: \(family) Font names: \(names)")
                }
            }
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
            
    
        

    
 */
