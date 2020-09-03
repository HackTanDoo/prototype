//
//  TodayViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    private var Today = today()
    
    private var morningCeremonyControllers = [UIViewController]()
    private var nightCeremonyViewControllers = [UIViewController]()
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index,question) in Today.morningQuestions.enumerated() {
            guard let morningQuestionController = storyboard?.instantiateViewController(identifier: "morningCeremonyQuestionViewController", creator: {coder in
                morningCeremonyQuestionViewController(coder: coder, number: index+1 , question: question)
            }) else {
                fatalError("Unable to create morningQeustionController")
            }
            morningCeremonyControllers.append(morningQuestionController)
            print("For Loop is called \(index) : \(question)")
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidLoad Called")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.presentPageVC()
            print("presentPageVC is called")
        })
    }
    
    func presentPageVC(){
        guard let first = morningCeremonyControllers.first else {return }
        let vc = UIPageViewController(transitionStyle: .pageCurl,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        vc.delegate = self
        vc.dataSource = self
        
        vc.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        
        present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = morningCeremonyControllers.firstIndex(of: viewController), index > 0 else{
            return nil
        }
        let before = index - 1
        print("before called")
        let tempController = morningCeremonyControllers[index] as? morningCeremonyQuestionViewController
        Today.morningAnswers.append(tempController?.morningCeremonyAnswer.text ?? "?")
        return morningCeremonyControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = morningCeremonyControllers.firstIndex(of: viewController), index < morningCeremonyControllers.count - 1 else {return nil}
        let after = index + 1
        print("after clled")
        return morningCeremonyControllers[after]
    }
    
}
