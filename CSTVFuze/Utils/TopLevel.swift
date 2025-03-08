//
//  TopLevel.swift
//  CSTVFuze
//
//  Created by Gustavo Gava on 08/03/2025.
//

import Foundation

func thumbUrl(from imageUrl: String) -> URL? {
    if var url = URL(string: imageUrl) {
        let prefixedComponent = "thumb_" + url.lastPathComponent
        url.deleteLastPathComponent()
        return url.appendingPathComponent(prefixedComponent)
    }
    return nil
}
