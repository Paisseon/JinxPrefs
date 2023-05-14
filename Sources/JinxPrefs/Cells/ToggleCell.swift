import Preferences

public struct ToggleCell: JinxCell {
    private let name: String
    private let key: String
    private let defaultValue: Bool
    
    public init(
        name: String,
        key: String,
        defaultValue: Bool
    ) {
        self.name = name
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let toggleCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: nil,
            cell: .switchCell,
            edit: nil
        )
        
        toggleCell.identifier = key
        toggleCell.setProperty(key, forKey: "key")
        toggleCell.setProperty(defaultValue, forKey: "default")
        toggleCell.setProperty(Metadata.package, forKey: "defaults")
        toggleCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        
        return toggleCell
    }
}
