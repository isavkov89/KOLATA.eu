import SwiftUI
import SwiftData

struct DocumentDetailView: View {
    let document: DocumentEntry
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Document icon / preview
                if !document.fileURL.isEmpty, let data = DocumentStorageService.shared.loadDocument(at: document.fileURL), let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                } else {
                    Image(systemName: document.category.icon)
                        .font(.system(size: 56))
                        .foregroundStyle(.tint)
                        .frame(width: 120, height: 120)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }

                VStack(spacing: 8) {
                    Text(document.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Label(document.category.rawValue, systemImage: document.category.icon)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                GlassCard {
                    VStack(spacing: 12) {
                        InfoRow(label: "Category", value: document.category.rawValue, icon: "folder")
                        Divider()
                        InfoRow(label: "Upload Date", value: document.uploadDate.formatted_ddMMyyyy, icon: "calendar")
                        if let car = document.car {
                            Divider()
                            InfoRow(label: "Car", value: car.displayName, icon: "car")
                        }
                    }
                }

                if !document.notes.isEmpty {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.headline)
                            Text(document.notes)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label("Delete Document", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Document")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Document?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                deleteDocument()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
    }

    private func deleteDocument() {
        if !document.fileURL.isEmpty {
            try? DocumentStorageService.shared.deleteDocument(at: document.fileURL)
        }
        modelContext.delete(document)
        try? modelContext.save()
        dismiss()
    }
}
