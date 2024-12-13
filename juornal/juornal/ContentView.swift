
import SwiftUI

struct ContentView: View {
    @State private var journalEntries: [JournalEntry] = []

    var body: some View {
        TabView {
            // Tab 1: Journal List
            JournalListView(journalEntries: $journalEntries)
                .tabItem {
                    Label("Journal", systemImage: "book.fill")
                }

            // Tab 2: Add New Entry
            JournalInputView(onSave: { newEntry in
                journalEntries.append(newEntry)
            })
            .tabItem {
                Label("Add", systemImage: "plus.circle.fill")
            }

            // Tab 3: Drawing View
                        DrawingPageView()
                            .tabItem {
                                Label("Draw", systemImage: "pencil.tip")
                            }
                    }
        .tabViewStyle(DefaultTabViewStyle()) // Ensures the tab bar is at the bottom
        
    }
}
#Preview {
    ContentView()
}
