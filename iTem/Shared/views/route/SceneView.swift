//
//  ContentView.swift
//  Shared
//
//  Created by Dana Knowles on 5/10/22.
//

import SwiftUI
import ObservableStore

/*
    SceneView
        NavigationView
        ContentView
            - ListView
            - [DetailView]
        ControlView
 
 */

struct SceneView: View {
    @StateObject var store = Store(update: StateSnapshot.update, state: StateSnapshot(), environment: Services())
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                NavigationBar(
                              route: store.state.currentRoute,
                              tabs: store.state.tabs,
                              goTo: {id in },
                              goHome: {},
                              toggleNavExpanded: {}
                )
                
                
                switch store.state.currentRoute {
                    case .list:
                        // search, sort, filter
                        // mode
                        ItemList(mode: store.state.mode,
                                 search: store.state.search,
                                 sort: store.state.sort,
                                 filter: store.state.filter)
                        
                    case .detail(let id):
                        // search, sort, filter
                        // mode
                        ItemDetail(id: id,
                                   mode: store.state.mode,
                                   search: store.state.search,
                                   sort: store.state.sort,
                                   filter: store.state.filter)
                    
                }
                Spacer()
            }
            
            VStack {
            ControlBar(search: <#Binding<String>#>,
                       sort: <#Binding<Sort>#>,
                       filter: <#Binding<Set<UUID>>#>,
                       toggleEdit: <#() -> ()#>)
            }
        }
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView()
    }
}
