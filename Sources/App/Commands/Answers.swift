import Foundation
import ArgumentParser
import VragenAPIModels
import VragenSDKNetwork

struct Answers: ParsableCommand {
    public static var configuration = CommandConfiguration(
    subcommands: [
        Create.self, List.self, Get.self, Update.self, Delete.self
    ],
    defaultSubcommand: List.self)

    struct List: ParsableCommand {
        @Option(help: "Survey identifier") var survey: String
        @Option(help: "Question identifier") var question: String

        @Option(help: "Page index") var page: Int?
        @Option(help: "Number of items") var per: Int?

        mutating func run() throws {
            let client = try AnswerSynchroniseNetwork()
            let result = client.list(surveyId: survey, questionId: question, page: page, per: per)
            switch result {
                case .success(let page):
                    log(answers: page.items)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Create: ParsableCommand {
        @Option(help: "Survey identifier") var survey: String
        @Option(help: "Question identifier") var question: String
        @Option var title: String

        mutating func run() throws {
            let client = try AnswerSynchroniseNetwork()
            let result = client.create(surveyId: survey, questionId: question, title: title)

            switch result {
                case .success(let answer):
                    log(answer: answer)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Get: ParsableCommand {
        @Option(help: "Survey identifier") var survey: String
        @Option(help: "Question identifier") var question: String
        @Option(help: "Answer identifier") var identifier: String

        mutating func run() throws {
            let client = try AnswerSynchroniseNetwork()
            let result = client.get(surveyId: survey, questionId: question, identifier: identifier)
            switch result {
                case .success(let answer):
                    log(answer: answer)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Update: ParsableCommand {
        @Option(help: "Survey identifier") var survey: String
        @Option(help: "Question identifier") var question: String
        @Option(help: "Answer identifier") var identifier: String
        @Option var title: String

        mutating func run() throws {
            let client = try AnswerSynchroniseNetwork()
            let result = client.update(surveyId: survey, questionId: question, identifier: identifier, title: title)

            switch result {
                case .success(let answer):
                    log(answer: answer)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

    struct Delete: ParsableCommand {
        @Option(help: "Survey identifier") var survey: String
        @Option(help: "Question identifier") var question: String
        @Option(help: "Answer identifier") var identifier: String

        mutating func run() throws {
            let client = try AnswerSynchroniseNetwork()
            let result = client.delete(surveyId: survey, questionId: question, identifier: identifier)
            switch result {
                case .success(let result):
                    print("Succesfully deleted \(identifier): \(result)")
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}

private extension AnswerSynchroniseNetwork {
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
