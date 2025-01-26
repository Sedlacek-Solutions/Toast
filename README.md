# Toast

## Description
`Toast` is a lightweight SwiftUI library that provides a simple way to display toast messages.

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 17.0            |
| macOS    | 14.0            |

## Get Started

1. Toast ViewModifier
```swift
import Toast
import SwiftUI

@MainActor
struct ExampleScreen {
    @State var isLoading: Bool = false
    @State var toastToPresent: Toast? = nil

    @Sendable func onTask() async {
        isLoading = true
        defer { isLoading = false }

        do {
            try await Task.sleep(for: .seconds(1))
            toastToPresent = .success(message: "Successfully did a thing!")
        } catch {
            toastToPresent = .error(message: "Failure to do a thing!")
        }
    }
}

extension ExampleScreen: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .task(onTask)
        .toast($toastToPresent)
    }
}
```

2. Convenience Initializers
```swift
/// Extension to the Toast struct to provide convenience initializers for different types of toasts.
extension Toast {
    /// Creates a debug toast with a purple color and a debug icon.
    public static func debug(message: String = "") -> Toast {...}

    /// Creates an error toast with a red color and an error icon.
    public static func error(message: String = "") -> Toast {...}

    /// Creates an info toast with a blue color and an info icon.
    public static func info(message: String = "") -> Toast {...}

    /// Creates a notice toast with an orange color and a notice icon.
    public static func notice(message: String = "") -> Toast {...}

    /// Creates a success toast with a green color and a success icon.
    public static func success(message: String = "") -> Toast {...}

    /// Creates a warning toast with a yellow color and a warning icon.
    public static func warning(message: String = "") -> Toast {...}
}
```

3. Additional Options for Toast ViewModifier
```swift
/// Shows a toast with a provided configuration.
/// - Parameters:
///   - toast: A binding to the toast to display.
///   - edge: The edge of the screen where the toast appears.
///   - autoDismissable: Whether the toast should automatically dismiss.
///   - trailingView: A customizable action view
///   - onDismiss: A closure to call when the toast is dismissed.
func toast<TrailingView: View>(
    _ toast: Binding<Toast?>,
    edge: VerticalEdge = .top,
    autoDismissable: Bool = false,
    @ViewBuilder trailingView: @escaping () -> TrailingView? = { nil },
    onDismiss: @escaping () -> Void = {}
) -> some View {...}
```

4. Adding a Trailing Views to Toasts
```swift
/// Add interactive elements such as buttons, icons, or loading indicators to the toast message.
/// Example usage:
struct ExampleView: View {
    @State private var toast: Toast? = nil

    var body: some View {
        VStack {
            Button("Show Update Toast") {
                toast = .notice(message: "A software update is available.")
            }
        }
        .toast($toast, autoDismissable: false) {
            Button("Update") {
                print("Update Pressed")
            }
            .buttonStyle(.toastTrailing(toastType: .notice()))
        }
    }
}

/// Explanation:
/// - The `.toast()` modifier is applied to the `VStack`, with `autoDismissable: false` to keep the toast visible until the user dismisses it.
/// - The trailing view is a `Button` labeled "Update", which prints "Update Pressed" when tapped.
/// - The `.buttonStyle(.toastTrailing(toastType: .notice()))` ensures that the button matches
///   the toast’s color scheme and styling.
```

## Features
- **Multiple Toast Types**: `success`, `error`, `info`, `warning`, `notice`
- **Supports Trailing Views**: Buttons, Icons, Loaders
- **Auto-Dismiss & Manual Dismiss**: Configurable behavior
- **Flexible Customization**: Accepts any SwiftUI view as a trailing element

## Example Use Cases

| Feature            | Example                                        |
|--------------------|------------------------------------------------|
| Simple Toast       | `.toast($toast)`                               |
| Actionable Toast   | `.toast($toast) { Button("OK") { ... } }`      |
| Loading Indicator  | `.toast($toast) { ProgressView() }`            |
| Auto-dismiss Toast | `.toast($toast, autoDismissable: true)`        |

## Previews

https://github.com/user-attachments/assets/a22d7e4e-e3dd-4733-8070-235c631e8292

