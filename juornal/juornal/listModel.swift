import Foundation
import SwiftData

@Model
class JournalEntry: Identifiable {
    
    @Attribute(.unique) var id: UUID
     var emoji: String
     var title: String
    var entryDescription: String // Renamed to avoid conflict with system 'description'
     var date: Date
    
    // Optional field for storing image data
     var coverImage: Data? // Store image as Data (binary format)
    
    // Custom initializer to create a JournalEntry instance
    init(id: UUID = UUID(), emoji: String, title: String, entryDescription: String, date: Date, coverImage: Data? = nil) {
        self.id = id
        self.emoji = emoji
        self.title = title
        self.entryDescription = entryDescription
        self.date = date
        self.coverImage = coverImage
    }
}
