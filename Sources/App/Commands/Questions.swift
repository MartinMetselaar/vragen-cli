import Foundation
import ArgumentParser
import VragenSDKNetwork

struct Questions: ParsableCommand {
    public static var configuration = CommandConfiguration(
    subcommands: [
        Create.self, List.self, Get.self, Update.self, Delete.self
    ],
    defaultSubcommand: List.self)

    struct List: ParsableCommand {
        @Option(help: "Survey identifier as UUID") var survey: UUID

        @Option(help: "Page index") var page: Int?
        @Option(help: "Number of items") var per: Int?

        mutating func run() throws {
            let client = try QuestionSynchroniseNetwork()
            let result = client.list(surveyId: survey, page: page, per: per)
            switch result {
                case .success(let page):
                    log(questions: page.items)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Create: ParsableCommand {
        @Option(help: "Survey identifier as UUID") var survey: UUID
        @Option var title: String

        mutating func run() throws {
            let client = try QuestionSynchroniseNetwork()
            let result = client.create(surveyId: survey, title: title)

            switch result {
                case .success(let question):
                    log(question: question)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Get: ParsableCommand {
        @Option(help: "Survey identifier as UUID") var survey: UUID
        @Option(help: "Question identifier as UUID") var identifier: UUID

        mutating func run() throws {
            let client = try QuestionSynchroniseNetwork()
            let result = client.get(surveyId: survey, identifier: identifier)
            switch result {
                case .success(let question):
                    log(question: question)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Update: ParsableCommand {
        @Option(help: "Survey identifier as UUID") var survey: UUID
        @Option(help: "Question identifier as UUID") var identifier: UUID
        @Option var title: String

        mutating func run() throws {
            let client = try QuestionSynchroniseNetwork()
            let result = client.update(surveyId: survey, identifier: identifier, title: title)

            switch result {
                case .success(let question):
                    log(question: question)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Delete: ParsableCommand {
        @Option(help: "Survey identifier as UUID") var survey: UUID
        @Option(help: "Question identifier as UUID") var identifier: UUID

        mutating func run() throws {
            let client = try QuestionSynchroniseNetwork()
            let result = client.delete(surveyId: survey, identifier: identifier)
            switch result {
                case .success(let result):
                    print("Succesfully deleted \(identifier): \(result)")
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}

extension QuestionSynchroniseNetwork {
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
