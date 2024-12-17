import SwiftUI

struct TextItemView: View {
    @State private var isEditing = false
    @State private var text: String
    @State private var dragOffset = CGSize.zero
    let textItem: TextItem
    let onTextUpdate: (String) -> Void
    let onPositionUpdate: (CGPoint) -> Void

    init(textItem: TextItem, onTextUpdate: @escaping (String) -> Void, onPositionUpdate: @escaping (CGPoint) -> Void) {
        self.textItem = textItem
        self.onTextUpdate = onTextUpdate
        self.onPositionUpdate = onPositionUpdate
        self._text = State(initialValue: textItem.text)
    }

    var body: some View {
        ZStack {
            if isEditing {
                TextField("", text: $text)
                    .textFieldStyle(.plain)
                    .font(.system(size: 18))
                    .onSubmit {
                        onTextUpdate(text) // Update the text and hide the frame
                        isEditing = false // Hide the frame
                    }
            } else {
                Text(text.isEmpty ? "Double-click to edit" : text)
                    .foregroundColor(text.isEmpty ? .gray : .primary)
                    .font(.system(size: 18))
                    .onTapGesture(count: 2) {
                        isEditing = true // Show text field when double clicked
                    }
            }
        }
        .frame(width: 200, height: 50)
        
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    // Update the text item's position when dragging ends
                    
                    
                    dragOffset = .zero
                }
        )
        .border(isEditing ? Color.gray : Color.clear, width: 1) // Show the border only when editing
    }
}
import Foundation
import SwiftUI

// Define the TextItem struct
struct TextItem: Identifiable {
    let id: UUID
    var text: String
    var position: CGPoint
    
    // Custom initializer for TextItem
    init(id: UUID = UUID(), text: String = "", position: CGPoint = .zero) {
        self.id = id
        self.text = text
        self.position = position
    }
}
