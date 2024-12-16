import SwiftUI

class JournalListViewModel: ObservableObject {
    @Published var journalEntries: [JournalEntry] = []
    @Published var showInputView: Bool = false
    @Published var selectedEntry: JournalEntry?

    func addEntry(_ entry: JournalEntry) {
        journalEntries.append(entry)
        showInputView = false
    }
}
