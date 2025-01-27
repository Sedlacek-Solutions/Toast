//
//  ToastModifier.swift
//
//  Created by James Sedlacek on 1/5/25.
//

import SwiftUI

@MainActor
struct ToastModifier<TrailingView: View>: ViewModifier {
    private let edge: VerticalEdge
    private let offset: CGFloat
    private let isAutoDismissed: Bool
    private let onDismiss: () -> Void
    private let trailingView: TrailingView?
    @Binding private var toast: Toast?
    @State private var isPresented: Bool = false

    private var yOffset: CGFloat {
        isPresented ? .zero : offset
    }

    init(
        toast: Binding<Toast?>,
        edge: VerticalEdge,
        isAutoDismissed: Bool,
        trailingView: TrailingView?,
        onDismiss: @escaping () -> Void
    ) {
        self._toast = toast
        self.edge = edge
        self.isAutoDismissed = isAutoDismissed
        self.trailingView = trailingView
        self.onDismiss = onDismiss
        self.offset = edge == .top ? -200 : 200
    }

    private func onChangeDragGesture(_ value: DragGesture.Value) {
        dismissToastAnimation()
    }

    private func onChangeToast(_ oldToast: Toast?, _ newToast: Toast?) {
        if newToast != nil {
            presentToastAnimation()
        }
    }

    private func presentToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
                isPresented = true
            }
        }
        if isAutoDismissed {
            autoDismissToastAnimation()
        }
    }

    private func dismissToastAnimation() {
        withAnimation(.easeOut(duration: 0.8)) {
            isPresented = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            toast = nil
            onDismiss()
        }
    }

    private func autoDismissToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            dismissToastAnimation()
        }
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: toast, onChangeToast)
            .overlay(
                alignment: edge.alignment,
                content: toastView
            )
    }

    @ViewBuilder
    private func toastView() -> some View {
        if let toast {
            ToastMessageView(toast, trailingView: { trailingView })
                .offset(y: yOffset)
                .gesture(dragGesture)
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: .zero)
            .onChanged(onChangeDragGesture)
    }
}
