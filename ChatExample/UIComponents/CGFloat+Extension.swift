//
//  Spacing.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import Foundation

extension CGFloat {
    struct Spacing {
        let x4: CGFloat = 4
        let x8: CGFloat = 8
        let x16: CGFloat = 16
    }
    
    static var spacing: Spacing { Spacing() }
}

extension CGFloat {
    struct Size {
        let x56: CGFloat = 56
    }
    
    static var size: Size { Size() }
}
