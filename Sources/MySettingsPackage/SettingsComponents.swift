import SwiftUI

// MARK: - 状态类型
public enum StatusKind {
    case checkmark
    case warning
}

// MARK: - 基础行组件
struct SettingsRowBase: View {
    let icon: String?
    let title: LocalizedStringKey
    let content: AnyView
    
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 24)
            }
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            content
        }
    }
}

// MARK: - Section
public struct SettingsSectionView<Content: View>: View {
    let title: LocalizedStringKey
    @ViewBuilder let content: Content
    
    public init(_ title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        Section(title) {
            content
        }
    }
}

// MARK: - SettingsList
public struct SettingsList<Content: View>: View {
    let title: LocalizedStringKey
    let displayMode: NavigationBarItem.TitleDisplayMode
    @ViewBuilder let content: Content
    
    public init(title: LocalizedStringKey,
                displayMode: NavigationBarItem.TitleDisplayMode = .inline,
                @ViewBuilder content: () -> Content) {
        self.title = title
        self.displayMode = displayMode
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack {
            List {
                content
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(displayMode)  // 使用外部传入的样式
        }
    }
}

// MARK: - DSL 便利函数

/// 创建开关行
public func toggle(_ title: LocalizedStringKey, binding: Binding<Bool>, icon: String? = nil) -> some View {
    SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(Toggle("", isOn: binding).labelsHidden())
    )
}

/// 创建选择器行
public func picker(_ title: LocalizedStringKey, selection: Binding<Int>, options: [String], icon: String? = nil) -> some View {
    SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(
            Picker("", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.menu)
        )
    )
}

/// 创建颜色选择器行
public func colorPicker(_ title: LocalizedStringKey, binding: Binding<Color>, icon: String? = nil) -> some View {
    SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(ColorPicker("", selection: binding).labelsHidden())
    )
}

/// 创建滑块行
public func slider(_ title: LocalizedStringKey, binding: Binding<Double>, range: ClosedRange<Double>, icon: String? = nil) -> some View {
    SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(Slider(value: binding, in: range).frame(width: 120))
    )
}

/// 创建步进器行
public func stepper(_ title: LocalizedStringKey, binding: Binding<Int>, range: ClosedRange<Int>, icon: String? = nil) -> some View {
    SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(
            Stepper(value: binding, in: range) {
                Text("\(binding.wrappedValue)")
            }
            .frame(width: 120)
        )
    )
}

/// 创建状态行
public func status(_ title: LocalizedStringKey, kind: StatusKind, icon: String? = nil) -> some View {
    let statusIcon: some View = {
        switch kind {
        case .checkmark:
            return Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.subheadline)
        case .warning:
            return Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.orange)
                .font(.subheadline)
        }
    }()
    
    return SettingsRowBase(
        icon: icon,
        title: title,
        content: AnyView(statusIcon)
    )
}

/// 创建普通行（带箭头）
public func row(_ title: LocalizedStringKey, icon: String? = nil, chevron: Bool = true) -> some View {
    let chevronView: AnyView = chevron ? 
        AnyView(Image(systemName: "chevron.right")
            .foregroundColor(.secondary)
            .font(.caption)) : 
        AnyView(EmptyView())
    
    return SettingsRowBase(
        icon: icon,
        title: title,
        content: chevronView
    )
}

/// 创建链接行
public func link<Destination: View>(_ title: LocalizedStringKey, destination: Destination, icon: String? = nil) -> some View {
    NavigationLink(destination: destination) {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 24)
            }
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

