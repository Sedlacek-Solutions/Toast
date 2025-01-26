//
//  ToastMessageView.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

struct ToastMessageView<T: View>: View {
    private let toast: Toast
    private let trailingView: T?

    init(_ toast: Toast, @ViewBuilder trailingView: () -> T? = { nil }) {
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

            if let trailingView {
                trailingView
            }
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

extension ToastMessageView where T == EmptyView {
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

extension ToastMessageView where T == Button<Text> {
    static var noticeExample: some View {
        return ToastMessageView(.notice(message: "A software update is available.")) {
            Button("Update") {
                print("Update pressed")
            }
        }
        .buttonStyle(.toastTrailing(toastType: .notice()))
    }
}

struct NetworkErrorExample: View {
    var body: some View {
        ToastMessageView(.error(message: "Network Error.")) {
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
            .buttonStyle(.toastTrailing(toastType: .warning()))
        }
    }
}

struct ContentView: View {
    @State private var toast: Toast? = nil

    var body: some View {
        VStack {
            Button("Show Update Toast") {
                toast = .notice(message: "A software update is available.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toast($toast, autoDismissable: false) {
            Button("Update") {
                print("Update Pressed")
            }
            .buttonStyle(.toastTrailing(toastType: .notice()))
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ContentView()
        ToastMessageView.infoExample
        ToastMessageView.successExample
        ToastMessageView.debugExample
        NetworkErrorExample()
        SomethingWrongExample()
    }
}
