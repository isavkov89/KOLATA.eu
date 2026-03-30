import Foundation
import UIKit

final class DocumentStorageService {
    static let shared = DocumentStorageService()

    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("CarDocuments", isDirectory: true)
    }

    init() {
        createDirectoryIfNeeded()
    }

    private func createDirectoryIfNeeded() {
        try? FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true)
    }

    func saveDocument(data: Data, filename: String) throws -> String {
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        try data.write(to: fileURL)
        return fileURL.path
    }

    func saveImage(_ image: UIImage, filename: String) throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw DocumentStorageError.compressionFailed
        }
        return try saveDocument(data: data, filename: "\(filename).jpg")
    }

    func loadDocument(at path: String) -> Data? {
        FileManager.default.contents(atPath: path)
    }

    func deleteDocument(at path: String) throws {
        try FileManager.default.removeItem(atPath: path)
    }

    func fileExists(at path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }
}

enum DocumentStorageError: LocalizedError {
    case compressionFailed
    case fileNotFound

    var errorDescription: String? {
        switch self {
        case .compressionFailed: return "Failed to compress image"
        case .fileNotFound: return "Document file not found"
        }
    }
}
