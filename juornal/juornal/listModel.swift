import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    var emoji: String
    var title: String
    var description: String
    var date: Date
    var coverImage: UIImage?
}
