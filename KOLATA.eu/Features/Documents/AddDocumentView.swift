import SwiftUI
import SwiftData
import PhotosUI

struct AddDocumentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var cars: [Car]

    @State private var title = ""
    @State private var category: DocumentCategory = .other
    @State private var notes = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var showCamera = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Document Info") {
                    TextField("Title", text: $title)
                    Picker("Category", selection: $category) {
                        ForEach(DocumentCategory.allCases, id: \.self) { cat in
                            Label(cat.rawValue, systemImage: cat.icon).tag(cat)
                        }
                    }
                }

                Section("Upload") {
                    PhotosPicker(selection: $selectedPhoto, matching: .any(of: [.images, .screenshots])) {
                        Label("Choose from Library", systemImage: "photo.on.rectangle")
                    }

                    if selectedImageData != nil {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text("Image selected")
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle("Add Document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveDocument() }
                        .disabled(title.isEmpty)
                }
            }
            .onChange(of: selectedPhoto) { _, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }

    private func saveDocument() {
        var filePath = ""

        if let imageData = selectedImageData {
            let filename = "\(UUID().uuidString).jpg"
            filePath = (try? DocumentStorageService.shared.saveDocument(data: imageData, filename: filename)) ?? ""
        }

        let document = DocumentEntry(
            title: title,
            category: category,
            uploadDate: Date(),
            fileURL: filePath,
            notes: notes
        )

        if let car = cars.first {
            document.car = car
            car.documents.append(document)
        } else {
            modelContext.insert(document)
        }

        try? modelContext.save()
        dismiss()
    }
}
