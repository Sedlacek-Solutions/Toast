# SwiftUI-Toast

## Description
`SwiftUI-Toast` is a lightweight SwiftUI library that provides a simple way to display toast messages.

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 16.0            |
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
    public static func debug(message: LocalizedStringKey) -> Toast {...}

    /// Creates an error toast with a red color and an error icon.
    public static func error(message: LocalizedStringKey) -> Toast {...}

    /// Creates an info toast with a blue color and an info icon.
    public static func info(message: LocalizedStringKey) -> Toast {...}

    /// Creates a notice toast with an orange color and a notice icon.
    public static func notice(message: LocalizedStringKey) -> Toast {...}

    /// Creates a success toast with a green color and a success icon.
    public static func success(message: LocalizedStringKey) -> Toast {...}

    /// Creates a warning toast with a yellow color and a warning icon.
    public static func warning(message: LocalizedStringKey) -> Toast {...}
}
```

> **Tip:** If you have an existing string literal, you can continue calling the same APIs without any migration—the library now bridges `String` and `LocalizedStringKey` automatically. To pass an explicit localization key, call something like `.success(message: LocalizedStringKey("toast.success"))`.

3. Additional Options for Toast ViewModifier
```swift
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
) -> some View {...}
```

4. Adding a Trailing Views to Toasts
```swift
/// Add interactive elements such as buttons, icons, or loading indicators to the toast message.
/// Example usage:
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
```


## Custom Toast Styles

You can create and apply your own `ToastStyle` across the app or per instance.

### Define a Custom Style

```swift
/// Example of a reusable toast style
struct ExampleToastStyle: ToastStyle {
    func makeBody(configuration: ToastStyleConfiguration) -> some View {
        HStack(spacing: 10) {
            configuration.toast.icon
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(configuration.toast.color)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 12).fill(configuration.toast.color.opacity(0.3)))

            Text(configuration.toast.message)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)

            Spacer(minLength: .zero)

            configuration.trailingView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .padding()
    }
}
```

### Apply a Global Style

To apply the same toast style across your entire view hierarchy, attach it like this:

```swift
ContentView()
    .toastStyle(ExampleToastStyle())
```

### Override Style on a Specific Toast

If you want to override the style for a particular toast, pass it directly into the toast modifier:

```swift
.toast(
    $toast,
    style: ExampleToastStyle(),
    edge: .top,
    autoDismissable: true,
    onDismiss: { print("Dismissed") },
    trailingView: {
        Button("Action") { /* Do something */ }
    }
)
```

This gives you flexibility to mix and match styles depending on context.

---

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

![Example of Custom ToastStyle](https://github.com/user-attachments/assets/b7a1e2c6-468f-4243-acca-8f63f96f41da)
