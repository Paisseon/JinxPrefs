import Preferences

public struct ColourCell: JinxCell {
    private let name: String
    private let key: String
    private let defaultValue: String
    
    public init(
        name: String,
        key: String,
        defaultValue: String
    ) {
        self.name = name
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let colourCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: objc_lookUpClass("HBColorPickerTableCell"),
            cell: .linkCell,
            edit: nil
        )
        
        colourCell.setProperty(objc_lookUpClass("HBColorPickerTableCell"), forKey: "cellClass")
        colourCell.identifier = key
        colourCell.setProperty(key, forKey: "key")
        colourCell.setProperty(defaultValue, forKey: "default")
        colourCell.setProperty(Metadata.package, forKey: "defaults")
        colourCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        colourCell.setProperty(true, forKey: "showAlphaSlider")
        
        return colourCell
    }
}
