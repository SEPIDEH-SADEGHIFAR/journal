import SwiftUI

struct JournalListView: View {
    @Binding var journalEntries: [JournalEntry]

    let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]

    // To present the JournalInputView when the plus button is tapped
    @State private var isAddingNewEntry = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(journalEntries) { entry in
                        NavigationLink(destination: DrawingPageView(journalEntry: entry)) {
                            JournalEntryView(entry: entry) // Custom view for each journal entry
                        }
                    }
                }
                .padding()
            }
            .background(Color(red: 248/255, green: 246/255, blue: 206/255)) // Pastel yellow background
            .navigationTitle("Journal List")
            .toolbar {
                // Add a plus button to the navigation bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Set the flag to show the JournalInputView when the plus button is tapped
                        isAddingNewEntry.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
            }
            .sheet(isPresented: $isAddingNewEntry) {
                // Show the JournalInputView when isAddingNewEntry is true
                JournalInputView(onSave: { newEntry in
                    journalEntries.append(newEntry)
                    isAddingNewEntry = false // Dismiss the sheet after saving
                })
            }
        }
    }
}



// Preview for Journal List View
/*struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView(journalEntries: .constant([
            JournalEntry(emoji: "😀", title: "First Entry", description: "This is my first journal entry", date: Date(), coverImage: UIImage(named: "image1")),
            JournalEntry(emoji: "😊", title: "Second Entry", description: "This is my second journal entry", date: Date(), coverImage: UIImage(named: "image2")),
            JournalEntry(emoji: "😎", title: "Third Entry", description: "This is my third journal entry", date: Date(), coverImage: UIImage(named: "image3")),
            JournalEntry(emoji: "🥰", title: "Fourth Entry", description: "This is my fourth journal entry", date: Date(), coverImage: UIImage(named: "image4"))
        ]))
    }
}
*/
