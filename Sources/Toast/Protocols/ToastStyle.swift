//
//  File.swift
//  Toast
//
//  Created by Josh Bourke on 3/5/2025.
//

import SwiftUI

/// A type‑erased description of how a toast should be drawn.
///
/// Conformers supply a `makeBody(configuration:)` method, much like SwiftUI’s
/// `ButtonStyle`.  Use this protocol to design reusable visual treatments for
/// `ToastMessageView` instances.
///
/// Create your own style by conforming:
///
/// ```swift
/// struct MyToastStyle: ToastStyle {
///     func makeBody(configuration: ToastStyleConfiguration) -> some View {
///         // build and return a styled view here
///     }
/// }
/// ```
@MainActor public protocol ToastStyle {
    associatedtype Body: View
    func makeBody(configuration: ToastStyleConfiguration) -> Body
}

/// The information a `ToastStyle` needs in order to render a toast.
///
/// You receive an instance of this struct inside
/// `ToastStyle.makeBody(configuration:)`.  It gives you access to:
/// * `toast` – the `Toast` data (icon, message, colour, type, …)
/// * `trailingView` – any custom trailing view supplied by the caller
///   (e.g. a button or progress indicator) wrapped in `AnyView`.

public struct ToastStyleConfiguration {
    public let toast: Toast
    public let trailingView: AnyView
}

/// A type‑erased wrapper that lets us store _any_ `ToastStyle` in places
/// that require a concrete type (e.g. the SwiftUI environment).
///
/// You generally don’t create `AnyToastStyle` directly; it’s used internally
/// by the library.  However, you can erase a style’s type when needed:
///
/// ```swift
/// let erased = AnyToastStyle(MyToastStyle())
/// ```

@MainActor public struct AnyToastStyle: ToastStyle {
    private let _makeBody: (ToastStyleConfiguration) -> AnyView
    
    public init<S: ToastStyle>(_ style: S) {
        self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
    }
    
    public func makeBody(configuration: ToastStyleConfiguration) -> AnyView {
        _makeBody(configuration)
    }
}
