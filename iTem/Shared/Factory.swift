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
                    .padding([.trailing], 4.0)
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
        )
        .shadow(color: color, radius: 3.0, x: 3.0, y: 3.0)
    }
}

struct TagData: Identifiable {
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
    
    var dateFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateFormat = "M/dd/yy"
        return format
    }
    var timeFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateFormat = "h:m"
        return format
    }
    var body: some View {
        VStack {
            HStack {
                Text(text).lineLimit(1)
                Image(systemName: isSelected ? "arrowtriangle.right.circle.fill": "arrowtriangle.right.circle")
                
                    .shadow(color: .white, radius: 5.0, x: 0.0, y: 0.0)
                    .onTapGesture {
                        isSelected = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                isSelected = false
                            }
                        }
                    }
            }
            HStack {
                    Text(dateFormatter.string(from: created))
                        .font(.caption2)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tags) {
                            tag in
                            TagCard(emoji: tag.emoji, name: tag.name, color: tag.color)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).opacity(0.4)
                RoundedRectangle(cornerRadius: 10.0).opacity(isSelected ? 0.6 : 0.1).padding(6.0)
            }.foregroundColor(.blue)
                .shadow(color: .blue, radius: isSelected ? 10.0 : 0.0, x: 3.0, y: 3.0)
        )
    }
}
