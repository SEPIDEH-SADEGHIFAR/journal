import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JournalListViewModel()

    var body: some View {
        NavigationStack {
            JournalListView(journalEntries: $viewModel.journalEntries) // Pass Binding of journalEntries
                .navigationDestination(for: JournalNavigation.self) { destination in
                    switch destination {
                    case .inputView:
                        JournalInputView(onSave: { newEntry in
                            viewModel.addEntry(newEntry)
                        })
                    case .drawingView(let entry):
                        DrawingPageView(journalEntry: entry) // Pass JournalEntry directly
                    }
                }
        }
    }
}
#Preview {
    ContentView()
}