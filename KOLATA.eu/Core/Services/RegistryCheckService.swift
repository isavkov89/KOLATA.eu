import Foundation

enum CheckType {
    case vignette
    case technicalInspection
    case liabilityInsurance
}

struct CheckResult {
    let isValid: Bool
    let expirationDate: Date?
    let source: String
    let checkedAt: Date
}

protocol RegistryCheckServiceProtocol {
    func checkStatus(for registrationNumber: String, type: CheckType) async throws -> CheckResult
}

final class MockRegistryCheckService: RegistryCheckServiceProtocol {
    func checkStatus(for registrationNumber: String, type: CheckType) async throws -> CheckResult {
        // Simulate network delay
        try await Task.sleep(for: .seconds(1))

        // For MVP, return mock data - this will be replaced with real API calls
        return CheckResult(
            isValid: true,
            expirationDate: Calendar.current.date(byAdding: .month, value: 6, to: Date()),
            source: "Manual",
            checkedAt: Date()
        )
    }
}

final class RegistryCheckService: RegistryCheckServiceProtocol {
    static let shared = RegistryCheckService()

    private let mockService = MockRegistryCheckService()

    func checkStatus(for registrationNumber: String, type: CheckType) async throws -> CheckResult {
        // For MVP, delegate to mock service
        // In production, this would call real APIs or web scraping endpoints
        return try await mockService.checkStatus(for: registrationNumber, type: type)
    }
}
