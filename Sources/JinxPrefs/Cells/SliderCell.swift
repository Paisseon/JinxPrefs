import Preferences

public struct SliderCell: JinxCell {
    private let name: String
    private let key: String
    private let defaultValue: Int
    private let range: Range<Int>
    
    public init(
        name: String,
        key: String,
        defaultValue: Int,
        range: Range<Int>
    ) {
        self.name = name
        self.key = key
        self.defaultValue = defaultValue
        self.range = range
    }
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let sliderCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: nil,
            cell: .sliderCell,
            edit: nil
        )
        
        sliderCell.identifier = key
        sliderCell.setProperty(key, forKey: "key")
        sliderCell.setProperty(defaultValue, forKey: "default")
        sliderCell.setProperty(range.lowerBound, forKey: "min")
        sliderCell.setProperty(range.upperBound, forKey: "max")
        sliderCell.setProperty(true, forKey: "showValue")
        sliderCell.setProperty(true, forKey: "isSegmented")
        sliderCell.setProperty(Metadata.package, forKey: "defaults")
        sliderCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        
        return sliderCell
    }
}
