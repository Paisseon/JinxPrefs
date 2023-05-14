import Preferences

public struct ImageCell: JinxCell {
    public let name: String
    public let key: String
    public let defaultValue: String
    public let allowingPhotos: Bool
    public let allowingVideos: Bool
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let imageCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: #selector(PSListController.setPreferenceValue(_:specifier:)),
            get: #selector(PSListController.readPreferenceValue(_:)),
            detail: objc_lookUpClass("GcImagePickerCell"),
            cell: .linkCell,
            edit: nil
        )
        
        imageCell.identifier = key
        imageCell.setProperty(key, forKey: "key")
        imageCell.setProperty(defaultValue, forKey: "default")
        imageCell.setProperty(Metadata.package, forKey: "defaults")
        imageCell.setProperty(Metadata.package + ".prefschanged", forKey: "PostNotification")
        imageCell.setProperty(allowingPhotos, forKey: "usesPhotos")
        imageCell.setProperty(allowingVideos, forKey: "usesVideos")
        imageCell.setProperty(0, forKey: "videoQuality")
        
        return imageCell
    }
}
