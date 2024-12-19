import SwiftUI

enum MainFlowTab {
    case home
    case homework
    case addLesson
    case settings
}

@available(iOS 16.0, *)
struct MainFlow: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var currentTab: MainFlowTab = .home

    private var buttons: [TabBarButtonConfiguration] {
        [
            TabBarButtonConfiguration(systemIconName: "house", title: "Home", tab: .home),
            TabBarButtonConfiguration(systemIconName: "briefcase.fill", title: "Homework", tab: .homework),
            TabBarButtonConfiguration(systemIconName: "note.text.badge.plus", title: "Add lesson", tab: .addLesson),
            TabBarButtonConfiguration(systemIconName: "gearshape", title: "Settings", tab: .settings)
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeFlow()
                    .tag(MainFlowTab.home)
                HomeworkFlow()
                    .tag(MainFlowTab.homework)
                AddLessonFlow()
                    .tag(MainFlowTab.addLesson)
                SettingsFlow()
                    .tag(MainFlowTab.settings)
            }
            
            TabBar(currentTab: $currentTab, buttons: buttons)
                
        }
    }
}

@available(iOS 16.0, *)
private struct TabBar: View {
    @Binding var currentTab: MainFlowTab
    let buttons: [TabBarButtonConfiguration]
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(buttons.enumerated()), id: \.element.id) { (index, button) in
                let style: TabBarButtonStyle = button.tab == currentTab
                ? .active(backgroundColor: Color.mainAdd)
                : .unactive(backgroundColor: Color.addText)
                
                TabBarButton(
                    configuration: button,
                    style: style,
                    action: { currentTab = button.tab }
                )
            }
        }
    }
}

private struct TabBarButtonConfiguration: Identifiable {
    var id: MainFlowTab { tab }
    
    let systemIconName: String
    let title: String
    let tab: MainFlowTab
}

private struct TabBarButtonStyle {
    let backgroundColor: Color
    
    static func active(backgroundColor: Color) -> TabBarButtonStyle {
        TabBarButtonStyle(backgroundColor: backgroundColor)
    }
    static func unactive(backgroundColor: Color) -> TabBarButtonStyle {
        TabBarButtonStyle(backgroundColor: backgroundColor)
    }
}

@available(iOS 16.0, *)
private struct TabBarButton: View {
    let configuration: TabBarButtonConfiguration
    let style: TabBarButtonStyle
    let action: () -> Void
    
    var body: some View {
        let height = 56.0
        Button {
            action()
        } label: {
            VStack(spacing: 2) {
                Image(systemName: configuration.systemIconName)
                Text(configuration.title)
                    .customFont(.tabBarText)
                    .lineLimit(1)
            }
            .foregroundStyle(style.backgroundColor)
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(Color.itemsBackground)
        }
    }
}
