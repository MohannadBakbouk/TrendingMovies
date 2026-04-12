//
//  MovieInfoItem.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import SwiftUI
import DesignSystem

struct MovieInfoItem: View {
    let title: String
    let value: String
    var isLink: Bool = false

    private let titleWidth: CGFloat = 82

    var body: some View {
        HStack(alignment: .top, spacing: DSSpacing.xxSmall) {
            Text("\(title):")
                .font(DSFonts.subheadline)
                .foregroundStyle(DSColors.primaryText)
                .frame(width: titleWidth, alignment: .leading)

            if isLink, let url = URL(string: value), !value.isEmpty {
                Link(destination: url) {
                    Text("Official Website")
                        .font(DSFonts.subheadline)
                        .foregroundStyle(DSColors.blue)
                        .underline()
                }
            } else {
                Text(value)
                    .font(DSFonts.subheadline)
                    .foregroundStyle(DSColors.secondaryText)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
