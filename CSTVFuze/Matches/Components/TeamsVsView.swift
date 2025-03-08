//
//  TeamVsView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct TeamsVsView: View {
    var teamA: Team?
    var teamB: Team?
    
    var body: some View {
        HStack(spacing: 20) {
            TeamBadgeView(team: teamA)
            
            Text("vs")
                .font(size: 12)
                .foregroundStyle(.white)
                .opacity(0.5)
            
            TeamBadgeView(team: teamB)
        }
    }
}

// MARK: Subviews

extension TeamsVsView {
    struct TeamBadgeView: View {
        var team: Team?
        
        var body: some View {
            VStack(spacing: 10) {
                CachedAsyncLogoView(imageUrl: team?.imageUrl)
                .frame(width: 60, height: 60)
                
                Text(team?.name ?? "Time 1")
                    .font(size: 12)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .frame(width: 100)
            }
        }
    }
}

#Preview {
    TeamsVsView(
        teamA:.init(
            name: "Sinners",
            imageUrl: "https://cdn.pandascore.co/images/team/image/127014/927px_sinners_esports_full_allmode.png"
        ),
        teamB: .init(
            name: "ECSTATIC",
            imageUrl: "https://cdn.pandascore.co/images/team/image/129856/600px_ecstatic_2023_allmode.png"
        )
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray700)
}
