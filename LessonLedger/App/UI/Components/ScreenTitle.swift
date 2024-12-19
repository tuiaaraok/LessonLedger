import SwiftUI

@available(iOS 16.0, *)
struct ScreenTitle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let text: String
    
    var body: some View {
        Text(text)
            .customFont(.titleText)
            .foregroundStyle(Color.mainText)
            .padding(.top, 34)
    }
}

