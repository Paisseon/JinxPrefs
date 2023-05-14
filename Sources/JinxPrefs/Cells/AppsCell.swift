import Preferences

public struct AppsCell: JinxCell {
    public let name: String
    public let key: String
    public let defaultValue: Bool
    
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
