//
//  Text+.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 06/03/2025.
//

import SwiftUI

extension Text {
   func font(size: CGFloat) -> Text {
       self.font(Font.custom("Roboto-Regular", size: size))
   }
}
