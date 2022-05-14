import Foundation
import CoreStore
import SwiftUI

struct Database {
    static let dataStack: DataStack = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<Item>("Item"),
                    Entity<Tag>("Tag")
                ]
            )
        )
        
        /**
         - Important: `addStorageAndWait(_:)` was used here to simplify initializing the demo, but in practice the asynchronous function variants are recommended.
         */
        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "Modern.ColorsDemo.sqlite",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )
        return dataStack
    }()
    
    //// delete
    func deleteItems(incomingIDs: Set<UUID>) {
        Database.dataStack.perform(asynchronous: { transaction in
            var ids: [Item.ObjectID] = []
            for id in incomingIDs {
                if let object = try transaction.fetchOne(From<Item>(), Where<Item>(getIDPredicate(id: id))) {
                    ids.append(object.objectID())
                }
            }
            transaction.delete(objectIDs: ids)
        }, completion: {_ in })
    }
    
    func deleteTags(incomingIDs: Set<UUID>) {
        Database.dataStack.perform(asynchronous: { transaction in
            var ids: [Item.ObjectID] = []
            for id in incomingIDs {
                if let object = try transaction.fetchOne(From<Tag>(), Where<Tag>(getIDPredicate(id: id))) {
                    ids.append(object.objectID())
                }
            }
            transaction.delete(objectIDs: ids)
        }, completion: {_ in })
    }
    // item
    //// create
    func createItem(text: String?, links: Set<UUID>?, tags: Set<UUID>?) -> UUID? {
        var itemID: UUID? = nil
        Database.dataStack.perform(asynchronous: { transaction  in
            let item = transaction.create(Into<Item>())
            // set properties
            if let text = text {
                item.text = text
            } 
            if let links = links {
                for link in links {
                    let fetch = NSPredicate(format: "%K == %@", "id", link as CVarArg)
                    if let dbLink = try Database.dataStack.fetchOne(
                        From<Item>(),
                        Where<Item>(fetch))
                    {
                        item.children.append(dbLink)
                    }
                }
            }
            if let tags = tags {
                for tag in tags {
                    let fetch = NSPredicate(format: "%K == %@", "id", tag as CVarArg)
                    if let dbLink = try Database.dataStack.fetchOne(
                        From<Tag>(),
                        Where<Tag>(fetch))
                    {
                        item.tags.insert(dbLink)
                    }
                }
            }
            
            itemID = item.id
            
        },  completion:{_ in })
        return  itemID
    }
    
    //// addTo

    // tag
    //// create
    func createTag(name: String?, emoji: String?, color: Color?) -> UUID? {
        var tagID: UUID? = nil
        Database.dataStack.perform(asynchronous: { transaction in
            let tag = transaction.create(Into<Tag>())
            if let name = name {
                tag.name = name
            }
            if let emoji = emoji {
                tag.emoji = emoji
            }
            if let color = color {
                let (h, s, b) = color.hsb()
                tag.hue = h
                tag.saturation = s
                tag.brightness = b
            }
            
        }) { _ in }
        return tagID
    }
    
    func addTagToItem(tag: UUID, item: UUID) {
        Database.dataStack.perform(asynchronous: { transaction in
            do {
                if let tag = try transaction.fetchOne(From<Tag>(), Where<Tag>(getIDPredicate(id: tag))), 
                    let item = try transaction.fetchOne(From<Item>(), Where<Item>(getIDPredicate(id: item))) {
                        item.tags.insert(tag)
                }
            } catch(let error) {
                
            } 
        }, completion: { _ in })
    }
    
    func addItemToItem(this: UUID, to that: UUID) {
        Database.dataStack.perform(asynchronous: { transaction in
            do {
                if let _this = try transaction.fetchOne(From<Item>(), Where<Item>(getIDPredicate(id: this))), 
                    let _that = try transaction.fetchOne(From<Item>(), Where<Item>(getIDPredicate(id: that))) {
                        _that.children.append(_this)
                }
            } catch(let error) {
            
            } 
        }, completion: { _ in })
    }
    
    
    private func getIDPredicate(id: UUID) -> NSPredicate {
        NSPredicate(format: "%K == %@", "id", id as CVarArg)
    }
    
}


// list and detail publishers
extension Database {
    func getItemListPublisher() -> ListPublisher<Item> {
        return Database.dataStack.listPublisher(
            From<Item>()
                // .sectionBy(\.age") { "Age \($0)" } // sections are optional
                //.where(\.title == "Engineer")
                // .orderBy(.ascending(\.lastName))
        )
        
        //listPublisher.quer
    }
  
    
}

/*
 
 
 corestore swiftui

 object
 
 1. create publisher
 let objectPublisher: ObjectPublisher<Person> = person.asPublisher(in: dataStack)

2. pass to view
 
 
 let entity: ObjectPublisher<MyEntity>

 var body: some View {
    ObjectReader(self.person) { objectSnapshot in
        // ...
    }
    .animation(.default)
 }
 
 
 
 list
 
 let people: ListPublisher<Person>

 var body: some View {
     ListReader(self.people, keyPath: \.count) { count in
         Text("Number of members: \(count)")
     }
 }
 
 .onChange(fetchParameter {
 try people.refetch(
        From<Person>()
            .where(\.something > 10000)
            .orderBy(.ascending(\.somethingElse))
}
 
 
 */
