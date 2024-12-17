import SwiftUI
import SwiftData

struct JournalListView: View {
    @Query(animation: .snappy) private var allJournals : [JournalEntry]
    @StateObject private var viewModel = JournalListViewModel()

    let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]

    @State private var isAddingNewEntry = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(allJournals) { entry in
                        NavigationLink(destination: DrawingPageView(journalEntry: entry)) {
                            JournalEntryView(entry: entry)
                        }
                    }
                }
                .padding()
            }
            .background(Color(red: 248/255, green: 246/255, blue: 206/255))
            .navigationTitle("Your Journals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingNewEntry.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(Color(red: 150/255, green: 108/255, blue: 171/255))
                    }
                }
            }
            .sheet(isPresented: $isAddingNewEntry) {
                JournalInputView(onSave: { newEntry in
                    viewModel.saveJournalEntry(newEntry)
                    isAddingNewEntry = false
                })
            }
        }
    }
}
