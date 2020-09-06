import Foundation
import ArgumentParser

struct Init: ParsableCommand {
    @Option var server: String
    @Option var token: String

    mutating func run() throws {
        guard let _ = URL(string: server) else {
            throw InvalidURLError(url: server)
        }

        UserDefaults.standard.set(server, forKey: .serverKey)
        UserDefaults.standard.set(token, forKey: .tokenKey)

        print("Stored token for \(server)")
    }
}
