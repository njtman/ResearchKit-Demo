//
//  PageViewController.swift
//  ResearchKit Demo
//
//  Created by Jon Tancer on 11/4/17.
//  Copyright © 2017 njtman. All rights reserved.
//

import UIKit

class RKIntroPageViewController: UIPageViewController {

    weak var pageViewDelegate: RKIntroPageViewControllerDelegate?

    var arrPageTitle: NSArray = NSArray()
    var arrPageContent: NSArray = NSArray()

    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newStepViewController(0),
                self.newStepViewController(1),
                self.newStepViewController(2)]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        arrPageTitle = ["This is screen 1", "This is screen 2", "This is screen 3"];
        arrPageContent = ["Content on page 1", "Content on page 2", "Content on page 3"];

        dataSource = self
        delegate = self

        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }

        pageViewDelegate?.pageViewController(self,
            didUpdatePageCount: orderedViewControllers.count)
    }

    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                viewControllerAfter: visibleViewController) {
                    scrollToViewController(nextViewController)
        }
    }

    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.

     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }

    fileprivate func newStepViewController(_ index: Int) -> UIViewController {
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageControllerContent") as! RKIntroContentViewController

        pageContentViewController.titleString = "\(arrPageTitle[index])"
        pageContentViewController.contentString = "\(arrPageContent[index])"
        pageContentViewController.pageIndex = index

        return pageContentViewController
    }

    /**
     Scrolls to the given 'viewController' page.

     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'pageViewDelegate' of the new index.
                            self.notifyPageViewDelegateOfNewIndex()
        })
    }

    /**
     Notifies '_pageViewDelegate' that the current page index was updated.
     */
    fileprivate func notifyPageViewDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            pageViewDelegate?.pageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }

}

// MARK: UIPageViewControllerDataSource

extension RKIntroPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

}

extension RKIntroPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyPageViewDelegateOfNewIndex()
    }

}

protocol RKIntroPageViewControllerDelegate: class {

    /**
     Called when the number of pages is updated.

     - parameter pageViewController: the pageViewController instance
     - parameter count: the total number of pages.
     */
    func pageViewController(_ pageViewController: RKIntroPageViewController,
                                    didUpdatePageCount count: Int)

    /**
     Called when the current index is updated.

     - parameter pageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func pageViewController(_ pageViewController: RKIntroPageViewController,
                                    didUpdatePageIndex index: Int)

}
