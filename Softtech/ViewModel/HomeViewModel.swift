import Foundation

class HomeViewModel {

    /// String to array function.
    /// - Parameters:
    ///     - jsonText: json data.
    /// - Returns: A string array contains picker view options.
    func refactorJsonString(jsonText: String) -> [String] {
        var text = jsonText
        text.remove(at: text.startIndex)
        text.remove(at: text.index(before: text.endIndex))
        return text.components(separatedBy: ",")
    }

    /// Read and decode json file..
    /// - Parameters:
    ///     - filename: file name of json file.
    /// - Returns: Optional Custom View model.
    func fetchData(filename fileName: String) -> [CustomView]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CustomView].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
