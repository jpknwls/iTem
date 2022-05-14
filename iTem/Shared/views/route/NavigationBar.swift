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
    let route: Route
    let tabs: [DetailContent] // could just be an array of strings
    
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
                if route != .list {
                    IconButton {
                        Image(systemName: Icon.home)
                    } action: {
                        goHome()
                    }
                }
                ForEach(tabs, id: \.id) { tab in
                    
                }
                    //.border(isHome ? : )
                    //.shadow(isHome ? : )
                // homeButton.highlighted(route == .list)
                // forEach(tabs) { navCard(tab).highlighted(isAt(tab)) }
                
                Spacer()
                IconButton {
                    Image(systemName: Icon.expand)
                } action: {
                    toggleNavExpanded()
                }

            }
            .padding()
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
