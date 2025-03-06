//
//  MatchCardView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct MatchCardView: View {
    var match: Match
    
    var matchTimeString: String {
        if match.status == .running {
            return "AGORA"
        }
        return match.date?.formatInPortuguese() ?? "???"
    }
    
    var matchTimeView: some View {
        HStack {
            Spacer()
            Text(matchTimeString)
                .font(size: 8)
                .padding(8)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .background(
                    match.status == .running ? .red500 : .transparentWhite)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 16,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )
        }
    }
    
    var body: some View {
        VStack {
            matchTimeView
            
            TeamsVsView(
                teamA: match.opponents?.first?.opponent,
                teamB: match.opponents?.last?.opponent
            )
            Divider()
                .overlay(.white)
                .opacity(0.2)
            LeagueSerieFooterView(
                league: match.league,
                serie: match.serie
            )
        }
        .frame(maxWidth: .infinity)
        .background(.gray700)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    struct LeagueSerieFooterView: View {
        var league: League?
        var serie: Serie?

        var body: some View {
            HStack() {
                AsyncLogoView(imageUrl: league?.imageUrl)
                    .frame(width: 24, height: 24)
                Text((league?.name ?? "Liga") + " " + (serie?.name ?? ""))
                    .font(size: 8)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding([.top, .trailing], 8)
            .padding([.leading, .bottom], 16)
        }
    }
}

#Preview {
    VStack {
        MatchCardView(
            match: .init(
                id: 1,
                name: "Preview Match",
                status: .running,
                league: .init(
                    id: 2,
                    name: "CCT Europe",
                    imageUrl: "https://cdn.pandascore.co/images/league/image/5232/799px-cct_2024_europe_allmode-png"
                ),
                opponents: [
                    .init(
                        opponent: .init(
                            id: 3,
                            name: "Sinners",
                            acronym: "SIN",
                            imageUrl: "https://cdn.pandascore.co/images/team/image/127014/927px_sinners_esports_full_allmode.png"
                        )
                    ),
                    .init(
                        opponent: .init(
                            id: 4,
                            name: "ECSTATIC",
                            acronym: "ECS",
                            imageUrl: "https://cdn.pandascore.co/images/team/image/129856/600px_ecstatic_2023_allmode.png"
                        )
                    )
                ],
                serie: .init(name: "Series #20")
            )
        )
    }
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray900)
}
