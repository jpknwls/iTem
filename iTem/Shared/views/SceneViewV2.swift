//
//  SceneViewV2.swift
//  iTem
//
//  Created by Dana Knowles on 5/29/22.
//

import Foundation
import SwiftUI
import ObservableStore

/*
    state
        screen state (navigation, view heights, overlay status)
                        
                        spaceView
                            - headerHeight
                            - viewHeight is flexible based on library status
                    
                        libraryView
                            - state: [.full, .half, .closed]
                                -> switch state -> height:CGFloat
                            - offset
                                -> onDrag -> dragHeight
                                
                        findView
 
 
 
 
                    ////
                        focusView
 
                        filterView
                
 
 
        gesture state
        search and filter state
        selection state
        
        
 
    views
        splitView
            space
                header (tabs)
                canvas
            library
                itemList
    
         findView
         
         overlayView
            focus (full screen media editing
                text, audio, image, web,
 
            filter
                dateSelector (slider)
                tagPicker (
                typeMenuPicker
                sortMenuPicker

 
 */

/*
 
    ZStack
        main
            ZStack
                space
                    -> zoomable
                    -> scrollable (2 finger?)
                    -> rotatable
                    -> draggable items (1 finger)
                    -> rotatable items
                    -> pressable items
                    -> selectable (drag) ... (1 finger?)
                    
                controls
                    nav
                        -> swipable (change space)
                        -> triggers
                    library
                        -> swipable (change tab)
                        -> draggable items
                        -> triggers (items)
                        
                    Spacer()
                    search/filter
                        -> text
                        -> triggers
        popover
            
            add
                -> triggers (grid of icons)
            focus
                -> ... misc editing
            filter
                -> slider (date)
                -> wall of toggles (tags)
                -> grid of toggles (types)
            tabs
                -> triggers (list of
            
 
            
 
 */


// helpers
enum SheetPosition {
    case collapsed
    case compact
    case expanded
}

enum TabPosition {
    case space
    case spaces
    case items
    case selection
    
}

// intents
enum IntentsV2 {
    case event(EventIntent)
    case update(UpdateIntent)
    case create(CreateIntent)
    case delete(DeleteIntent)
}

enum EventIntent {
    case startAdding
}

enum CreateIntent {
    case item
    case space
    case tag
    case window //an open space
}

enum UpdateIntent {
    case search(String)
    case focus(Bool)
    case tab(TabPosition)
    case sheet(SheetPosition)
    case space
}

enum DeleteIntent {
    case item(UUID)
    case tag(UUID)
}

// State
struct SceneV2Snapshot: Equatable {
    // space state
    
    // focus state
    var focusOn: Bool = true
    
    // sheet state
    var sheetPosition: SheetPosition = .collapsed
        // sheet offset?
    var tabPosition: TabPosition = .space
    var searchText: String = ""
    var openSpaces: [String] = []
    var currentSpace: Int = 0
    
}

// Bindings
extension SceneViewV2 {
    var searchText$: Binding<String> {
        store.binding { state in
            state.searchText
        } tag: { newValue in
            .update(.search(newValue))
        }
    }
    var focusOn$: Binding<Bool> {
        store.binding { state in
            state.focusOn
        } tag: { newValue in
            .update(.focus(newValue))
        }
    }
    var tabPosition$: Binding<TabPosition> {
        store.binding { state in
            state.tabPosition
        } tag: { newValue in
            .update(.tab(newValue))
        }
    }
}

struct SceneViewV2: View {
    @StateObject var store = Store(update: SceneV2Snapshot.update, state: SceneV2Snapshot(), environment: Services())
    @State var offset: CGFloat = 0


    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            SpaceView()
                .edgesIgnoringSafeArea(.all)
                .opacity(1-getBlurRadius())
            //.blur(radius: getBlurRadius())
            
            ControlView(offset: $offset, searchText: searchText$, tabPosition: tabPosition$)
        
            FocusView(isOn: focusOn$)
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress / 2
    }
}

struct SpaceView: View {
    // let next: () -> ()
    // let back: () -> ()
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
            }
            Spacer()
        }
        .background( BlurView(style: .systemThickMaterialDark))
    }
}



struct ControlView: View {
    // keyboard
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    // Gesture state
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @Binding var offset: CGFloat

    @Binding var searchText: String
    @Binding var tabPosition: TabPosition


    @State var state: SheetPosition = .collapsed
    
    let collapsedHeight: CGFloat = 100.0
    //let compactHeight: CGFloat =
    
    
    var heightState: CGFloat {
        switch state {
        case .collapsed: return collapsedHeight
        case .compact: return 0
        case .expanded: return 0
        }
    }
    
    var body: some View {
    GeometryReader { proxy -> AnyView in
        let height = proxy.frame(in: .global).height
        return AnyView(
            ZStack {
                BlurView(style: .systemThinMaterialDark)
                    .clipShape(SheetCorner(corners: [.topLeft, .topRight], radius: 30))
                VStack {

                    Capsule()
                        .fill(Color.white)
                        .frame(width: 60, height: 4)
                        .padding(.top)
                    // nav bar
                        // space.name
                        // space.info (# children, created?)
                        // forward and next on swipe or tab, press to open all
                    NavBar()
                        .padding(.horizontal)
                        .foregroundColor(Color.white)
                
                        
                    TabBar(active: $tabPosition)
                    
                    // tabs
                    ScrollView(.vertical, showsIndicators: false ){
                        VStack {
                           // tabs
                        }
                    }
                    // pin to bottom
                    Spacer()
                    FilterView()
                    SearchFieldV2(text: $searchText)
                        .padding([.bottom])
                }
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment: .top)
            }
                .offset(y: height - 100 - self.keyboardHeightHelper.keyboardHeight)
                .offset(y: -offset > 0 ?
                            -offset <= (height - 100) ?
                        offset : -(height-100) :  0)
                .gesture(DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onDragChange()
                    })
                        .onEnded({ value in
                            let maxHeight = height - 100
                            withAnimation(.spring()) {
                                if -offset > 100 && -offset < maxHeight / 2 {
                                    offset = (-maxHeight / 3)
                                }
                                else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                }
                                else {
                                    offset = 0
                                }
                            }
                            lastOffset = offset
                        })
                
                        )
            )
        }.ignoresSafeArea(.all, edges: .bottom)
    }
    
    func onDragChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
}


struct FilterView: View {
    var body: some View {
        VStack {
            HStack {
                    Text("Filter")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                        Text("See All")
                            .fontWeight(.bold)
                    .foregroundColor(.gray)})
            }
            Divider()
                .background(Color.white)
                
            
            
            
        }
    }
}


struct NavBar: View {
    var body: some View {
        HStack {
            Image(systemName: Icon.back)
            Spacer()
            Text("Space 3")
                .fontWeight(.medium)
                .font(.title2)
            Spacer()
            Image(systemName: Icon.next)
        }
    }
}


struct TabBar: View {
    @Binding var active: TabPosition
    var body: some View {
        HStack {
            HStack {
                Image(systemName: Icon.space)
                if active == .space {Text("Current") }
            }
                .padding(5)
                .background(getCapsule().opacity(active == .space ? 0.7 : 0.0))
                .padding(.horizontal, 3)
                .imageScale(.large)
                .frame(height: 44)
                .contentShape(Rectangle())
                .onTapGesture {
                    active = .space
                }
            Spacer()
            HStack {
                Image(systemName: Icon.spaces)
                if active == .spaces {Text("Open") }
            }
                .padding(5)
                .background(getCapsule().opacity(active == .spaces ? 0.7 : 0.0))
                .padding(.horizontal, 3)
                .imageScale(.large)
                .frame(height: 44)
                .contentShape(Rectangle())
                .onTapGesture {
                    active = .spaces
            }
            Spacer()

            HStack {
                Image(systemName: Icon.items)
                if active == .items {Text("Library") }
            }
                .padding(5)
                .background(getCapsule().opacity(active == .items ? 0.7 : 0.0))
                .padding(.horizontal, 3)
                .imageScale(.large)
                .frame(height: 44)
                .contentShape(Rectangle())
                .onTapGesture {
                    active = .items
                }
            Spacer()

            HStack {
                Image(systemName: Icon.selection)
                if active == .selection { Text("Selection") }
            }
                .padding(5)
                .background(getCapsule().opacity(active == .selection ? 0.7 : 0.0))
                .padding(.horizontal, 3)
                .imageScale(.large)
                .frame(height: 44)
                .contentShape(Rectangle())
                .onTapGesture {
                    active = .selection
                }
        }
    }
    
    @ViewBuilder
    func getCapsule() -> some View {
        Capsule().foregroundColor(.green)
    }
}


//
struct FocusView: View {
    @Binding var isOn: Bool
    @State var text: String = "Type here..."
    
    var body: some View {
        if isOn {
            //
            ZStack(alignment:.topTrailing) {
                BlurView(style: .systemChromeMaterialLight).foregroundColor(.yellow)
                    .ignoresSafeArea()
                TextEditor(text: $text)
                    .keyboardType(.twitter)
                    .padding(.vertical, 30)
                Button {
                    withAnimation(.spring()) {
                        isOn = false
                    }
                } label: {
                    Image(systemName: Icon.clear)
                        .imageScale(.large)
                        .padding()
                }
                .padding(.vertical, 30)
                .padding(.horizontal)

            }
            
            
        } else {
            EmptyView()
        }
        
    }
}
