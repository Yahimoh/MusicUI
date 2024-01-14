//
//  RecentlyPlayedView.swift
//  MusicUI
//
//  Created by Mohamad Yahia on 14.1.2024.
//

import SwiftUI

struct RecentlyPlayedView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recently Played")
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(albums) { album in
                        Image(album.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 95)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
}

#Preview {
    RecentlyPlayedView()
}
