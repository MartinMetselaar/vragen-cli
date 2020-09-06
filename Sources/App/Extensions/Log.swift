import VragenAPIModels

/// Need to implement this in a different way. Let me know if you have any ideas.

// MARK: - Survey
func log(surveys: [SurveyResponse]) {
    for (index, element) in surveys.enumerated() {
        log(index: index, survey: element)
    }
}

func log(survey: SurveyResponse) {
    print("\(survey.title) (\(survey.id))")
}

func log(index: Int, survey: SurveyResponse) {
    print("\(index): \(survey.title) (\(survey.id))")
}

func log(survey: SurveyWithQuestionsResponse) {
    print("\(survey.title) (\(survey.id))")
    for (index, element) in survey.questions.enumerated() {
        log(questionIndex: index, question: element)
    }
}

func log(questionIndex: Int, question: QuestionWithAnswersResponse) {
    print("\(questionIndex): \(question.title) (\(question.id))")
    for (index, element) in question.answers.enumerated() {
        log(questionIndex: questionIndex, answerIndex: index, answer: element)
    }
}

func log(questionIndex: Int, answerIndex: Int, answer: AnswerResponse) {
    print("\(questionIndex)-\(answerIndex): \(answer.title) (\(answer.id))")
}

func log(questions: [QuestionResponse]) {
    for (index, element) in questions.enumerated() {
        log(index: index, question: element)
    }
}

// MARK: - Questions

func log(question: QuestionResponse) {
    print("\(question.title) (\(question.id))")
}

func log(index: Int, question: QuestionResponse) {
    print("\(index): \(question.title) (\(question.id))")
}

func log(question: QuestionWithAnswersResponse) {
    print("\(question.title) (\(question.id))")
    for (index, element) in question.answers.enumerated() {
        log(answerIndex: index, answer: element)
    }
}

func log(answerIndex: Int, answer: AnswerResponse) {
    print("\(answerIndex): \(answer.title) (\(answer.id))")
}

// MARK: - Answers

func log(answers: [AnswerResponse]) {
    for (index, element) in answers.enumerated() {
        log(index: index, answer: element)
    }
}

func log(index: Int, answer: AnswerResponse) {
    print("\(index): \(answer.title) (\(answer.id))")
}

func log(answer: AnswerResponse) {
    print("\(answer.title) (\(answer.id))")
}
