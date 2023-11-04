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
    @State var isSharePresented = false
    @State private var renderedImage = Image(systemName: "photo")
    @Environment(\.displayScale) var displayScale
    
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
                        .startLoadingBeforeViewAppear()
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
                                        .startLoadingBeforeViewAppear()
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
                                        .startLoadingBeforeViewAppear()
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
                                        .startLoadingBeforeViewAppear()
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
                    ForEach((0..<viewModel.statisticsList.count), id: \.self) { index in
                        HStack {
                            KFImage(URL(string: viewModel.statisticsList[index]?.imageUrl ?? ""))
                                .placeholder { //플레이스 홀더 설정
                                    Image(systemName: "list.dash")
                                }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                .onSuccess {r in //성공
                                    print("succes: \(r)")
                                }
                                .onFailure { e in //실패
                                    print("failure: \(e)")
                                }
                                .startLoadingBeforeViewAppear()
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                            VStack(alignment: .leading) {
                                Text("\(viewModel.statisticsList[index]?.caption ?? "")")
                                    .font(.headline)
                                    .padding(2)
                                Text("\(viewModel.statisticsList[index]?.winCount ?? 0)회")
                                    .font(.subheadline)
                                    .padding(2)
                                GeometryReader { geometry in
                                    HStack {
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color("opoPink"))
                                                .frame(width: geometry.size.width * (viewModel.statisticsList[index]?.stats ?? 0.0) * 0.01, height: geometry.size.height)
                                            Text(String(format: "%.2f", viewModel.statisticsList[index]?.stats ?? 0.0) + "%")
                                                .font(.caption2)
                                                .frame(width: geometry.size.width * (viewModel.statisticsList[index]?.stats ?? 0.0) * 0.01, height: geometry.size.height)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                .frame(height: 20)
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .navigationTitle("최종 결과")
            .toolbar {
                if #available(iOS 16.0, *) {
                    ShareLink(item: renderedImage, preview: SharePreview(Text("OnlyPickOne Shared Image"), image: renderedImage))
                }
            }
            
//            admob()
        }
        .onAppear { render() }
    }
    
    @MainActor func render() {
        if #available(iOS 16.0, *) {
            let renderer = ImageRenderer(content: RenderView(text: viewModel.winner?.caption ?? ""))
            
            // make sure and use the correct display scale for this device
            renderer.scale = displayScale
            
            if let uiImage = renderer.uiImage {
                renderedImage = Image(uiImage: uiImage)
            }
        }
    }
}

struct RenderView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}
