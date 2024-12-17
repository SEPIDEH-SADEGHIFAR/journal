import SwiftUI
import PencilKit
import SwiftData


class DrawingPageViewModel: ObservableObject {
    
    @Published var gridStyle: GridStyle = .none
    @Published var canvasView = PKCanvasView()
    @Published var draggableItems: [DraggableItem] = []
    @Published var showImagePicker = false
    @Published var selectedImage: UIImage?
    @Published var textItems: [TextItem] = []
    @Published var currentlyEditing: UUID? // Track which text item is being edited

    let journalEntry: JournalEntry

    init(journalEntry: JournalEntry) {
        self.journalEntry = journalEntry
    }

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

    func saveDrawing() {
        // Save the drawing to model context (optional)
        // Example: You could save the canvas image or drawing data here if needed
    }
}
