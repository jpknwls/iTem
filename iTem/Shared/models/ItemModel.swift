import Foundation
import CoreStore
import CoreData

class Item: CoreStoreObject {
      @Field.Stored("id")
      var id: UUID = .init()
    
      @Field.Stored("created")
      var createdAt: Date = .init()

      @Field.Stored("updated")
      var updatedAt: Date = .init()

        // this may be unnecessary...unless we want to update this on "Focus:open"
      @Field.Stored("visited")
      var visitedAt: Date = .init()

        // we set this to the current date when we select it, to mark that it has been selected at a certain time
        // we can deselect it by setting it to nil
      @Field.Stored("selected")
      var selected: Date? = nil

      @Field.Relationship("children")
      var children: Array<Item>

      @Field.Relationship("parents", inverse: \.$children)
      var parents: Set<Item>

      @Field.Relationship("tags")
      var tags: Set<Tag>
    
    
    
      @Field.Stored("media")
      var media: MediaType = .text
    
      @Field.Stored("text")
      var text: String?
    
      @Field.Stored("url")
      var url: URL?
  
    
    
    var data: MediaTypeData {
        switch media {
        case .text:
            return .text(text ?? "")
        default: return .text("")
        }
    }

}


enum MediaType: String {

    case text = "text"
    case audio = "audio"
    case file = "file"
    case web = "web"
    case music = "music"
    case podcast = "podcast"
    case date = "date"
    case reference = "reference"
}

enum MediaTypeData {

    case text(String)
    case audio(URL)
    case file(URL)
    case web(URL)
    case music(URL)
    case podcast(URL)
    case date(Date)
    
    case reference(UUID)
        //or relationship?
}

extension MediaType: FieldStorableType {
    
    static func cs_fromFieldStoredNativeType(_ value: String) -> MediaType {
        MediaType(rawValue: value) ?? .text
    }
    
    func cs_toFieldStoredNativeType() -> Any? {
        rawValue
    }
    
    typealias FieldStoredNativeType = String
}
