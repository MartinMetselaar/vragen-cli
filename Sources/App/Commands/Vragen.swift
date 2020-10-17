import Foundation
import ArgumentParser

public struct Vragen: ParsableCommand {

    public static var configuration = CommandConfiguration(
        subcommands: [
            Init.self, Current.self,
            Surveys.self, Questions.self, Answers.self
        ],
        defaultSubcommand: Current.self)

    public init() {}
}
