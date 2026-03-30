import SwiftUI
import SwiftData
import PhotosUI

struct DocumentsView: View {
    @Query private var documents: [DocumentEntry]
    @State private var selectedCategory: DocumentCategory?
    @State private var showAddDocument = false

    private var filteredDocuments: [DocumentEntry] {
        if let category = selectedCategory {
            return documents.filter { $0.category == category }
        }
        return documents
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "All", isSelected: selectedCategory == nil) {
                            selectedCategory = nil
                        }
                        ForEach(DocumentCategory.allCases, id: \.self) { category in
                            FilterChip(title: category.rawValue, isSelected: selectedCategory == category) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }

                if filteredDocuments.isEmpty {
                    ContentUnavailableView("No Documents", systemImage: "doc", description: Text("Tap + to upload a document."))
                        .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(filteredDocuments.sorted(by: { $0.uploadDate > $1.uploadDate })) { doc in
                            NavigationLink {
                                DocumentDetailView(document: doc)
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: doc.category.icon)
                                        .font(.title3)
                                        .foregroundStyle(.tint)
                                        .frame(width: 32)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(doc.title)
                                            .fontWeight(.medium)
                                        Text(doc.category.rawValue)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    Text(doc.uploadDate.formatted_ddMMyyyy)
                                        .font(.caption2)
                                        .foregroundStyle(.tertiary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Documents")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { showAddDocument = true } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddDocument) {
                AddDocumentView()
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.accentColor.opacity(0.15) : Color.clear)
                .foregroundStyle(isSelected ? .primary : .secondary)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(isSelected ? Color.accentColor.opacity(0.3) : Color.secondary.opacity(0.2), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}
