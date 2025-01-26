//
//  ToastTrailingButtonStyle.swift
//  Toast
//
//  Created by Gaurav Bhambhani on 1/22/25.
//

import SwiftUI

public struct ToastTrailingButtonStyle: ButtonStyle {

    let toast: Toast

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .fontWeight(.semibold)
            .foregroundStyle(toast.color)
            .background(toast.color.opacity(0.2), in: .rect(cornerRadius: 5))
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

extension ButtonStyle where Self == ToastTrailingButtonStyle {
    @MainActor
    public static func toastTrailing(toastType toast: Toast) -> ToastTrailingButtonStyle {
        return .init(toast: toast)
    }
}
