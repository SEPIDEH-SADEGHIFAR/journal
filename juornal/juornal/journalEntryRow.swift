import SwiftUI

// Custom view for each journal entry
struct JournalEntryView: View {
    var entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Emoji section
            Text(entry.emoji)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Title section
            Text(entry.title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Description section
            Text(entry.description)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3) // Limit description to 3 lines for better consistency
                .frame(maxWidth: .infinity, alignment: .leading)

            // Date section
            Text(entry.date, style: .date)
                .font(.footnote)
                .foregroundColor(.gray)

            // Image section
            if let image = entry.coverImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 270, height: 230)
                    .clipped()
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
        .padding()
        .frame(maxWidth: .infinity) // Ensure the view takes up the full width
        .background(Color.white) // Background color for each entry (rectangle)
        .cornerRadius(12)
        .shadow(radius: 5) // Add shadow for card-style look
    }
}
