//
//  ResultView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI
import GoogleMobileAds
import Kingfisher

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
                            Text((viewModel.game.createdTime ?? "").toLastTimeString())
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
                    
                    KFImage(URL(string: viewModel.winner?.imageUrl ?? ""))
                        .placeholder { //플레이스 홀더 설정
                            Image(systemName: "list.dash")
                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                        .onSuccess {r in //성공
                            print("succes: \(r)")
                        }
                        .onFailure { e in //실패
                            print("failure: \(e)")
                        }
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
                        GeometryReader { geometry in
                            HStack {
                                VStack {
                                    KFImage(URL(string: viewModel.semifinals[0]?.imageUrl ?? ""))
                                        .placeholder { //플레이스 홀더 설정
                                            Image(systemName: "list.dash")
                                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                        .onSuccess {r in //성공
                                            print("succes: \(r)")
                                        }
                                        .onFailure { e in //실패
                                            print("failure: \(e)")
                                        }
                                        .resizable()
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (4/5))
                                        .clipped()
                                    Text("\(viewModel.semifinals[0]?.caption ?? "")")
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (1/5))
                                }
                                VStack {
                                    KFImage(URL(string: viewModel.semifinals[1]?.imageUrl ?? ""))
                                        .placeholder { //플레이스 홀더 설정
                                            Image(systemName: "list.dash")
                                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                        .onSuccess {r in //성공
                                            print("succes: \(r)")
                                        }
                                        .onFailure { e in //실패
                                            print("failure: \(e)")
                                        }
                                        .resizable()
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (4/5))
                                        .clipped()
                                    Text("\(viewModel.semifinals[1]?.caption ?? "")")
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (1/5))
                                }
                                VStack {
                                    KFImage(URL(string: viewModel.semifinals[2]?.imageUrl ?? ""))
                                        .placeholder { //플레이스 홀더 설정
                                            Image(systemName: "list.dash")
                                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                        .onSuccess {r in //성공
                                            print("succes: \(r)")
                                        }
                                        .onFailure { e in //실패
                                            print("failure: \(e)")
                                        }
                                        .resizable()
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (4/5))
                                        .clipped()
                                    Text("\(viewModel.semifinals[2]?.caption ?? "")")
                                        .frame(width: (geometry.size.width - 10) * (1/3), height: geometry.size.height * (1/5))
                                }
                            }
                        }
                        .frame(height: 80)
                        .padding(10)
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
