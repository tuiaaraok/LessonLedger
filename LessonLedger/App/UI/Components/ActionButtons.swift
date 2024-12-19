import SwiftUI

@available(iOS 16.0, *)
struct ActionButtons: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let cancelButtonAction: () -> Void
    let saveButtonAction: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: cancelButtonAction) {
            Text("Cancel")
                .padding(14)
                .customFont(.actionButtonsText)
                .foregroundStyle(Color.mainAdd)
                .frame(maxWidth: 116, maxHeight: 52)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.mainAdd, lineWidth: 1)
                )
            }
            Button(action: saveButtonAction) {
            Text("Save")
                .padding(13)
                .customFont(.actionButtonsText)
                .foregroundStyle(Color.background)
                .frame(maxWidth: 116, maxHeight: 52)
                .background(Color.mainAdd)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.mainAdd, lineWidth: 1)
                )
            }
        }
    }
}
