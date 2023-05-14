import Preferences

public struct GroupCell: JinxCell {
    public let name: String
    public let footerText: String
    
    public init() {}
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let groupCell: PSSpecifier = .emptyGroup()
        
        groupCell.name = name
        groupCell.identifier = name
        
        if !footerText.isEmpty {
            groupCell.setProperty(footerText, forKey: "footerText")
        }
        
        return groupCell
    }
}
