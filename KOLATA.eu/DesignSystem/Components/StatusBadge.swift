import SwiftUI

struct StatusBadge: View {
    let status: ValidityStatus

    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(AppTheme.statusColor(for: status).opacity(0.15))
            .foregroundStyle(AppTheme.statusColor(for: status))
            .clipShape(Capsule())
    }
}
