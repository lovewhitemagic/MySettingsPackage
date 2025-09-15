import SwiftUI

// MARK: - 状态类型
public enum StatusKind {
    case checkmark
    case warning
}

// MARK: - 右侧组件类型
public enum RowAccessory {
    case none
    case toggle(binding: Binding<Bool>)
    case picker(selection: Binding<Int>, options: [String])
    case colorPicker(binding: Binding<Color>)
    case slider(binding: Binding<Double>, range: ClosedRange<Double>)
    case stepper(binding: Binding<Int>, range: ClosedRange<Int>)
    case status(kind: StatusKind)
}

// MARK: - 数据驱动行模型
public struct SettingsRowModel: Identifiable {
    public let id = UUID()
    public let icon: String?      // 可选
    public let title: LocalizedStringKey
    public let chevron: Bool      // 是否显示右侧箭头
    public let accessory: RowAccessory
    
    public init(icon: String? = nil,
                title: LocalizedStringKey,
                chevron: Bool = false,
                accessory: RowAccessory = .none) {
        self.icon = icon
        self.title = title
        self.chevron = chevron
        self.accessory = accessory
    }
}

// MARK: - 通用行组件
public struct SettingsRowView: View {
    let row: SettingsRowModel
    
    public init(_ row: SettingsRowModel) {
        self.row = row
    }
    
    public var body: some View {
        HStack {
            if let icon = row.icon {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 24)
            }
            
            Text(row.title)
                .foregroundColor(.primary)
            
            Spacer()
            
            switch row.accessory {
            case .none:
                if row.chevron {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            case let .toggle(binding):
                Toggle("", isOn: binding).labelsHidden()
            case let .picker(selection, options):
                Picker("", selection: selection) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index]).tag(index)
                    }
                }
                .pickerStyle(.menu)
            case let .colorPicker(binding):
                ColorPicker("", selection: binding)
                    .labelsHidden()
            case let .slider(binding, range):
                Slider(value: binding, in: range)
                    .frame(width: 120)
            case let .stepper(binding, range):
                Stepper(value: binding, in: range) {
                    Text("\(binding.wrappedValue)")
                }
                .frame(width: 120)
            case let .status(kind):
                switch kind {
                case .checkmark:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                case .warning:
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.orange)
                        .font(.caption)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Section
public struct SettingsSectionView: View {
    let title: LocalizedStringKey
    let rows: [SettingsRowModel]
    
    public init(title: LocalizedStringKey, rows: [SettingsRowModel]) {
        self.title = title
        self.rows = rows
    }
    
    public var body: some View {
        Section(title) {
            ForEach(rows) { row in
                SettingsRowView(row)
            }
        }
    }
}

// MARK: - SettingsList
public struct SettingsList<Content: View>: View {
    @ViewBuilder let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack {
            List {
                content
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - 泛型 Link Row
public struct SettingsLinkRow<Destination: View>: View {
    let icon: String?
    let title: LocalizedStringKey
    let destination: Destination
    
    public init(icon: String? = nil, title: LocalizedStringKey, destination: Destination) {
        self.icon = icon
        self.title = title
        self.destination = destination
    }
    
    public var body: some View {
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
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.vertical, 6)
        }
    }
}

