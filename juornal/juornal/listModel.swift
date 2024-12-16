import Foundation
import UIKit

struct JournalEntry: Identifiable, Hashable {
    var id: UUID
    var emoji: String
    var title: String
    var description: String
    var date: Date
    var coverImage: UIImage?
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // You can combine other properties as needed
    }

    // Equatable conformance (implicitly synthesized with hashable conformance)
    static func ==(lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        lhs.id == rhs.id
    }
}
