//
//  EligibilityViewController.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/5/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import UIKit

class RKEligibilityQuestionnaireViewController: UIViewController {

    @IBOutlet weak var nextButton: UIBarButtonItem!

    @IBAction func tapNextButton(_ sender: Any) {

    }
    @IBOutlet weak var yes1: UILabel!
    @IBOutlet weak var no1: UILabel!

    @IBOutlet weak var yes2: UILabel!
    @IBOutlet weak var no2: UILabel!

    @IBOutlet weak var yes3: UILabel!
    @IBOutlet weak var no3: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = true
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
