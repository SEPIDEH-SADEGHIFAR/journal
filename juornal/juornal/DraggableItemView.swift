import SwiftUI
struct DraggableItemView: View {
    @ObservedObject var viewModel: DrawingPageViewModel
    var item: DraggableItem

    @State private var position: CGPoint
    @State private var scale: CGFloat = 1.0 // For resizing text or image

    init(item: DraggableItem, viewModel: DrawingPageViewModel) {
        self.item = item
        self.viewModel = viewModel
        _position = State(initialValue: item.position)
    }

    var body: some View {
        Group {
            switch item.content {
            case .image(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in scale = value }
                    )
            case .text(let text):
                TextField("Enter text", text: Binding(
                    get: { text },
                    set: { newValue in
                        if let index = viewModel.draggableItems.firstIndex(where: { $0.id == item.id }) {
                            viewModel.draggableItems[index].content = .text(newValue)
                        }
                    }
                ))
                .padding(8)
                .background(Color.yellow.opacity(0.5))
                .cornerRadius(5)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in scale = value }
                )
            }
        }
        .position(position)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.position = value.location
                    if let index = viewModel.draggableItems.firstIndex(where: { $0.id == item.id }) {
                        viewModel.draggableItems[index].position = value.location
                    }
                }
        )
    }
}
