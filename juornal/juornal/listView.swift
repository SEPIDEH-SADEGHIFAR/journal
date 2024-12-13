import SwiftUI

struct JournalListView: View {
    @Binding var journalEntries: [JournalEntry]
    
    // Define two column layout for LazyVGrid
    let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]

    var body: some View {
        ScrollView {
            // LazyVGrid for displaying journal entries in two columns
            LazyVGrid(columns: columns, spacing: 25) {
                ForEach(journalEntries) { entry in
                    JournalEntryView(entry: entry) // Custom view for each journal entry
                }
            }
            .padding()
        }
        .background(Color(red: 248/255, green: 246/255, blue: 206/255)) // Pastel yellow background
    }
}

// Preview for Journal List View
struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView(journalEntries: .constant([
            JournalEntry(emoji: "😀", title: "First Entry", description: "This is my first journal entry", date: Date(), coverImage: UIImage(named: "image1")),
            JournalEntry(emoji: "😊", title: "Second Entry", description: "This is my second journal entry", date: Date(), coverImage: UIImage(named: "image2")),
            JournalEntry(emoji: "😎", title: "Third Entry", description: "This is my third journal entry", date: Date(), coverImage: UIImage(named: "image3")),
            JournalEntry(emoji: "🥰", title: "Fourth Entry", description: "This is my fourth journal entry", date: Date(), coverImage: UIImage(named: "image4"))
        ]))
    }
}
