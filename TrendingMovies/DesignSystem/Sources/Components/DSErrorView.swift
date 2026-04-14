import SwiftUI

public struct DSErrorView: View {
    private let message: String
    private let retryTitle: String
    private let onRetry: () -> Void

    public init(
        message: String,
        retryTitle: String = "Retry",
        onRetry: @escaping () -> Void
    ) {
        self.message = message
        self.retryTitle = retryTitle
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: DSSpacing.small) {
            Text(message)
                .font(DSFonts.body)
                .foregroundStyle(DSColors.primaryText)
                .multilineTextAlignment(.center)

            Button(retryTitle, action: onRetry)
                .buttonStyle(.borderedProminent)
                .tint(DSColors.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(DSSpacing.medium)
    }
}

