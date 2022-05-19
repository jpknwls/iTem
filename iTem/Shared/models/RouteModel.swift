//
//  RouteModel.swift
//  iTem
//
//  Created by Dana Knowles on 5/13/22.
//

import Foundation
import SwiftUI

enum Route: Equatable {
    case list
    case detail(Int) // tab number
    //case focus
}


// pass in parameters here
enum Dialog: Equatable {
    case deleteConfirm
    case addTag
    case focusText(Binding<String>) //
}

// pass in parameters here
enum Popover: Equatable {
    case navExpand
    case filterExpand
    case selectionExpand
    case addTagToFilter
    case addTagToSelection
    case addItemToSelection
    case addItemToDetail
}
