import SwiftUI
import PencilKit

struct DrawingPageView: View {
    @StateObject private var viewModel: DrawingPageViewModel
    var journalEntry: JournalEntry
    @State private var isEditingText: Bool = false // Track if any text field is being edited
    
    // Init method to pass the journalEntry to the view model
    init(journalEntry: JournalEntry) {
        _viewModel = StateObject(wrappedValue: DrawingPageViewModel(journalEntry: journalEntry))
        self.journalEntry = journalEntry
    }
    
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
                
                // Correctly order arguments in EditableTextView
                ForEach(viewModel.textItems) { textItem in
                    EditableTextView(
                        viewModel: viewModel, // First: ViewModel
                        isEditingText: $isEditingText, // Second: Binding to editing state
                        textItem: textItem // Third: Text item
                    )
                }
                
            }
            .contentShape(Rectangle()) // Ensure taps outside text fields are detected
            .onTapGesture {
                isEditingText = false // Dismiss editing mode on tap outside
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

// MARK: - EditableTextView
struct EditableTextView: View {
    @ObservedObject var viewModel: DrawingPageViewModel
    @Binding var isEditingText: Bool // Shared editing state
    var textItem: TextItem
    
    var body: some View {
        ZStack {
            if isEditingText && viewModel.isEditing(textItem) {
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
        .position(textItem.position)
        .gesture(
            DragGesture()
                .onChanged { value in
                    viewModel.updatePosition(for: textItem, to: value.location)
                }
        )
    }
}

// MARK: - Preview
struct DrawingPageView_Previews: PreviewProvider {
    static var previews: some View {
        // Pass a mock JournalEntry to the preview
        DrawingPageView(journalEntry: JournalEntry( id: UUID(), emoji: "😊", title: "Test Entry", description: "This is a description", date: Date(), coverImage: nil))
    }
}
