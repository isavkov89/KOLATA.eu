import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String
    var icon: String? = nil

    var body: some View {
        HStack {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(.secondary)
                    .frame(width: 24)
            }
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
