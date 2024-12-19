import Foundation
import SwiftUI

enum CustomFonts: String {
    case Commissioner = "Commissioner"
    
}

struct FontBuilder {
    
    let font: Font
    let tracking: Double
    let lineSpacing: Double
    let verticalPadding: Double
    
    init(
        customFont: CustomFonts,
        fontSize: Double,
        weight: Font.Weight = .regular,
        letterSpacing: Double = 0,
        lineHeight: Double
    ) {
        self.font = Font.custom(customFont, size: fontSize).weight(weight)
        self.tracking = fontSize * letterSpacing

        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = self.lineSpacing / 2
    }
    
}

extension FontBuilder {
    
    static let titleText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 22,
        weight: .semibold,
        lineHeight: 26
    )
    
    static let calendarDateText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 34,
        weight: .bold,
        lineHeight: 34
    )
    
    static let addText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 14,
        weight: .regular,
        lineHeight: 16
    )
    
    static let mainText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 16,
        weight: .regular,
        lineHeight: 18
    )
    
    static let actionButtonsText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 16,
        weight: .semibold,
        lineHeight: 19
    )
    
    static let tabBarText = FontBuilder(
        customFont: .Commissioner,
        fontSize: 11,
        weight: .medium,
        lineHeight: 13
    )
}

extension Font {
    static func custom(_ fontName: CustomFonts, size: Double) -> Font {
        Font.custom(fontName.rawValue, size: size)
    }
}


@available(iOS 16.0, *)
struct CustomFontsModifire: ViewModifier {

    private let fontBuilder: FontBuilder

    init(_ fontBuilder: FontBuilder) {
        self.fontBuilder = fontBuilder
    }

    func body(content: Content) -> some View {
        content
            .font(fontBuilder.font)
            .lineSpacing(fontBuilder.lineSpacing)
            .padding([.vertical], fontBuilder.verticalPadding)
            .tracking(fontBuilder.tracking)
    }

}

@available(iOS 16.0, *)
extension View {
    func customFont(_ fontBuilder: FontBuilder) -> some View {
        modifier(CustomFontsModifire(fontBuilder))
    }
}

