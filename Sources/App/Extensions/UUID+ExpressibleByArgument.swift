import Foundation
import ArgumentParser

extension UUID: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(uuidString: argument)
    }
}
