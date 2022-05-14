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
    @StateObject var store = Store(update: SceneSnapshot.update, state: SceneSnapshot(), environment: Services())
    
    var body: some View {
        return ZStack(alignment: .bottom) {
            content
            controlBar
            // alert??
        }
    }
}

extension SceneView {
    var content: some View {
        VStack {
            switch store.state.focus {
                case .list:
                    NavigationBar(
                                  route: store.state.focus,
                                  tabs: store.state.tabs,
                                  goTo: {id in },
                                  goHome: {},
                                  toggleNavExpanded: {}
                    )
                    // search, sort, filter
                    // mode
                ItemList(state: store.state.list)
                    
                case .detail(let idx):
                    // search, sort, filter
                    // mode
                    NavigationBar(
                                  route: store.state.focus,
                                  tabs: store.state.tabs,
                                  goTo: {id in },
                                  goHome: {},
                                  toggleNavExpanded: {}
                    )
                    ItemDetail(state: store.state.tabs[idx])
                                   
                
            }
            Spacer()
        }
    }
}

extension SceneView {
    var controlBar: some View {
        VStack {
        switch store.state.focus {
            case .list:
            if store.state.list.filtering {
//            filter: store.binding { state in
//                 state.list.filters
//             } tag: { newValue in
//                     .state(.null)
//             },
                Text("Filtering")
            }
            if store.state.list.searching {
                SearchField(text: listSearch)
            }
            if store.state.list.editing {
                EditBar(deleteConfirm: deletingBinding,
                        addTag: addingTagBinding,
                        addItem: addingItemBinding,
                        selectionCount: store.state.list.filters.count,
                        selectAll: {},
                        clearSelection: {})
            }
                ControlBar(sort: sortBinding,
                           editing: editBinding,
                           searchShowing: searchShowingBinding,
                           filterShowing: filterShowingBinding)
            case .detail(let idx):
            
            if store.state.list.filtering {
                        //filterPicker
//                filter: store.binding { state in
//                     state.tabs[idx].filters
//                 } tag: { newValue in
//                         .state(.null)
//                 },
                Text("Filtering")

                }
            if store.state.list.searching {
                SearchField(text: detailSearch(idx: idx))
            }
            
            if store.state.list.editing {
                EditBar(deleteConfirm: deletingBinding(idx: idx),
                        addTag: addingTagBinding(idx: idx),
                        addItem: addingItemBinding(idx: idx),
                        selectionCount: store.state.tabs[idx].filters.count,
                        selectAll: {},
                        clearSelection: {})
                   
            
            }
                ControlBar(
                   sort:sortBinding(idx: idx),
                   editing:editBinding(idx: idx),
                   searchShowing:searchShowingBinding(idx: idx),
                   filterShowing:filterShowingBinding(idx:idx)
                )
            }
        
        }
        
    }
    
}

/*
 
 @Binding var sort: Sort
 @Binding var editing: Bool
 @Binding var searchShowing: Bool
 @Binding var filterShowing: Bool
 */


extension SceneView {
    var listSearch: Binding<String> {
        store.binding { state in
            state.list.search
        } tag: { newValue in
                .state(.update(.search(newValue)))
        }
    }
    
    func detailSearch(idx: Int) -> Binding<String> {
        store.binding { state in
            state.tabs[idx].search
        } tag: { newValue in
            .state(.update(.search(newValue)))
        }
    }
}
// list control bar
extension SceneView {
    var sortBinding: Binding<Sort> {
        store.binding { state in
            state.list.sort
        } tag: { newValue in
                .state(.update(.sort(newValue))) //
        }
    }

    var editBinding: Binding<Bool> {
        store.binding { state in
            state.list.editing
        } tag: { newValue in
            .state(.toggle(.edit))
        }
    }
    var searchShowingBinding: Binding<Bool> {
        store.binding { state in
            state.list.searching
        } tag: { newValue in
            .state(.toggle(.search))//
        }
    }
    var filterShowingBinding: Binding<Bool> {
        store.binding { state in
            state.list.filtering
        } tag: { newValue in
            .state(.toggle(.filter))
        }
    }
    
    
}
/*
 @Binding var deleteConfirm: Bool
 @Binding var addTag: Bool
 @Binding var addItem: Bool
 */

// list edit bar
extension SceneView {
    var deletingBinding: Binding<Bool> {
        store.binding { state in
            switch state.list.subRoute {
                case .none, .sheet(_): return false
                case .alert(let alert):
                    switch alert {
                        case .deleteConfirm: return true
                    }
                }
        } tag: { newValue in
            if newValue {
                // set to this route
            } else {
                // set route to none
            }
            return .state(.null) //
        }
    }
    var addingTagBinding: Binding<Bool> {
        store.binding { state in
            switch state.list.subRoute {
                case .none, .alert(_): return false
                case .sheet(let sheet):
                switch sheet {
                    case .addTagToSelection: return true
                    default: return false
                }
                }
        } tag: { newValue in
                .state(.null)
        }
    }
    var addingItemBinding: Binding<Bool> {
        store.binding { state in
            switch state.list.subRoute {
                case .none, .alert(_): return false
                case .sheet(let sheet):
                switch sheet {
                    case .addItemToSelection: return true
                    default: return false
                }
            }
        } tag: { newValue in
                .state(.null)
        }
    }
    
}

// detail control bar
extension SceneView {
        func deletingBinding(idx: Int) -> Binding<Bool> {
            store.binding { state in
                switch state.tabs[idx].subRoute {
                    case .none, .sheet(_): return false
                    case .alert(let alert):
                        switch alert {
                            case .deleteConfirm: return true
                        }
                    }
            } tag: { newValue in
                if newValue {
                    // set to this route
                } else {
                    // set route to none
                }
                return .state(.null) //
            }
        }
                        
        func addingTagBinding(idx: Int) -> Binding<Bool> {
            store.binding { state in
                switch state.tabs[idx].subRoute {
                    case .none, .alert(_): return false
                    case .sheet(let sheet):
                    switch sheet {
                        case .addTagToSelection: return true
                        default: return false
                    }
                    }
            } tag: { newValue in
                    .state(.null)
            }
        }
                        
        func addingItemBinding(idx: Int) ->  Binding<Bool> {
            store.binding { state in
                switch state.tabs[idx].subRoute {
                    case .none, .alert(_): return false
                    case .sheet(let sheet):
                    switch sheet {
                        case .addItemToSelection: return true
                        default: return false
                    }
                }
            } tag: { newValue in
                    .state(.null)
            }
        }
}

// detail control bar
extension SceneView {
    func sortBinding(idx: Int) -> Binding<Sort> {
        store.binding { state in
            state.tabs[idx].sort
        } tag: { newValue in
            .state(.update(.sort(newValue)))
        }
    }

    func editBinding(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].editing
        } tag: { newValue in
            .state(.toggle(.edit))
        }
    }
    func searchShowingBinding(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].searching
        } tag: { newValue in
            .state(.toggle(.search)) //
        }
    }
    func filterShowingBinding(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].filtering
        } tag: { newValue in
            .state(.toggle(.filter))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView()
    }
}
