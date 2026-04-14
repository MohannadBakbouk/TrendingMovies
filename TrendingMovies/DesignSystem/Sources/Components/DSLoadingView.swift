import SwiftUI

public struct DSLoadingView: View {
    private let scale: CGFloat

    public init(scale: CGFloat = 2) {
        self.scale = scale
    }

    public var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(DSColors.primary)
                .scaleEffect(scale)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

