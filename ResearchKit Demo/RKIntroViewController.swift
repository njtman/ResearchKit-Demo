//
//  RKIntroViewController.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/4/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import UIKit

class RKIntroViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!

    var introPageViewController: RKIntroPageViewController? {
        didSet {
            introPageViewController?.pageViewDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.addTarget(self, action: #selector(RKIntroViewController.didChangePageControlValue), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let introPageViewController = segue.destination as? RKIntroPageViewController {
            self.introPageViewController = introPageViewController
        }
    }

    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        introPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension RKIntroViewController: RKIntroPageViewControllerDelegate {

    func pageViewController(_ pageViewController: RKIntroPageViewController,
                            didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func pageViewController(_ pageViewController: RKIntroPageViewController,
                            didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }

}
