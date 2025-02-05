//
//  ToastMessageView.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

struct ToastMessageView<TrailingView: View>: View {
    private let toast: Toast
    private let trailingView: TrailingView

    init(
        _ toast: Toast,
        @ViewBuilder trailingView: () -> TrailingView = { EmptyView() }
    ) {
        self.toast = toast
        self.trailingView = trailingView()
    }

    var body: some View {
        HStack(spacing: 10) {
            toast.icon
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(toast.color)

            Text(toast.message)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primary)

            Spacer(minLength: .zero)

            trailingView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(backgroundView)
        .padding()
    }

    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.background.secondary)
            .fill(toast.color.opacity(0.08))
            .stroke(toast.color, lineWidth: 2)
    }
}

// MARK: Example Usages

extension ToastMessageView where TrailingView == EmptyView {
    static var infoExample: some View {
        ToastMessageView(.info(message: "Something informational for the user."))
    }

    static var successExample: some View {
        ToastMessageView(.success(message: "Successfully did the thing!"))
    }

    static var debugExample: some View {
        ToastMessageView(.debug(message: "Line 32 in `File.swift` executed."))
    }
}

struct NetworkErrorExample: View {
    var body: some View {
        ToastMessageView(.error(message: "Network Error!")) {
            ProgressView()
        }
    }
}

struct SomethingWrongExample: View {
    var body: some View {
        ToastMessageView(.warning(message: "Something went wrong!")) {
            Button(action:  {
                print("Go to logs")
            }) {
                Image(systemName: "doc.text.magnifyingglass")
            }
            .buttonStyle(.toastTrailing(tintColor: .yellow))
        }
    }
}

@MainActor
struct ExampleView {
    @State private var toastToPresent: Toast? = nil

    private func showAction() {
        toastToPresent = .notice(message: "A software update is available.")
    }

    private func updateAction() {
        print("Update Pressed")
    }
}

extension ExampleView: View {
    var body: some View {
        Button("Show Update Toast", action: showAction)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(40)
            .toast($toastToPresent, trailingView: updateButton)
    }

    @ViewBuilder
    private func updateButton() -> some View {
        if let toastToPresent {
            Button("Update", action: updateAction)
                .buttonStyle(
                    .toastTrailing(tintColor: toastToPresent.color)
                )
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ExampleView()
        ToastMessageView.infoExample
        ToastMessageView.successExample
        ToastMessageView.debugExample
        NetworkErrorExample()
        SomethingWrongExample()
    }
}
