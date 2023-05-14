import Preferences

public struct ImageCell: JinxCell {
    private let name: String
    private let key: String
    private let defaultValue: String
    private let allowingPhotos: Bool
    private let allowingVideos: Bool
    
    public init(
        name: String,
        key: String,
        defaultValue: String,
        allowingPhotos: Bool,
        allowingVideos: Bool
    ) {
        self.name = name
        self.key = key
        self.defaultValue = defaultValue
        self.allowingPhotos = allowingPhotos
        self.allowingVideos = allowingVideos
    }
    
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
