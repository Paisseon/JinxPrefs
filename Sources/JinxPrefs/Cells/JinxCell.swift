import Preferences

public protocol JinxCell {
    var name: String { get }
    func specifier(for target: PSListController) -> PSSpecifier
}
