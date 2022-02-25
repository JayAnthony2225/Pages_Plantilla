//
//  PageViewController.swift
//  Scroll_Stack_ViewController
//
//  Created by Marco Cruz Velázquez on 2/24/22.
//

import UIKit
    //primer view controller
class PageViewController: UIPageViewController {
    
    let labelOneViewController = LabelViewController()
    let labelTwoViewController = LabelViewController()
    let labelThreeViewController = LabelViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        labelOneViewController.text = "Primera Vista PageView"
        labelTwoViewController.text = "Segunda Vista PageView"
        labelThreeViewController.text = "Crea memorias"
        //Set initial viewController....
        self.setViewControllers([labelOneViewController], direction: .forward, animated: true, completion: nil)
        self.view.backgroundColor = .tertiaryLabel
         }
}
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //Prepare prev action!
      if viewController === labelTwoViewController {
            return labelOneViewController
        }else if viewController === labelThreeViewController {
            return labelTwoViewController
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //Prepare next action!
       if viewController === labelOneViewController {
            return labelTwoViewController
        }else if viewController === labelTwoViewController {
            return labelThreeViewController
        } else {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationViewController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController")
            navigationViewController.modalPresentationStyle = .popover
            self.present(navigationViewController, animated: true, completion: nil)
           // self.view.window?.rootViewController = navigationViewController
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        3
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
