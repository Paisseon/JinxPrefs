import Preferences

public struct ButtonCell: JinxCell {
    private let name: String
    private let action: Selector
    
    public init(
        name: String,
        action: Selector
    ) {
        self.name = name
        self.action = action
    }
    
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
