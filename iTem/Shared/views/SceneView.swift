//
//  ContentView.swift
//  Shared
//
//  Created by Dana Knowles on 5/10/22.
//

import SwiftUI
import ObservableStore

/*
    
 
 
 */

struct SceneView: View {
    @StateObject var store = Store(update: SceneSnapshot.update, state: SceneSnapshot(), environment: Services())
    /*
     
        bindings
            
             sortBinding
             editBinding
             searchShowingBinding
             filterShowingBinding
          
             deletingBinding
             addingTagBinding
             addingItemBinding
          
             listSearchBinding
             detailSearchBinding
          
        subViews
            - view (handles list, detail, focus)
            - popover
            - dialog
     
     
        conveniences
         
            dialogOn: Bool
            popoverOn: Bool
         

        controlContainer
        contentContainer
     */

    @State var dragOffset: CGSize = .zero

    var body: some View {
        
        ZStack(alignment: .bottom) {
            view
            if popoverOn {
                popover
            }
            if dialogOn {
                dialogContainer
            }
        }
    }
}

extension SceneView {
    var view: some View {
        ZStack(alignment: .bottom) {
            contentContainer
            controlContainer
            // alert??
        }
        .background(RoundedRectangle(cornerRadius: 10.0).foregroundColor(.green).opacity(0.2))
        .offset(y: popoverOn ? -20.0 : 0.0)
        .rotation3DEffect(
            Angle(degrees: popoverOn ? (20.0 - (20.0 * (self.dragOffset.height / 600))) : 0.0),
                axis: (x: 1.0, y: 0.0, z: 0.0))
        
    }
}

extension SceneView {
    var popover: some View {
        
            RoundedRectangle(cornerRadius: 10.0)
            .onTapGesture {
                store.send(.navigate(.popover(.none)))
            }
            .offset(y: self.dragOffset.height)
            .gesture(DragGesture()
                .onChanged{ change in
                    if change.translation.height < 0 { return }
                    self.dragOffset = change.translation
                    print(self.dragOffset)
                }
                .onEnded { end in
                    if self.dragOffset.height > 250 {
                        store.send(.navigate(.popover(.none)))
                    }
                    withAnimation(.spring()) {
                        self.dragOffset = .zero
                    }
                    // possibly dimiss
                }
            )
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea([.bottom])
            .transition(.move(edge: .bottom))
        }
    
}

extension SceneView {
    var dialogContainer: some View {
        ZStack {
                switch store.state.main {
                case .list: EmptyView()
                case .detail(let idx): EmptyView()
            }
 
        }
    }
}

extension SceneView {
    var contentContainer: some View {
        VStack {
            switch store.state.main {
                case .list:
                    NavigationBar(
                                  route: store.state.main,
                                  tabs: store.state.tabs,
                                  goTo: {id in },
                                  goHome: {},
                                  toggleNavExpanded: { store.send(.navigate(.popover(.navExpand))) }
                    )
                    ItemList(state: store.state.list)
                    
                case .detail(let idx):
                    NavigationBar(
                                  route: store.state.main,
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
    var controlContainer: some View {
        VStack {
        switch store.state.main {
            case .list:
            if store.state.list.filters.count > 0 {
//            filter: store.binding { state in
//                 state.list.filters
//             } tag: { newValue in
//                     .state(.null)
//             },
                Text("Filtering")
            }
            if store.state.list.searching {
                SearchField(text: listSearchBinding)
            }
            if store.state.list.editing {
                EditBar(deleteConfirm: deletingDialog,
                        addTag: addingTagPopover,
                        addItem: addingItemPopover,
                        selectionCount: store.state.list.filters.count,
                        selectAll: {},
                        clearSelection: {})
            }
                ControlBar(sort: sortBinding,
                           editing: editBinding,
                           searchShowing: searchShowingBinding,
                           filterShowing: filterShowingBinding)
            case .detail(let idx):
            
            if store.state.tabs[idx].filters.count > 0 {
                        //filterPicker
//                filter: store.binding { state in
//                     state.tabs[idx].filters
//                 } tag: { newValue in
//                         .state(.null)
//                 },
                Text("Filtering")

                }
            if store.state.tabs[idx].searching {
                SearchField(text: detailSearchBinding(idx: idx))
            }
            
            if store.state.tabs[idx].editing {
                EditBar(deleteConfirm: deletingDialog,
                        addTag: addingTagPopover,
                        addItem: addingItemPopover,
                        selectionCount: store.state.tabs[idx].filters.count,
                        selectAll: {},
                        clearSelection: {})
                   
            
            }
                ControlBar(
                   sort:sortMenu(idx: idx),
                   editing:editMode(idx: idx),
                   searchShowing:searchShowing(idx: idx),
                   filterShowing:filterShowingPopover(idx:idx)
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
    var listSearchBinding: Binding<String> {
        store.binding { state in
            state.list.search
        } tag: { newValue in
                .update(.searchText(newValue))
        }
    }
    
    func detailSearchBinding(idx: Int) -> Binding<String> {
        store.binding { state in
            state.tabs[idx].search
        } tag: { newValue in
            .update(.searchText(newValue))
        }
    }
}
// list control bar
extension SceneView {
    var sortBinding: Binding<Sort> {
        store.binding { state in
            state.list.sort
        } tag: { newValue in
            .update(.sort(newValue)) //
        }
    }

    var editBinding: Binding<Bool> {
        store.binding { state in
            state.list.editing
        } tag: { newValue in
            .update(.edit)
        }
    }
    var searchShowingBinding: Binding<Bool> {
        store.binding { state in
            state.list.searching
        } tag: { newValue in
            .update(.search)//
        }
    }
    var filterShowingBinding: Binding<Bool> {
        store.binding { state in
            state.list.filtering
        } tag: { newValue in
            .update(.filter)
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
    var deletingDialog: Binding<Bool> {
        store.binding { state in
            switch state.dialog {
            case .deleteConfirm: return true
            default: return false
            }
        } tag: { newValue in
            if newValue {
                // set to this route
            } else {
                // set route to none
            }
            return .null //
        }
    }
    var addingTagPopover: Binding<Bool> {
        store.binding { state in
            switch state.popover {
                case .addTagToSelection, .addTagToFilter: return true
                default: return false
            }
        } tag: { newValue in
                .null
        }
    }
    var addingItemPopover: Binding<Bool> {
        store.binding { state in
            switch state.popover {
            case .addItemToSelection, .addItemToDetail: return true
                default: return false
            }
            
        } tag: { newValue in
                .null
        }
    }
    
}

// detail control bar
extension SceneView {
    func sortMenu(idx: Int) -> Binding<Sort> {
        store.binding { state in
            state.tabs[idx].sort
        } tag: { newValue in
            .update(.sort(newValue))
        }
    }

    func editMode(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].editing
        } tag: { newValue in
            .update(.edit)
        }
    }
    func searchShowing(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].searching
        } tag: { newValue in
            .update(.search) //
        }
    }
    func filterShowingPopover(idx: Int) ->  Binding<Bool> {
        store.binding { state in
            state.tabs[idx].filtering
        } tag: { newValue in
            .update(.filter)
        }
    }
}

extension SceneView {
  var dialogOn: Bool {
      if let _ = store.state.dialog {
          return true
      } else {
          return false
      }

  }
     
  
  var popoverOn: Bool {
      if let _ = store.state.popover {
          return true
      } else {
          return false
      }
  }
  
}
          




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView()
    }
}
