//
//  ToastMessageView.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

struct ToastMessageView: View {
    private let toast: Toast
    
    init(_ toast: Toast) {
        self.toast = toast
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
            
            if let buttonTitle = toast.buttonTitle, let buttonAction = toast.buttonAction {
                Button(buttonTitle, action: buttonAction)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(toast.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(toast.color.opacity(0.2))
                    .cornerRadius(5)
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

extension ToastMessageView {
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
    
    static var noticeExample: some View {
        ToastMessageView(.notice(message: "A software update is available.", buttonTitle: "Update", buttonAction: {
            print("Update Button Tapped!")
        }))
    }
    
    static var debugExample: some View {
        ToastMessageView(.debug(message: "Line 32 in `File.swift` executed."))
    }
}

#Preview {
    VStack(spacing: 16) {
        ToastMessageView.infoExample
        ToastMessageView.warningExample
        ToastMessageView.errorExample
        ToastMessageView.successExample
        ToastMessageView.noticeExample
        ToastMessageView.debugExample
    }
}
