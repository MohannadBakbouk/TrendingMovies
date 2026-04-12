//
//  DSSearchBar.swift
//  DesignSystem
//
//  Created by Mohannad on 12/04/2026.
//


import SwiftUI

public struct DSSearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    public init(text: Binding<String>) {
        self._text = text
    }

    private enum Layout {
        static let padding = DSSpacing.small
    }

    public var body: some View {
        HStack(spacing: DSSpacing.small) {
            Image(systemName: DSImage.search)
                .font(DSFonts.searchBarIcon)
                .foregroundStyle(
                    isFocused
                    ? DSColors.searchBarFocusedIcon
                    : DSColors.searchBarIcon
                )

            TextField(
                "",
                text: $text,
                prompt: Text("Search TMDB")
                    .foregroundStyle(DSColors.secondaryText)
            )
            .textFieldStyle(.plain)
            .font(DSFonts.searchBarText)
            .foregroundStyle(DSColors.primaryText)
            .tint(DSColors.primary)
            .submitLabel(.search)
            .focused($isFocused)
            .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: DSImage.searchClear)
                        .font(DSFonts.searchBarClearIcon)
                        .foregroundStyle(
                            DSColors.searchBarClearIconPrimary,
                            DSColors.searchBarClearIconSecondary
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search text")
            }
        }
        .padding(Layout.padding)
        .background(DSColors.searchBarBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSCorner.small))
        .overlay(
            RoundedRectangle(cornerRadius: DSCorner.small)
                .strokeBorder(
                    isFocused
                    ? DSColors.searchBarFocusedBorder
                    : DSColors.searchBarBorder,
                    lineWidth: 1
                )
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
