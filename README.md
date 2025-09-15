# MySettingsPackage

一个用于 SwiftUI 的设置界面组件库，提供灵活且易用的设置页面构建工具。

## 特性

- 🎯 **数据驱动**：使用模型驱动的方式构建设置行
- 🔧 **多种组件**：支持开关、选择器、颜色选择器、滑块、步进器等
- 🔗 **混合行类型**：在同一个 Section 中混合使用普通行和链接行
- 📱 **原生体验**：完全基于 SwiftUI，提供原生的用户体验
- 🎨 **高度定制**：支持图标、状态指示器等自定义元素

## 安装

在 Xcode 中，通过 Swift Package Manager 添加此包：

```
https://github.com/your-username/MySettingsPackage
```

## 使用示例

```swift
import SwiftUI
import MySettingsPackage

struct ContentView: View {
    @State private var notificationsEnabled = true
    @State private var selectedTheme = 0
    @State private var accentColor = Color.blue
    @State private var fontSize: Double = 16
    @State private var maxItems = 10
    
    var body: some View {
        SettingsList {
            // 通知与同步 Section
            SettingsSectionView("通知与同步") {
                toggle("推送通知", binding: $notificationsEnabled, icon: "bell")
                status("同步状态", kind: .checkmark, icon: "icloud")
                link("通知详细设置", destination: NotificationDetailView(), icon: "bell.badge")
            }
            
            // 外观设置 Section
            SettingsSectionView("外观") {
                picker("主题", selection: $selectedTheme, options: ["浅色", "深色", "自动"], icon: "paintbrush")
                colorPicker("强调色", binding: $accentColor, icon: "paintpalette")
                link("字体设置", destination: FontSettingsView(), icon: "textformat")
            }
            
            // 内容设置 Section
            SettingsSectionView("内容") {
                slider("字体大小", binding: $fontSize, range: 12...24, icon: "textformat.size")
                stepper("最大显示项目", binding: $maxItems, range: 5...50, icon: "number")
                status("数据完整性", kind: .warning, icon: "exclamationmark.triangle")
            }
            
            // 关于 Section
            SettingsSectionView("关于") {
                link("应用信息", destination: AboutView(), icon: "info.circle")
                link("使用条款", destination: TermsView(), icon: "doc.text")
                link("隐私政策", destination: PrivacyView(), icon: "lock.shield")
                row("版本信息", icon: "info")
            }
        }
    }
}

// 示例目标视图
struct NotificationDetailView: View {
    var body: some View {
        Text("通知详细设置")
            .navigationTitle("通知设置")
    }
}

struct FontSettingsView: View {
    var body: some View {
        Text("字体设置")
            .navigationTitle("字体")
    }
}

struct AboutView: View {
    var body: some View {
        Text("关于应用")
            .navigationTitle("关于")
    }
}

struct TermsView: View {
    var body: some View {
        Text("使用条款")
            .navigationTitle("条款")
    }
}

struct PrivacyView: View {
    var body: some View {
        Text("隐私政策")
            .navigationTitle("隐私")
    }
}
```

### 向后兼容的数组方式

```swift
// 仍然支持原有的数组方式
let notificationRows = [
    SettingsRowModel(
        icon: "bell",
        title: "推送通知",
        accessory: .toggle(binding: $isNotificationEnabled)
    ),
    SettingsRowModel(
        icon: "bell.slash",
        title: "勿扰模式",
        accessory: .toggle(binding: $doNotDisturb)
    )
]

SettingsSectionView(title: "通知", rows: notificationRows)
```

## DSL 便利函数

我们提供了一系列便利函数：

### 控件函数

- `toggle(_:binding:icon:)` - 创建开关行
- `picker(_:selection:options:icon:)` - 创建选择器行
- `colorPicker(_:binding:icon:)` - 创建颜色选择器行
- `slider(_:binding:range:icon:)` - 创建滑块行
- `stepper(_:binding:range:icon:)` - 创建步进器行
- `status(_:kind:icon:)` - 创建状态指示器行
- `row(_:icon:chevron:)` - 创建普通行（可选箭头）
- `link(_:destination:icon:)` - 创建导航链接行

### 使用示例

```swift
// 开关
toggle("推送通知", binding: $notificationsEnabled, icon: "bell")

// 选择器
picker("主题", selection: $selectedTheme, options: ["浅色", "深色", "自动"], icon: "paintbrush")

// 颜色选择器
colorPicker("强调色", binding: $accentColor, icon: "paintpalette")

// 滑块
slider("字体大小", binding: $fontSize, range: 12...24, icon: "textformat.size")

// 步进器
stepper("最大项目", binding: $maxItems, range: 5...50, icon: "number")

// 状态指示器
status("同步状态", kind: .checkmark, icon: "icloud")
status("网络状态", kind: .warning, icon: "wifi.slash")

// 普通行
row("版本信息", icon: "info")

// 链接行
link("设置详情", destination: DetailView(), icon: "gear")
```

## 组件说明

### SettingsList
主容器视图，用于包装所有设置 Section。

### SettingsSectionView
设置 Section 视图，使用 `@ViewBuilder` 语法，可以在同一个 Section 中自由组合不同类型的行。

### SettingsRowBase
基础设置行视图，支持多种配件类型（开关、选择器、颜色选择器等）。

### SettingsLinkRow
链接行视图，点击后可以导航到其他视图。



## 许可证

MIT License