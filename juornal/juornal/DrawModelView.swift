import SwiftUI
import PencilKit

class DrawingPageViewModel: ObservableObject {
    @Published var gridStyle: GridStyle = .none
    @Published var canvasView = PKCanvasView()
    @Published var draggableItems: [DraggableItem] = []
    @Published var showImagePicker = false
    @Published var selectedImage: UIImage?
    @Published var textItems: [TextItem] = []

    func addImage(_ image: UIImage) {
        let item = DraggableItem(position: CGPoint(x: 100, y: 100), content: .image(image))
        draggableItems.append(item)
    }

    func addEmptyTextFrame() {
        let textItem = TextItem(id: UUID(), text: "")
        textItems.append(textItem)
    }

  
    }

struct TextItem: Identifiable {
    let id: UUID
    var text: String
}
