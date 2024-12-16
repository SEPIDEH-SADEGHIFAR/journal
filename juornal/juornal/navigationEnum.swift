import Foundation

enum JournalNavigation: Hashable {
    case inputView
    case drawingView(entry: JournalEntry)
    
    static func ==(lhs: JournalNavigation, rhs: JournalNavigation) -> Bool {
        switch (lhs, rhs) {
        case (.inputView, .inputView):
            return true
        case (.drawingView(let entry1), .drawingView(let entry2)):
            return entry1.id == entry2.id // Assuming `JournalEntry` has an `id` property
        default:
            return false
        }
    }
}
