//
//  View+Toast.swift
//
//  Created by James Sedlacek on 12/18/23.
//

import SwiftUI

/// Extension to add a toast to any View.
public extension View {

    /// Shows a toast with a provided configuration.
    /// - Parameters:
    ///   - toast: A binding to the toast to display.
    ///   - edge: The edge of the screen where the toast appears.
    ///   - autoDismissable: Whether the toast should automatically dismiss.
    ///   - onDismiss: A closure to call when the toast is dismissed.
    ///   - trailingView: A closure that returns a trailing view to be displayed in the toast.
    func toast<TrailingView: View>(
        _ toast: Binding<Toast?>,
        edge: VerticalEdge = .top,
        autoDismissable: Bool = false,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) -> some View {
        modifier(
            ToastModifier(
                toast: toast,
                edge: edge,
                isAutoDismissed: autoDismissable,
                onDismiss: onDismiss,
                trailingView: trailingView()
            )
        )
    }
}

public extension View {
    /// Presents a `Toast` using the built‑in default style or any `ToastStyle`
    /// provided with `.toastStyle(_:)` higher in the view hierarchy.
    ///
    /// - Parameters:
    ///   - toast: A binding to the `Toast` to display.
    ///   - edge: The screen edge where the toast appears (`.top` or `.bottom`).
    ///   - isAutoDismissed: Pass `true` to let the toast dismiss itself after a
    ///     delay, or `false` to keep it onscreen until the user swipes it away.
    ///   - onDismiss: A closure that’s called after the toast is dismissed
    ///     (either automatically or by the user).
    ///   - trailingView: An optional trailing view—such as a button or progress
    ///     indicator—displayed at the right edge of the toast.
    func toast<T: View>(
        _ toast: Binding<Toast?>,
        edge: VerticalEdge = .top,
        isAutoDismissed: Bool = true,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder trailingView: () -> T = { EmptyView() }
    ) -> some View {
        modifier(
            ToastModifier(
                toast: toast,
                edge: edge,
                isAutoDismissed: isAutoDismissed,
                onDismiss: onDismiss,
                trailingView: trailingView()
            )
        )
    }
    
    /// Presents a `Toast` with a custom `ToastStyle`, overriding both the
    /// default look and any style supplied via `.toastStyle(_:)`.
    ///
    /// - Parameters:
    ///   - toast: A binding to the `Toast` to display.
    ///   - style: The `ToastStyle` to apply to *this* toast only.
    ///   - edge: The screen edge where the toast appears (`.top` or `.bottom`).
    ///   - isAutoDismissed: Pass `true` to let the toast dismiss itself after a
    ///     delay, or `false` to keep it onscreen until the user swipes it away.
    ///   - onDismiss: A closure that’s called after the toast is dismissed
    ///     (either automatically or by the user).
    ///   - trailingView: An optional trailing view—such as a button or progress
    ///     indicator—displayed at the right edge of the toast.
    func toast<T: View, S: ToastStyle>(
        _ toast: Binding<Toast?>,
        style: S,
        edge: VerticalEdge = .top,
        isAutoDismissed: Bool = true,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder trailingView: () -> T = { EmptyView() }
    ) -> some View {
        modifier(
            ToastModifier(
                toast: toast,
                edge: edge,
                isAutoDismissed: isAutoDismissed,
                onDismiss: onDismiss,
                trailingView: trailingView(),
                style: AnyToastStyle(style)
            )
        )
    }
}

