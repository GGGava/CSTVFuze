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

#Preview {
    TeamsVsView(
        teamA:.init(
            id: 3,
            name: "Sinners",
            acronym: "SIN",
            imageUrl: "https://cdn.pandascore.co/images/team/image/127014/927px_sinners_esports_full_allmode.png"
        ),
        teamB: .init(
            id: 4,
            name: "ECSTATIC",
            acronym: "ECS",
            imageUrl: "https://cdn.pandascore.co/images/team/image/129856/600px_ecstatic_2023_allmode.png"
        )
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray700)
}
