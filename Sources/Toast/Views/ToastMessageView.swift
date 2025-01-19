//
//  ToastMessageView.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

struct ToastMessageView<T: View>: View {
    private let toast: Toast
	private let trailingButtonView: T?

	init(_ toast: Toast, @ViewBuilder trailingButtonView: () -> T? = { nil }) {
		self.toast = toast
		self.trailingButtonView = trailingButtonView()
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

			if let trailingButtonView {
				trailingButtonView
					.padding(.horizontal, 10)
					.padding(.vertical, 5)
					.fontWeight(.semibold)
					.foregroundStyle(toast.color)
					.background(toast.color.opacity(0.2),
								in: .rect(cornerRadius: 5)
					)
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

extension ToastMessageView where T == EmptyView {
    static var infoExample: some View {
        ToastMessageView(.info(message: "Something informational for the user."))
    }

    static var warningExample: some View {
        ToastMessageView(.warning(message: "Something went wrong!"))
    }

    static var errorExample: some View {
        ToastMessageView(.error(message: "Network error!"))
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
		ToastMessageView(.notice(message: "A software update is available.")) {
			Button("Update") {
				print("Update pressed")
			}
		}
	}
}

#Preview {
    VStack(spacing: 16) {
        ToastMessageView.infoExample
        ToastMessageView.warningExample
        ToastMessageView.errorExample
        ToastMessageView.successExample
        ToastMessageView.debugExample
		ToastMessageView.noticeExample
    }
}
