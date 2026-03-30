import SwiftUI

extension View {
    func glassCard() -> some View {
        self
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

    func glassSurface() -> some View {
        self
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
