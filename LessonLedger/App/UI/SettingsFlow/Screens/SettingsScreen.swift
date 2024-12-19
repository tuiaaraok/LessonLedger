import SwiftUI

@available(iOS 16.0, *)
struct SettingsScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    private let storage = Storage.shared
    var body: some View {
        VStack(spacing: 0) {
            AppThemeToggle()
                .padding(.top, 308)
            
            VStack(spacing: 0) {
                SettingsButton(text: "Contact Us", action: { sendEmail(storage.email) })
                SettingsButton(text: "Privacy Policy", action: { openPrivacy(storage.privacyPolicyUrl) })
                SettingsButton(text: "Rate Us", action: { openRate(storage.appId) })
            }
            .padding(.top, 91)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background).ignoresSafeArea()
    }
    func openRate(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openPrivacy(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func sendEmail(_ email: String) {
        if let url = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}



@available(iOS 16.0, *)
private struct AppThemeToggle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HStack(spacing: 0) {
            Text(themeManager.isLT ? "Dark Mode" : "Light Mode")
                .customFont(.mainText)
                .foregroundStyle(Color.mainText)
                .padding(.leading, 21)
            Spacer()
            Toggle(isOn: $themeManager.isLT) {}
                .toggleStyle(AppToggleStyle())
                .padding(9)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .background(Color.itemsBackground)
    }
}

private struct AppToggleStyle: ToggleStyle {
    @EnvironmentObject var themeManager: ThemeManager
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.toggleBackground)
                .frame(width: 50, height: 25)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(3)
                        .shadow(color: Color.black, radius: 2, x: configuration.isOn ? -1 : 1, y: 1)
                        .offset(x: configuration.isOn ? 12 : -12)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

@available(iOS 16.0, *)
private struct SettingsButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            HStack(spacing: 0) {
                Text(text)
                    .customFont(.mainText)
                    .foregroundStyle(Color.mainText)
                    .padding(.leading, 21)
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(width: 21, height: 21)
                    .foregroundStyle(Color.addLight)
                    .padding(9)
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color.itemsBackground)
        }
    }
}
