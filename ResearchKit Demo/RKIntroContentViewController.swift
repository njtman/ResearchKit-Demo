//
//  RKIntroContentViewController.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/7/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import UIKit

class RKIntroContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var pageIndex: Int = 0
    var titleString: String!
    var contentString: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleString
        contentLabel.text = contentString
    }
}
