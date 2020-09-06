import Foundation

/// Error that can be thrown when something is not initialised
struct NotInitialisedError: Error, CustomStringConvertible {
    var description: String = "Not yet initialised"
}
