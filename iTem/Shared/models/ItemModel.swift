import Foundation
import CoreStore
import CoreData

class Item: CoreStoreObject {

      @Field.Stored("text")
      var text: String = ""

      @Field.Stored("created")
      var createdAt: Date = .init()

      @Field.Stored("updated")
      var updatedAt: Date = .init()

      @Field.Stored("visited")
      var visitedAt: Date = .init()

      @Field.Stored("id")
      var id: UUID = .init()

      @Field.Relationship("children")
      var children: Array<Item>

      @Field.Relationship("parents", inverse: \.$children)
      var parents: Set<Item>

      @Field.Relationship("tags")
      var tags: Set<Tag>
}
