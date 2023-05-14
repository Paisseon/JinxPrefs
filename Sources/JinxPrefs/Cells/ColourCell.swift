import Preferences

public struct ColourCell: JinxCell {
    public let name: String
    public let key: String
    public let defaultValue: String
    
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
        
        colourCell.identifier = key
        colourCell.setProperty(key, forKey: "key")
        colourCell.setProperty(defaultValue, forKey: "default")
        colourCell.setProperty(Metadata.package, forKey: "defaults")
        colourCell.setProperty(Metadata.package + ".prefsChanged", forKey: "PostNotification")
        colourCell.setProperty(true, forKey: "showAlphaSlider")
        
        return colourCell
    }
}
