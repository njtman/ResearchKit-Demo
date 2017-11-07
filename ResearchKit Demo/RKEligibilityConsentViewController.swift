//
//  EligibilityConsentViewController.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/6/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import UIKit
import ResearchKit

class RKEligibilityConsentViewController: UIViewController {

    private var consent: ResearchStudiesConsent?
    @IBAction func startConsentButton(_ sender: Any) {
        self.consent = ResearchStudiesConsent()
        let presenter = self
        self.consent?.presentConsentViewController(withPresentingViewController: presenter, completionHandler: { (taskViewController, reason, _) in
            if reason == .completed {
                taskViewController.dismiss(animated: true, completion: nil)
            } else if reason == .failed {
                taskViewController.dismiss(animated: true, completion: nil)
            } else if reason == .discarded {
                taskViewController.dismiss(animated: true, completion: nil)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
