//
//  NavigationBar.swift
//  iTem
//
//  Created by Dana Knowles on 5/11/22.
//

import Foundation
import SwiftUI


struct NavigationBar: View {
    /*
        data
        - routes
     */
    let route: TabState
    let tabs: [TabState]
    
    /*
        events
        -
     */
    
    let goTo: (UUID) -> ()
    let goHome: () -> ()
    let toggleNavExpanded: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                Text("Home")
                IconButton {
                    Image(systemName: "")
                } action: {
                    goHome()
                }
                ForEach(tabs, id: \.self) { tab in
                    
                }
                    //.border(isHome ? : )
                    //.shadow(isHome ? : )
                // homeButton.highlighted(route == .list)
                // forEach(tabs) { navCard(tab).highlighted(isAt(tab)) }
                
                Spacer()
                IconButton {
                    Image(systemName: "")
                } action: {
                    toggleNavExpanded()
                }

            }
        }
    }
 
    /*
        convenience
     
     */
    func navCard(route: Route) -> some View {
        switch route {
        case .list: return EmptyView()
        case .detail(let id): return EmptyView()
            // do we need to do a DB call here to fetch the name
            // should we just store some of the text heer
            
        }
    }
    var isHome: Bool { route == .list }
    func isAt(_ tab: Route) -> Bool { route == tab }
    
}
