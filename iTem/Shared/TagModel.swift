import Foundation
import CoreStore

class Tag: CoreStoreObject{  
    @Field.Stored("name")
    var name: String = ""
    
    @Field.Stored("emoji")
    var emoji: String = ""

    @Field.Stored("hue")
    var hue: Double = 0
    
    @Field.Stored("updated")
    var saturation: Double = 0
    
    @Field.Stored("brightness")
    var brightness: Double = 0
    
    @Field.Stored("id")
    var id: UUID = .init()
    
    @Field.Relationship("tags", inverse: \Tag.$items)
    var tags: Set<Tag>
}