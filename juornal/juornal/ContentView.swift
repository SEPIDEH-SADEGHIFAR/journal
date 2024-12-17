import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .snappy) private var allJournals : [JournalEntry]
    @StateObject private var viewModel = JournalListViewModel()

    var body: some View {
        NavigationStack {
            JournalListView() // Pass Binding of journalEntries
                .navigationDestination(for: JournalNavigation.self) { destination in
                    switch destination {
                    case .inputView:
                        JournalInputView(onSave: { newEntry in
                            viewModel.saveJournalEntry(newEntry)
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
