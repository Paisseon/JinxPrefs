import Preferences

@available(iOS 14, *)
public struct ImageCell: JinxCell {
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
        let imageCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: ImagePickerView.self,
            cell: .linkCell,
            edit: nil
        )
        
        imageCell.setProperty(ImagePickerView.self, forKey: "cellClass")
        imageCell.identifier = key
        imageCell.setProperty(key, forKey: "key")
        imageCell.setProperty(Metadata.package, forKey: "defaults")
        imageCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        
        return imageCell
    }
}
