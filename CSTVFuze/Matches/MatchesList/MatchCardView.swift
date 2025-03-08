//
//  MatchCardView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct MatchCardView: View {
    var match: Match
    
    var body: some View {
        VStack {
            MatchTimeView(date: match.beginAt, status: match.status)
            
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
}

// MARK: Subviews

extension MatchCardView {
    struct MatchTimeView: View {
        
        var date: Date?
        var status: Match.Status?
        
        var matchTimeString: String {
            if status == .running {
                return "AGORA"
            }
            return date?.formatInPortuguese() ?? "???"
        }
        
        var body: some View {
            HStack {
                Spacer()
                Text(matchTimeString)
                    .font(size: 8)
                    .padding(8)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(
                        status == .running ? .red500 : .transparentWhite)
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
    }
    
    struct LeagueSerieFooterView: View {
        var league: League?
        var serie: Serie?

        var body: some View {
            HStack() {
                CachedAsyncLogoView(imageUrl: league?.imageUrl)
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
            match: Match(
                id: 1,
                name: "Preview Match",
                status: .running,
                league: .init(
                    id: 2,
                    name: "CCT Europe"
                ),
                opponents: [
                    .init(
                        opponent: .init(
                            id: 3,
                            name: "Sinners",
                            acronym: "SIN"
                        )
                    ),
                    .init(
                        opponent: .init(
                            id: 4,
                            name: "ECSTATIC",
                            acronym: "ECS"
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
