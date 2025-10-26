//
//  Toast.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

public struct Toast: Identifiable {
    public let id: UUID
    public let icon: Image
    public let color: Color
    public let message: LocalizedStringKey

    public init(
        id: UUID = UUID(),
        icon: Image,
        color: Color,
        message: LocalizedStringKey
    ) {
        self.id = id
        self.icon = icon
        self.color = color
        self.message = message
    }

    public init<S: StringProtocol>(
        id: UUID = UUID(),
        icon: Image,
        color: Color,
        message: S
    ) {
        self.init(
            id: id,
            icon: icon,
            color: color,
            message: LocalizedStringKey(String(message))
        )
    }
}

extension Toast: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Toast, rhs: Toast) -> Bool {
        lhs.id == rhs.id
    }
}

/// Extension to the Toast struct to provide convenience initializers for different types of toasts.
extension Toast {
    /// Creates a debug toast with a purple color and a debug icon.
    public static func debug(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.debug), color: .purple, message: message)
    }

    public static func debug<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.debug), color: .purple, message: message)
    }
    
    /// Creates an error toast with a red color and an error icon.
    public static func error(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.error), color: .red, message: message)
    }

    public static func error<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.error), color: .red, message: message)
    }
    
    /// Creates an info toast with a blue color and an info icon.
    public static func info(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.info), color: .blue, message: message)
    }

    public static func info<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.info), color: .blue, message: message)
    }
    
    /// Creates a notice toast with an orange color and a notice icon.
    public static func notice(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.notice), color: .orange, message: message)
    }

    public static func notice<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.notice), color: .orange, message: message)
    }
    
    /// Creates a success toast with a green color and a success icon.
    public static func success(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.success), color: .green, message: message)
    }

    public static func success<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.success), color: .green, message: message)
    }
    
    /// Creates a warning toast with a yellow color and a warning icon.
    public static func warning(message: LocalizedStringKey) -> Toast {
        .init(icon: Image(.warning), color: .yellow, message: message)
    }

    public static func warning<S: StringProtocol>(message: S) -> Toast {
        .init(icon: Image(.warning), color: .yellow, message: message)
    }
}
