//
//  ResultView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI
import GoogleMobileAds

struct ResultView: View {
    @ObservedObject var viewModel: GameViewModel
    
    @ViewBuilder func admob() -> some View {
        GADBanner().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
    }
    
    var body: some View {
        VStack {
            List {
                Section("내 결과") {
                    Text(viewModel.game.title ?? "")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .listRowSeparator(.hidden)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text((viewModel.game.createdTime ?? 0).toString())
                                .font(.caption2)
                                .fontWeight(.light)
                        }
                        
                        Text(viewModel.game.description ?? "")
                            .font(.caption)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                    }
                    .listRowSeparator(.hidden)
                    
                    
                    HStack {
                        Spacer()
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                        Text("우승")
                            .font(.headline)
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        Text("\"")
                            .font(.title)
                            .fontWeight(.heavy)
                        Text(viewModel.winner?.caption ?? "")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        Text("\"")
                            .font(.title)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    Image(uiImage: viewModel.winner?.image ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        Text("4강")
                            .font(.subheadline)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Image("cat1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image("cat1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image("cat1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .listRowSeparator(.hidden)
                }
                Section("전체 통계") {
                    ForEach((0..<10), id: \.self) { index in
                        HStack {
                            Image("cat1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                            VStack(alignment: .leading) {
                                Text("푸마")
                                    .font(.headline)
                                    .padding(2)
                                Text("64%")
                                    .font(.subheadline)
                                    .padding(2)
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .navigationTitle("최종 결과")
            
            admob()
        }
    }
}
