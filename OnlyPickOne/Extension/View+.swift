//
//  View+.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/11/16.
//

import Foundation
import SwiftUI

extension View {
    func alertButtonTint(color: Color) -> some View {
        modifier(AlertButtonTintColor(color: color))
    }
}

fileprivate struct AlertButtonTintColor: ViewModifier {
    let color: Color
    @State private var previousTintColor: UIColor?

    func body(content: Content) -> some View {
        content
            .onAppear {
                previousTintColor = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(color)
            }
            .onDisappear {
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = previousTintColor
            }
    }
}
