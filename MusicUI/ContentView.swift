//
//  ContentView.swift
//  MusicUI
//
//  Created by Mohamad Yahia on 14.1.2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @State var expandCards: Bool = false
    @State var currentCard: AlbumModel?
    @State var showDetail: Bool = false
    @State var currentIndex: Int = -1
    @State var cardSize: CGSize = .zero
    @State var animateSingleView: Bool = false
    @State var rotateCards: Bool = false
    @State var showDetailContent: Bool = false
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            if !(expandCards) {
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title)
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.black.opacity(0.7))
                .overlay {
                    Text("Music UI")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }

            
            // Top Album View
            GeometryReader { proxy in
                let size = proxy.size
                
                StackView(size: size)
                    .frame(width: size.width, height: size.height, alignment: .center)
            }
            
            // Recently Played
            
            if !(expandCards) {
                RecentlyPlayedView()
            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            .yellow.opacity(0.05)
        )
        .overlay {
            if let currentCard = currentCard, showDetail {
                ZStack {
                    Color(.yellow)
                        .opacity(0.05)
                        .ignoresSafeArea()
                    SingleView(currentCard: currentCard)
                }
            }
        }
    }
    
    @ViewBuilder
    func StackView(size: CGSize) -> some View {
        let offsetHeight = size.height * 0.1
        
        ScrollView {
            ZStack {
                ForEach(stackAlbums.reversed()) { album in
                    let index = getIndex(album: album)
                    let imageSize = (size.width - (CGFloat(index) * 20))
                    
                    Image(album.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize / 1.5, height: imageSize / 1.5)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .matchedGeometryEffect(id: album.id, in: animation)
                        .offset(y: CGFloat(index) * -20)
                        .offset(y: expandCards ? -CGFloat(index) * offsetHeight: 0)
                        .onTapGesture {
                            if expandCards {
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                                    cardSize = CGSize(width: imageSize / 1.5, height: imageSize / 1.5)
                                    currentCard = album
                                    currentIndex = index
                                    showDetail = true
                                    rotateCards = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.spring()) {
                                            animateSingleView = true
                                        }
                                    }
                                }
                            } else {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    expandCards = true
                                }
                            }
                        }
                        .offset(y: showDetail && currentIndex != index ? size.height * (currentIndex < index ? -1 : 1) : 0)
                }
            }
            .offset(y: expandCards ? offsetHeight * 2 : 0)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    expandCards.toggle()
                }
            }
        }
    }
    
    // Single View
    func SingleView(currentCard: AlbumModel) -> some View {
        VStack(spacing: 0) {
            Button {
                rotateCards = false
                withAnimation {
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        self.currentIndex = -1
                        self.currentCard = nil
                        showDetail = false
                        animateSingleView = false
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    Image(currentCard.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cardSize.width, height: cardSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .rotation3DEffect(.init(degrees: showDetail && rotateCards ? -180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .rotation3DEffect(.init(degrees: animateSingleView && rotateCards ? -180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .matchedGeometryEffect(id: currentCard.id, in: animation)
                        .padding(.top, 50)
                    
                    VStack(spacing: 20) {
                        Text(currentCard.name)
                            .font(.title2.bold())
                            .padding(.top, 10)
                        
                        HStack(spacing: 50) {
                            Button {
                                
                            } label: {
                                Image(systemName: "shuffle")
                                    .font(.title2)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "pause.fill")
                                    .font(.title3)
                                    .frame(width: 55, height: 55)
                                    .background(Circle().fill(.blue.opacity(0.5)))
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.title2)
                            }
                        }
                        .padding(.top, 10)
                        
                        Text("Upcoming Track")
                            .font(.title2.bold())
                            .padding()
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(albums) { album in
                            TrackCardView(album: album)
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: showDetailContent ? 0 : 300)
                    .opacity(showDetailContent ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeInOut) {
                        showDetailContent = true
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func TrackCardView(album: AlbumModel) -> some View {
        HStack(spacing: 12) {
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(album.name)
                    .fontWeight(.semibold)
                
                Label {
                    Text(getRandomListenerCount())
                } icon: {
                    Image(systemName: "headphones.circle")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: album.isLiked ? "heart.circle.fill" : "heart.circle")
                    .font(.title3)
                    .foregroundColor(album.isLiked ? .red : .gray)
            }
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
    }
    
    
    func getIndex(album: AlbumModel) -> Int {
        return stackAlbums.firstIndex { currentAlbum in return album.id == currentAlbum.id } ?? 0
    }
    
    func getRandomListenerCount() -> String {
        let randNumber = Int.random(in: 1000000..<10000000)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        let formattedString = formatter.string(from: NSNumber(value: randNumber))

        var adjustedInt = randNumber
        while adjustedInt < 1000000 {
            adjustedInt *= 10
        }

        let adjustedFormattedString = formatter.string(from: NSNumber(value: adjustedInt))
        
        return adjustedFormattedString!
    }
}

#Preview {
    ContentView()
}
