import SwiftUI
import PencilKit
import SwiftData

struct DrawingPageView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: DrawingPageViewModel
    var journalEntry: JournalEntry
    @State private var isEditingText: Bool = false
    @State private var toolPicker: PKToolPicker?
    @State private var canvasView: PKCanvasView = PKCanvasView()

    init(journalEntry: JournalEntry) {
        _viewModel = StateObject(wrappedValue: DrawingPageViewModel(journalEntry: journalEntry))
        self.journalEntry = journalEntry
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.gridStyle == .dot {
                    DotGridView()
                } else if viewModel.gridStyle == .square {
                    SquareGridView()
                }

                PencilCanvasView(canvasView: $canvasView)
                    .onAppear {
                        setupToolPicker()
                    }
                ForEach(viewModel.draggableItems) { item in
                                    DraggableItemView(item: item, viewModel: viewModel)
                                }

                ForEach(viewModel.textItems) { textItem in
                    EditableTextView(viewModel: viewModel, isEditingText: $isEditingText, textItem: textItem)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isEditingText = false
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        // Grid button
                        Menu("Grid") {
                            Button("None") { viewModel.gridStyle = .none }
                            Button("Dot Grid") { viewModel.gridStyle = .dot }
                            Button("Square Grid") { viewModel.gridStyle = .square }
                        }
                        .foregroundColor(Color(red: 150/255, green: 108/255, blue: 171/255))
                        // Photo button
                        Button(action: { viewModel.showImagePicker = true }) {
                            Image(systemName: "photo")
                        }
                        .foregroundColor(Color(red: 150/255, green: 108/255, blue: 171/255))
                        
                        // Text button
                        Button(action: { viewModel.addEmptyTextFrame() }) {
                            Image(systemName: "textformat")
                        }
                        .foregroundColor(Color(red: 150/255, green: 108/255, blue: 171/255))
                        // Pencil button
                                                Button(action: {
                                                   // toggleToolPicker() // Show/hide the tool picker
                                                }) {
                                                    Image(systemName: "pencil.tip")
                                                        .foregroundColor(Color(red: 150/255, green: 108/255, blue: 171/255))
                                                }
                                            }
                                        }
                                    }
                                
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage, isCamera: false)
            }
        }
    }

    private func setupToolPicker() {
        canvasView.becomeFirstResponder()
        if toolPicker == nil {
            toolPicker = PKToolPicker()
            toolPicker?.addObserver(canvasView)
        }
        toolPicker?.setVisible(true, forFirstResponder: canvasView)
    }
}
import SwiftUI

struct EditableTextView: View {
    @ObservedObject var viewModel: DrawingPageViewModel
    @Binding var isEditingText: Bool // Shared editing state
    var textItem: TextItem

    var body: some View {
        ZStack {
            if isEditingText && viewModel.isEditing(textItem) {
                // TextField to edit text
                TextField("", text: Binding(
                    get: { textItem.text },
                    set: { viewModel.updateText(for: textItem, with: $0) }
                ))
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 150, height: 30)
                .background(Color.white.opacity(0.5))
                .cornerRadius(5)
                .padding()
            } else {
                // Displaying text as static if not in edit mode
                Text(textItem.text.isEmpty ? "Double-click to edit" : textItem.text)
                    .foregroundColor(.black)
                    .frame(width: 150, height: 30, alignment: .center)
                    .background(Color.clear)
                    .onTapGesture(count: 2) {
                        viewModel.setEditing(textItem)
                        isEditingText = true
                    }
            }
        }
        .position(textItem.position)  // Position the text on the canvas
        .gesture(
            DragGesture()
                .onChanged { value in
                    viewModel.updatePosition(for: textItem, to: value.location)
                }
        )
    }
}
