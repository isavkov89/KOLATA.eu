import SwiftUI

enum AppTheme {
    static let cornerRadius: CGFloat = 16
    static let smallCornerRadius: CGFloat = 12
    static let padding: CGFloat = 16
    static let smallPadding: CGFloat = 8
    static let cardSpacing: CGFloat = 12

    static let statusGreen = Color.green
    static let statusOrange = Color.orange
    static let statusRed = Color.red
    static let statusGray = Color.gray

    static func statusColor(for status: ValidityStatus) -> Color {
        switch status {
        case .valid: return statusGreen
        case .expiringSoon: return statusOrange
        case .expired: return statusRed
        case .unknown: return statusGray
        }
    }
}
