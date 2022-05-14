//
//  HorizontalScrollBar.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import SwiftUI

struct HorizontalScrollContainer<Content: View>: View {
    let content: () -> Content
    let showsIndicators = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: showsIndicators) {
          content()
        }
    }
}
