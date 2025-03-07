//
//  MatchTeamsView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 07/03/2025.
//

import SwiftUI

struct MatchStatsView: View {
    @StateObject var viewModel: ViewModel
    
    var matchTimeString: String {
        if viewModel.matchStatus == .running {
            return "AGORA"
        }
        return viewModel.matchTime?.formatInPortuguese() ?? "???"
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    TeamsVsView(
                        teamA: viewModel.teamA,
                        teamB: viewModel.teamB
                    )
                    .padding(24)
                    
                    Text(matchTimeString)
                        .font(size: 12)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(viewModel.matchStatus == .running ? .red : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .trailing, spacing: 20) {
                            ForEach(viewModel.teamA?.players ?? []) { player in
                                LeadingPlayerView(player: player)
                            }
                        }
                        .frame(maxWidth: geometry.size.width / 2)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.teamB?.players ?? []) { player in
                                TrailingPlayerView(player: player)
                            }
                        }
                        .frame(maxWidth: geometry.size.width / 2)
                    }
                }
                .loadingView(loading: viewModel.loading, hasError: viewModel.hasError)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray900)
            .refreshable {
                await viewModel.getTeams(idA: viewModel.idTeamA, idB: viewModel.idTeamB)
            }
            .onAppear {
                UIRefreshControl.appearance().tintColor = .clear
            }
        }
    }
}

// MARK: Subviews

extension MatchStatsView {
    struct PlayerImageView: View {
        var imageUrl: String

        var body: some View {
            AsyncImage(url: URL(string: imageUrl)) { result in
                if let image = result.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                } else {
                    Rectangle()
                        .foregroundStyle(.gray300)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 60, height: 60)
        }
    }
    
    struct PlayerNameView: View {
        var name: String
        var realName: String
        var alignment: HorizontalAlignment

        var body: some View {
            VStack(alignment: alignment, spacing: 8) {
                Text(name)
                    .font(size: 14)
                    .bold()
                    .foregroundStyle(.white)
                Text(realName)
                    .font(size: 12)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray500)
                    .allowsTightening(true)
                    .lineLimit(1)
            }
        }
    }

    struct LeadingPlayerView: View {
        var player: Player

        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundStyle(.gray700)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 12,
                            topTrailingRadius: 12
                        )
                    )
                    .padding(.top, 4)

                HStack(alignment: .bottom, spacing: 16) {
                    PlayerNameView(
                        name: player.name ?? "Player",
                        realName: "\(player.firstName ?? "") \(player.lastName ?? "")",
                        alignment: .trailing
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    PlayerImageView(imageUrl: player.imageUrl ?? "")
                        .padding(.trailing, 12)
                }
                .padding([.bottom], 12)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    struct TrailingPlayerView: View {
        var player: Player

        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundStyle(.gray700)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 12,
                            bottomLeadingRadius: 12,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    .padding(.top, 4)

                HStack(alignment: .bottom, spacing: 16) {
                    PlayerImageView(imageUrl: player.imageUrl ?? "")

                    PlayerNameView(
                        name: player.name ?? "Player",
                        realName: "\(player.firstName ?? "") \(player.lastName ?? "")",
                        alignment: .leading
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.horizontal, .bottom], 12)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    InjectedValues[\.teamsRepository] = MockedRepository()
    return MatchStatsView(
        viewModel: .init(
            match: .init(
                id: 1,
                status: .notStarted,
                opponents: [
                    .init(opponent: .init(id: 2)),
                    .init(opponent: .init(id: 3)),
                ],
                beginAt: "2025-03-07T15:51:24Z"
            )
        )
    )
}

fileprivate final class MockedRepository: TeamsRepository {
    func getTeam(id: Int) async throws -> Team {
        .init(
            id: 1,
            name: "Nemiga",
            players: [
                .init(
                    id: 1,
                    name: "Xant3r",
                    firstName: "Kirill",
                    lastName: "Kononov",
                    imageUrl: ""
                ),
                .init(
                    id: 2,
                    name: "keep3r",
                    firstName: "Yuriy",
                    lastName: "Mikulchik"
                )
            ]
        )
    }
}
