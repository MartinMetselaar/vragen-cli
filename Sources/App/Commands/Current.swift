import Foundation
import ArgumentParser

struct Current: ParsableCommand {
    mutating func run() throws {
        guard let server = UserDefaults.standard.string(forKey: .serverKey) else {
            throw NotInitialisedError()
        }

        print("Currently initialised for \(server)")
    }
}
