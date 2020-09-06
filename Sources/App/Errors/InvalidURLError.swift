/// Error when the url is not valid
struct InvalidURLError: Error, CustomStringConvertible {
    var description: String

    init(url: String) {
        self.description = "\(url) is not a valid URL"
    }
}
