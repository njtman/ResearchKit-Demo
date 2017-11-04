//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit

class RKIntroViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!

    private var consent: ResearchStudiesConsent?
    @IBAction func joinStudy(_ sender: UIButton) {
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

    var introPageViewController: PageViewController? {
        didSet {
            introPageViewController?.pageViewDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.addTarget(self, action: #selector(RKIntroViewController.didChangePageControlValue), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let introPageViewController = segue.destination as? PageViewController {
            self.introPageViewController = introPageViewController
        }
    }

    @IBAction func didTapNextButton(_ sender: UIButton) {
        introPageViewController?.scrollToNextViewController()
    }

    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        introPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension RKIntroViewController: PageViewControllerDelegate {

    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }

}
