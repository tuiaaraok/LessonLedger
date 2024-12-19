import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @AppStorage("isLightTheme") var isLT: Bool = false
    
    private init() {}
}

extension Color {
    
    static var itemsBackground: Color {
        ThemeManager.shared.isLT ? .white : .black
    }
        
    static var toggleBackground: Color {
        ThemeManager.shared.isLT ? .mainLight : .white
    }
    
    static var mainAdd: Color {
        ThemeManager.shared.isLT ? .mainLight : .mainDark
    }

    static var mainText: Color {
        ThemeManager.shared.isLT ? .black : .white
    }
    
    static var background: Color {
        ThemeManager.shared.isLT ? .backgroundLight : .backgroundDark
    }
}



