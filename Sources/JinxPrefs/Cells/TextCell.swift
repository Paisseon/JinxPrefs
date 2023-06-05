import Preferences

public struct TextCell: JinxCell {
    private let name: String
    private let key: String
    private let defaultValue: String
    private let isSecure: Bool
    
    public init(
        name: String,
        key: String,
        defaultValue: String,
        isSecure: Bool
    ) {
        self.name = name
        self.key = key
        self.defaultValue = defaultValue
        self.isSecure = isSecure
    }
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let textCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: nil,
            cell: isSecure ? .secureEditTextCell : .editTextCell,
            edit: nil
        )
        
        textCell.identifier = key
        textCell.setProperty(key, forKey: "key")
        textCell.setProperty(defaultValue, forKey: "default")
        textCell.setProperty(Metadata.package, forKey: "defaults")
        textCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        
        return textCell
    }
}
