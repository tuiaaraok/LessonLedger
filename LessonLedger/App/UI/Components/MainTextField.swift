import SwiftUI

@available(iOS 16.0, *)
struct MainTextField: View {
    @EnvironmentObject var themeManager: ThemeManager
    var title: String
    @Binding var text: String
    var placeholder: String = ""
    var axis: Axis = .horizontal
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(title)
                .customFont(.mainText)
                .foregroundColor(Color.mainText)
            TextField(text: $text, axis: axis) {
                Text(placeholder)
                    .customFont(.mainText)
                    .foregroundStyle(Color.mainText)
                    .keyboardType(keyboardType)
            }
            .foregroundStyle(Color.mainText)
            .customFont(.mainText)
            .padding(19)
            .background(Color.itemsBackground)
            .frame(maxHeight: 43)
                        .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.addLight, lineWidth: 1)
            )
        }
    }
}
