import SwiftUI

struct TagCard: View {
    let emoji: String?
    let name: String?
    let color: Color
    var body: some View {
        HStack {
            if let emoji = emoji {
                Text(emoji)
            }
            if let name = name {
                Text(name)
                    .bold()
                    .lineLimit(1)
            }
        }
        .font(.caption)
        .foregroundColor(.white)
        .padding(6.0)
        .background(
            ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(color.opacity(0.2))
                        
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(color.opacity(0.4))
                .padding(3.0)
            }
                .shadow(color: color, radius: 3.0, x: 3.0, y: 3.0)
        )
        
    }
}

struct TagData: Identifiable, Hashable {
    let id: UUID = .init()
    let emoji: String?
    let name: String?
    let color: Color
}

/*
 - text
 - tags
 - created
 - links?
 - backlinks?
 url?
 */

struct ItemCard: View {
    let text: String
    let created: Date
    let tags: [TagData]
    
    @State var isSelected: Bool = false
    
    @GestureState var isDetectingPress = false
    @State var isPressed = false
    
    var dateFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateStyle = .medium
        return format
    }
    var timeFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateStyle = .medium
        return format
    }
    var longPress: some Gesture {
         LongPressGesture(minimumDuration: 1)
            .updating($isDetectingPress) { currentState, gestureState,
                     transaction in
                 gestureState = currentState
                print("updating")
                 //transaction.animation = Animation.easeIn(duration: 1.0)
             }
             .onEnded { finished in
                 self.isPressed = finished
             }
    }
    
    var body: some View {
        
        HStack {
            VStack {
                HStack {
                    Text(text).bold().lineLimit(2)
                        
                    Spacer()
                    Text(dateFormatter.string(from: created))
                        .font(.caption2)
                }
                HStack {
                        
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tags) {
                                tag in
                                TagCard(emoji: tag.emoji, name: tag.name, color: tag.color)
                                    .padding([.top, .bottom], 3.0)
                            }
                        }
                    }
                }
            }
            
            Image(systemName: isSelected ? "chevron.right.2" : "chevron.right")
                .shadow(color: .black, radius: isSelected ? 10.0 : 0, x: 0.0, y: 0.0)

        }
        .onTapGesture {
            isSelected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) {
                    isSelected = false
                }
            }
        }
        //.gesture(longPress)
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).opacity(0.3)
                RoundedRectangle(cornerRadius: 10.0).opacity(isSelected ? 0.6 : 0.1).padding(6.0)
                    .shadow(color: .gray, radius: isSelected ? 10.0 : 0.0, x: 0.0, y: 3.0)
            }
            .foregroundColor(self.isDetectingPress ?
                             Color.gray.opacity(0.8) :
                                (self.isPressed ? Color.gray.opacity(1.5) : Color.gray))
                
        )
    }
}

struct Card_Previews: PreviewProvider {
    
    static let tags = [TagData(emoji: "", name: "", color: .blue)]
    
    static var previews: some View {
        ItemCard(text: "this is a test item", created: Date.init(), tags: tags)
    }
}
