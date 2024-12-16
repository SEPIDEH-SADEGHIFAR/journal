import SwiftUI
import PencilKit

// MARK: - ViewModel
class DrawingPageViewModel: ObservableObject {
    @Published var gridStyle: GridStyle = .none
    @Published var canvasView = PKCanvasView()
    @Published var draggableItems: [DraggableItem] = []
    @Published var showImagePicker = false
    @Published var selectedImage: UIImage?
    @Published var textItems: [TextItem] = []
    @Published var currentlyEditing: UUID? // Track which text item is being edited

    func addImage(_ image: UIImage) {
        let item = DraggableItem(position: CGPoint(x: 100, y: 100), content: .image(image))
        draggableItems.append(item)
    }

    func addEmptyTextFrame() {
        let textItem = TextItem(id: UUID(), text: "", position: CGPoint(x: 100, y: 100))
        textItems.append(textItem)
    }

    func updateText(for textItem: TextItem, with newText: String) {
        if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
            textItems[index].text = newText
        }
    }

    func updatePosition(for textItem: TextItem, to newPosition: CGPoint) {
        if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
            textItems[index].position = newPosition
        }
    }

    func setEditing(_ textItem: TextItem) {
        currentlyEditing = textItem.id
    }

    func isEditing(_ textItem: TextItem) -> Bool {
        currentlyEditing == textItem.id
    }
}

// MARK: - TextItem
struct TextItem: Identifiable {
    let id: UUID
    var text: String
    var position: CGPoint
}
