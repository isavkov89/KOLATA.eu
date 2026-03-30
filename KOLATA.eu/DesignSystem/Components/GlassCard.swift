import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(AppTheme.padding)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}
