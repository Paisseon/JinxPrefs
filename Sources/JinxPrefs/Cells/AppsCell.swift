import Preferences

public struct AppsCell: JinxCell {
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
        let appsCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: objc_lookUpClass("ATLApplicationListMultiSelectionController"),
            cell: .linkListCell,
            edit: nil
        )
        
        appsCell.identifier = key
        appsCell.setProperty(key, forKey: "key")
        appsCell.setProperty(defaultValue, forKey: "defaultApplicationSwitchValue")
        appsCell.setProperty(Metadata.package, forKey: "defaults")
        appsCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        appsCell.setProperty(true, forKey: "showIdentifiersAsSubtitle")
        appsCell.setProperty(true, forKey: "includeIdentifiersInSearch")
        appsCell.setProperty(true, forKey: "useSearchBar")
        appsCell.setProperty(NSArray(array: [["sectionType": "User"]]), forKey: "sections")
        
        return appsCell
    }
}
