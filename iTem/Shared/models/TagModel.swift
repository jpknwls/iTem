import Foundation
import CoreStore
import SwiftUI

class Tag: CoreStoreObject{  
   @Field.Stored("name")
   var name: String = ""
   
   @Field.Stored("emoji")
   var emoji: String = ""
   
   @Field.Stored("hue")
   var hue: Double = 0
   
   @Field.Stored("saturation")
   var saturation: Double = 0
   
   @Field.Stored("brightness")
   var brightness: Double = 0
   
   @Field.Stored("id")
   var id: UUID = .init()

   @Field.Relationship("tags", inverse: \.$tags)
   var items: Set<Item>
    
    var color: Color {
        get {
            Color(hue: hue, saturation: saturation, brightness: brightness)
        }
        set {
            let (h, s, b) = newValue.hsb()
            self.hue = h
            self.brightness = b
            self.saturation = s
        }
    }
}

extension Color {
    func hsb() -> (Double, Double, Double) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (Double(hue), Double(saturation), Double(brightness))
    }
}

extension Tag {
    // bindings
}
