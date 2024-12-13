// DrawingPageView.swift
import SwiftUI
import PencilKit

struct DrawingPageView: View {
    @StateObject private var viewModel = DrawingPageViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Grid Background
                if viewModel.gridStyle == .dot {
                    DotGridView()
                } else if viewModel.gridStyle == .square {
                    SquareGridView()
                }
                
                // PencilKit Canvas directly on the grid
                PencilCanvasView(canvasView: $viewModel.canvasView)
                
                // Draggable Items
                ForEach(viewModel.draggableItems) { item in
                    DraggableItemView(item: item, viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Menu("Grid") {
                        Button("None") { viewModel.gridStyle = .none }
                        Button("Dot Grid") { viewModel.gridStyle = .dot }
                        Button("Square Grid") { viewModel.gridStyle = .square }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button(action: { viewModel.showImagePicker = true }) {
                        Image(systemName: "photo")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
//                    Button(action: {
//                        viewModel.addTextItem() // Adds a new text item with a frame
//                    }) {
//                        Image(systemName: "textformat")
//                    }
                    Button("sjbdjbwj", systemImage: "textformat") {
                        print("button pressed, add the item")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage, isCamera: false)
                .onDisappear {
                    if let image = viewModel.selectedImage {
                        viewModel.addImage(image)
                    }
                }
        }
    }
}


// MARK: - Preview
struct DrawingPageView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPageView()
    }
}

