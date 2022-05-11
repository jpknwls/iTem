import Foundation
import CoreStore

class Item: CoreStoreObject {
    @Field.Stored("text")
    var text: String = ""

    @Field.Stored("created")
    var createdAt: Date = .init()
    
    @Field.Stored("updated")
    var updatedAt: Date = .init()
    
    @Field.Stored("id")
    var id: UUID = .init()

/*
    @Field.Stored("text")
    var text: String = ""
    
    @Field.Stored("text")
    var text: String = ""
 */
  
    
    
    //relationships
    @Field.Relationship("children", inverse: \Tag.$backlinks)
    var items: Array<Item>
    
    @Field.Relationship("backlinks", inverse: \Tag.$items)
    var backlinks: Set<Item>

    
    @Field.Relationship("tags", inverse: \Tag.$items)
    var tags: Set<Tag>
}

