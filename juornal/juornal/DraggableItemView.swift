import SwiftUI

struct DraggableItemView: View {
    @ObservedObject var viewModel: DrawingPageViewModel
    var item: DraggableItem

    @State private var position: CGPoint
    @State private var scale: CGFloat // For resizing

    init(item: DraggableItem, viewModel: DrawingPageViewModel) {
        self.item = item
        self.viewModel = viewModel
        _position = State(initialValue: item.position)
        _scale = State(initialValue: item.scale) // Initialize scale from item
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
                            .onChanged { value in
                                self.scale = value * item.scale // Incremental scaling
                            }
                            .onEnded { _ in
                                updateScaleInViewModel()
                            }
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
                        .onChanged { value in
                            self.scale = value * item.scale
                        }
                        .onEnded { _ in
                            updateScaleInViewModel()
                        }
                )
            }
        }
        .position(position)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.position = value.location
                    updatePositionInViewModel()
                }
        )
    }

    // Updates the scale in the ViewModel
    private func updateScaleInViewModel() {
        if let index = viewModel.draggableItems.firstIndex(where: { $0.id == item.id }) {
            viewModel.draggableItems[index].scale = scale
        }
    }

    // Updates the position in the ViewModel
    private func updatePositionInViewModel() {
        if let index = viewModel.draggableItems.firstIndex(where: { $0.id == item.id }) {
            viewModel.draggableItems[index].position = position
        }
    }
}
