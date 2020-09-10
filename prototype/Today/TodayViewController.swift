//
//  TodayViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit
import CoreData

class TodayViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    @IBOutlet weak var todayPromise: UILabel!
    var todayPromiseText = "" {
        didSet{
            todayPromise.text = todayPromiseText
        }
    }
    private var Today = today()
    private var presentCeremonyView = true
    private var CeremonyControllers = [UIViewController]()
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setState()
        resetCeremonyStatesByDay()
        todayPromiseText = Today.morningAnswers[3]
        
        
        let morningCeremony = (UserDefaults.standard.value(forKey: "morningCeremony") ?? false) as! Bool
        let nightCeremony = (UserDefaults.standard.value(forKey: "nightCermeony") ?? false) as! Bool
        let hour = Calendar.current.component(.hour, from: Date())
        
        if !morningCeremony || (!nightCeremony && hour > 21) {//ceremony가 일어나야 하면
            !morningCeremony ? UserDefaults.standard.set(true, forKey: "morningCeremony") : UserDefaults.standard.set(true, forKey: "nightCermony")
            let count = !morningCeremony ? self.Today.morningQuestions.count : self.Today.nightQuestions.count
            for index in 0..<count {
                let Question = !morningCeremony ? self.Today.morningQuestions[index]: self.Today.nightQuestions[index]
                let Answer = !morningCeremony ? self.Today.morningAnswers[index]: self.Today.nightAnswers[index]
                guard let QuestionController = storyboard?.instantiateViewController(identifier: "CeremonyQuestionViewController", creator: {coder in
                    CeremonyQuestionViewController(coder: coder, morning : !morningCeremony, number: index+1 , question: Question, answer : Answer)
                }) else {
                    fatalError("Unable to create QeustionController")
                }
                CeremonyControllers.append(QuestionController)
                print("For Loop is called \(index) : \(Question) : \(Answer)")
            }
            let prayer = !morningCeremony ? self.Today.prayerForMorning : self.Today.prayerForNight
            guard let prayerController = storyboard?.instantiateViewController(identifier: "CeremonyPrayerViewController", creator: { coder in
                CeremonyPrayerViewController(coder : coder, prayer: prayer)
            }) else{
                fatalError("Unable to create PrayerController")
            }
            CeremonyControllers.append(prayerController)
            CeremonyQuestionViewController.Today = Today
        }
    }

    @IBAction func performMoningCeremony(_ sender: UIButton) {
        CeremonyControllers = [UIViewController]()
        let count = self.Today.morningQuestions.count
        for index in 0..<count {
            let Question = self.Today.morningQuestions[index]
            let Answer = self.Today.morningAnswers[index]
            guard let QuestionController = storyboard?.instantiateViewController(identifier: "CeremonyQuestionViewController", creator: {coder in
                CeremonyQuestionViewController(coder: coder, morning : true, number: index+1 , question: Question, answer : Answer)
            }) else {
                fatalError("Unable to create QeustionController")
            }
            CeremonyControllers.append(QuestionController)
            print("For Loop is called \(index) : \(Question) : \(Answer)")
        }
        let prayer = self.Today.prayerForMorning
        guard let prayerController = storyboard?.instantiateViewController(identifier: "CeremonyPrayerViewController", creator: { coder in
            CeremonyPrayerViewController(coder : coder, prayer: prayer)
        }) else{
            fatalError("Unable to create PrayerController")
        }
        CeremonyControllers.append(prayerController)
        CeremonyQuestionViewController.Today = Today
        self.presentPageVC()
    }
    
    @IBAction func performNightCeremony(_ sender: UIButton) {
        CeremonyControllers = [UIViewController]()
        let count = self.Today.nightQuestions.count
        for index in 0..<count {
            let Question = self.Today.nightQuestions[index]
            let Answer = self.Today.nightAnswers[index]
            guard let QuestionController = storyboard?.instantiateViewController(identifier: "CeremonyQuestionViewController", creator: {coder in
                CeremonyQuestionViewController(coder: coder, morning : false, number: index+1 , question: Question, answer : Answer)
            }) else {
                fatalError("Unable to create QeustionController")
            }
            CeremonyControllers.append(QuestionController)
            print("For Loop is called \(index) : \(Question) : \(Answer)")
        }
        let prayer = self.Today.prayerForNight
        guard let prayerController = storyboard?.instantiateViewController(identifier: "CeremonyPrayerViewController", creator: { coder in
            CeremonyPrayerViewController(coder : coder, prayer: prayer)
        }) else{
            fatalError("Unable to create PrayerController")
        }
        CeremonyControllers.append(prayerController)
        CeremonyQuestionViewController.Today = Today
        self.presentPageVC()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidLoad Called")
        let hour = Calendar.current.component(.hour, from: Date())
        
        if !Today.morningCeremony || (!Today.nightCeremony && hour > 21) {
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.presentPageVC()
                print("presentPageVC is called")
            })
        }
        
    }
    
    func presentPageVC(){
        guard let first = CeremonyControllers.first else {fatalError("No units for CeremonyControllers") }
        print("presentPageVC is called")
        let vc = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        vc.delegate = self
        vc.dataSource = self
        
        vc.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        
        present(vc, animated: true)
        print("present is called")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = CeremonyControllers.firstIndex(of: viewController), index > 0 else{
            return nil
        }
        let before = index - 1
//        let target = morningCeremonyControllers[index] as! morningCeremonyQuestionViewController
//        let text = target.morningCeremonyAnswer.text
//        Today.morningAnswers[index] = text!
        return CeremonyControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = CeremonyControllers.firstIndex(of: viewController), index < CeremonyControllers.count - 1 else {return nil}
        let after = index + 1
//        let target = morningCeremonyControllers[index] as! morningCeremonyQuestionViewController
//        let text = target.morningCeremonyAnswer.text
//        Today.morningAnswers[index] = text!
        return CeremonyControllers[after]
    }
    
    func resetCeremonyStatesByDay(){
        let hour = Calendar.current.component(.hour, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        var needToReset = false
        if let recentDay = UserDefaults.standard.value(forKey: "recentDay") as? Int, recentDay != day && hour > 5 {
            needToReset = true
        }
        UserDefaults.standard.set(day, forKey: "recentDay")
        
        if needToReset {
            UserDefaults.standard.set(false, forKey: "morningCeremony")
            UserDefaults.standard.set(false, forKey: "nightCermeony")
        }
    }
    
    func setState(){
        if let morningAnswers = UserDefaults.standard.value(forKey: "morningAnswers"),
            let morningQuestions = UserDefaults.standard.value(forKey: "morningQuestions"),
            let prayerForMorning = UserDefaults.standard.value(forKey: "prayerForMorning"),
            let nightAnswers = UserDefaults.standard.value(forKey: "nightAnswers"),
            let nightQuestions = UserDefaults.standard.value(forKey: "nightQuestions"),
            let prayerForNight = UserDefaults.standard.value(forKey : "prayerForNight"),
            let morningCeremony = UserDefaults.standard.value(forKey: "morningCeremony"),
            let nightCeremony = UserDefaults.standard.value(forKey: "nightCeremony")
        {
            print("if is called")
            Today.morningAnswers = morningAnswers as! [String]
            Today.morningQuestions = morningQuestions as! [String]
            Today.prayerForMorning = prayerForMorning as! String
            Today.nightAnswers = nightAnswers as! [String]
            Today.nightQuestions = nightQuestions as! [String]
            Today.prayerForNight = prayerForNight as! String
            Today.morningCeremony = morningCeremony as! Bool
            Today.nightCeremony = nightCeremony as! Bool
            
            //calendar = beforeDate as! Calendar
        } else {
            print("else is called")
            UserDefaults.standard.set(Today.morningAnswers, forKey: "morningAnswers")
            UserDefaults.standard.set(Today.morningQuestions, forKey: "morningQuestions")
            UserDefaults.standard.set(Today.morningCeremony, forKey: "morningCeremony")
            UserDefaults.standard.set(Today.prayerForMorning, forKey: "prayerForMorning")
            UserDefaults.standard.set(Today.nightQuestions, forKey: "nightQuestions")
            UserDefaults.standard.set(Today.nightCeremony, forKey: "nightCeremony")
            UserDefaults.standard.set(Today.nightAnswers, forKey: "nightAnswers")
            UserDefaults.standard.set(Today.prayerForNight, forKey: "prayerForNight")
            //UserDefaults.standard.set(calendar, forKey: "Calendar")
        }
    }
}
