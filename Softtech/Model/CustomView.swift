import Foundation

// MARK: - CustomView
struct CustomView: Decodable {
    let customViewType: String?
    let properties: Properties?

    enum CodingKeys: String, CodingKey {
        case customViewType = "CustomViewType"
        case properties
    }
}

// MARK: - Properties
struct Properties: Decodable {
    let text,header: String?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case header = "Header"
    }
}

// MARK: - Custom View Type Enum
enum ViewType: String {
    case button = "Button"
    case label = "Label"
    case textField = "TextField"
    case picker = "PickerView"
}
