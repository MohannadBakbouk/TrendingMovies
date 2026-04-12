//
//  GenreView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem

struct GenreView: View {
    let genres: [Genre]
    @Binding var selected: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(genres, id: \.id) { genre in
                    genreChip(for: genre)
                }
            }
        }
    }
    
    func genreChip(for genre: Genre) -> some View {
           let isSelected = selected == genre.id

           return Button {
               selected = genre.id
           } label: {
               Text(genre.name)
                   .font(.subheadline.weight(isSelected ? .semibold : .regular))
                   .lineLimit(1)
                   .padding(.horizontal, DSSpacing.small)
                   .padding(.vertical, DSSpacing.xSmall)
                   .foregroundStyle(DSColors.primaryText)
                   .background(chipBackground(isSelected: isSelected))
           }
           .buttonStyle(.plain)
       }
    
    
    private func chipBackground(isSelected: Bool) -> some View {
        RoundedRectangle(cornerRadius: DSCorner.xxLarge, style: .continuous)
            .fill(isSelected ? DSColors.primary : DSColors.secondary)
     }

}
