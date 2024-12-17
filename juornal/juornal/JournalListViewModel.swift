import SwiftUI
import SwiftData

class JournalListViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Published var journalEntries: [JournalEntry] = []

    

    func fetchJournalEntries() -> [JournalEntry] {
        return journalEntries
       do {
            // Create a FetchDescriptor for JournalEntry
           let fetchDescriptor = FetchDescriptor<JournalEntry>()
            
//            // Fetch the entries
          let entries = try modelContext.fetch(fetchDescriptor)
           journalEntries = entries
       } catch {
           print("Error fetching journal entries: \(error)")
        }
    }

    func saveJournalEntry(_ entry: JournalEntry) {
        journalEntries.append(entry)
        do {
            try modelContext.save()
            fetchJournalEntries()  // Refresh the list after saving
       } catch {
            print("Error saving journal entry: \(error)")
       }
    }
}
