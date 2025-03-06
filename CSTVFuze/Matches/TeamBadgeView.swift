//
//  TeamBadgeView.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

struct TeamBadgeView: View {
    var team: Team?
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncLogoView(imageUrl: team?.imageUrl)
            .frame(width: 60, height: 60)
            
            Text(team?.name ?? "Time 1")
                .font(size: 12)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}
