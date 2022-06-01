//
//  SheetCorners.swift
//  iTem
//
//  Created by Dana Knowles on 5/31/22.
//

import Foundation
import SwiftUI

struct SheetCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
