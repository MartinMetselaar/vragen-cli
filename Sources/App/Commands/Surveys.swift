import Foundation
import ArgumentParser
import VragenAPIModels
import VragenSDKNetwork

struct Surveys: ParsableCommand {
    public static var configuration = CommandConfiguration(
    subcommands: [
        Create.self, List.self, Get.self, GetWithChildren.self, Update.self, Delete.self
    ],
    defaultSubcommand: List.self)

    struct List: ParsableCommand {
        @Option(help: "Page index") var page: Int?
        @Option(help: "Number of items") var per: Int?
        
        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.list(page: page, per: per)
            switch result {
                case .success(let page):
                    log(surveys: page.items)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Create: ParsableCommand {
        @Option var title: String

        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.create(title: title)

            switch result {
                case .success(let survey):
                    log(survey: survey)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Get: ParsableCommand {
        @Option(help: "Survey identifier") var identifier: String

        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.get(identifier: identifier)
            switch result {
                case .success(let survey):
                    log(survey: survey)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct GetWithChildren: ParsableCommand {
        @Option(help: "Survey identifier") var identifier: String

        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.getWithChildren(identifier: identifier)
            switch result {
                case .success(let survey):
                    log(survey: survey)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Update: ParsableCommand {
        @Option(help: "Survey identifier") var identifier: String
        @Option var title: String

        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.update(identifier: identifier, title: title)

            switch result {
                case .success(let survey):
                    log(survey: survey)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Delete: ParsableCommand {
        @Option(help: "Survey identifier") var identifier: String

        mutating func run() throws {
            let client = try SurveySynchroniseNetwork()
            let result = client.delete(identifier: identifier)
            switch result {
                case .success(let result):
                    print("Succesfully deleted \(identifier): \(result)")
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}

extension SurveySynchroniseNetwork {
    convenience init() throws {
        guard
            let server = UserDefaults.standard.string(forKey: .serverKey),
            let serverUrl = URL(string: server),
            let token = UserDefaults.standard.string(forKey: .tokenKey)
            else {
                throw NotInitialisedError()

        }
        self.init(server: serverUrl, token: token)
    }
}
