//
//  ResearchStudiesConsent.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/4/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import Foundation
import ResearchKit

final class ResearchStudiesConsent: NSObject {

    private let consent = ORKConsentDocument()
    private var steps = [ORKStep]()
    fileprivate var completionHandler: ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> Void)?

    override init() {
        super.init()
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        signature.requiresName = false
        signature.requiresSignatureImage = false
        consent.addSignature(signature)
        setupConsentSections()
        setupConsentSteps(withSignature: signature)
    }

    func presentConsentViewController(withPresentingViewController presenter: UIViewController,
                                      completionHandler: @escaping ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> Void)) {
        self.completionHandler = completionHandler
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: steps)
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        presenter.present(taskViewController, animated: true, completion: nil)
    }

    private func setupConsentSections() {
        let dataGathering = ORKConsentSection(type: .dataGathering)
        dataGathering.title = "Data Gathering"
        dataGathering.summary = "Summary"
        dataGathering.content = "Content"

        let dataProcessing = ORKConsentSection(type: .dataGathering)
        dataProcessing.title = "Data Processing"
        dataProcessing.summary = "Summary"
        dataProcessing.content = "Content"

        let privacy = ORKConsentSection(type: .privacy)
        privacy.title = "Data Privacy"
        privacy.summary = "Summary"

        let timeCommitment = ORKConsentSection(type: .timeCommitment)
        timeCommitment.title = "Time Commitment and Withdrawal"
        timeCommitment.summary = "Summary"

        let benefits = ORKConsentSection(type: .custom)
        benefits.title = "Potential Benefits"
        benefits.summary = "Summary"

        let risks = ORKConsentSection(type: .custom)
        risks.title = "Anticipated Risks and Potential Side Effects"
        risks.summary = "Summary"

        consent.sections = [dataGathering, dataProcessing, privacy, timeCommitment, benefits, risks]
    }

    private func setupConsentSteps(withSignature signature: ORKConsentSignature) {
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consent)

        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consent)
        reviewConsentStep.text = "Text"
        reviewConsentStep.reasonForConsent = "Reason for consent"

        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Title"
        completionStep.text = "Text"

        steps.append(consentStep)
        steps.append(reviewConsentStep)
        steps.append(completionStep)
    }

    private func getContentsFromBundleFile(fileName name: String, fileType type: String) -> String {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let contents = try String(contentsOfFile: path)
                return contents
            } catch {
                print(error)
            }
        } else {
            print("File \(name).\(type) not found in main bundle")
        }
        return ""
    }
}

extension ResearchStudiesConsent: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        self.completionHandler?(taskViewController, reason, error)
    }
}

