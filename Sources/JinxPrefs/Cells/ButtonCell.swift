import Preferences

public struct ButtonCell: JinxCell {
    public let name: String
    public let action: Selector
    
    public func specifier(for target: PSListController) -> PSSpecifier {
        let buttonCell: PSSpecifier = .preferenceSpecifierNamed(
            name,
            target: target,
            set: nil,
            get: nil,
            detail: nil,
            cell: .buttonCell,
            edit: nil
        )
        
        buttonCell.buttonAction = action
        
        return buttonCell
    }
}
