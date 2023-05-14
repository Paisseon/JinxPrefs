import Preferences

public struct GroupCell: JinxCell {
    private let name: String
    private let footerText: String
    
    public init(
        name: String,
        footerText: String
    ) {
        self.name = name
        self.footerText = footerText
    }
    
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
