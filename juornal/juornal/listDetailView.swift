import SwiftUI
import UIKit

struct JournalInputView: View {
    @Environment(\.modelContext) private var context
    @State private var emoji: String = ""
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker: Bool = false // Control the visibility of the date picker
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var isCamera: Bool = false // Flag to toggle between camera and photo library

    var onSave: (JournalEntry) -> Void

    var body: some View {
        VStack {
            Text("New Journal")
                .font(.largeTitle)
                .bold()
                .padding()

            Form {
                // Emoji Section
                Section(header: Text("Add Emoji")) {
                    TextField("Enter an emoji", text: $emoji)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .keyboardType(.default) // Ensure the emoji keyboard can be used
                }

                // Title Section
                Section(header: Text("Title")) {
                    TextField("Enter the title", text: $title)
                }

                // Description Section
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 150)
                }

                // Date Picker Section
                Section(header: Text("Choose a Date")) {
                    HStack {
                        Text(selectedDate, style: .date)
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()

                        Button(action: {
                            showDatePicker.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }

                    if showDatePicker {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(height: 50)
                    }
                }

                // Image Picker Section
                Section(header: Text("Choose a Picture")) {
                    HStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                        } else {
                            Text("No image selected")
                        }

                        Spacer()

                        Button(action: {
                            showImagePicker.toggle()
                        }) {
                            Image(systemName: "camera")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .scrollContentBackground(.hidden)
            // Save Button
            Button(action: {
                guard !emoji.isEmpty, !title.isEmpty else { return }
                
                // Convert UIImage to Data if there's an image selected
                let coverImageData = selectedImage?.jpegData(compressionQuality: 0.8) // You can use .pngData() for PNG images
                
                let entry = JournalEntry(
                    emoji: emoji,
                    title: title,
                    entryDescription: description,
                    date: selectedDate,
                    coverImage: coverImageData // Pass the data representation of the image
                )
                context.insert(entry)
                onSave(entry)
            }) {
                Text("Save")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 150/255, green: 108/255, blue: 171/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, isCamera: isCamera)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 248/255, green: 246/255, blue: 206/255))
    }
}

struct JournalInputView_Previews: PreviewProvider {
    static var previews: some View {
        JournalInputView(onSave: { newEntry in
            print("Saved entry: \(newEntry)")
        })
    }
}
