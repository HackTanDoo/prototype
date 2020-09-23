//
//  SHSFViewController.swift
//  prototype
//
//  Created by 김민준 on 2020/09/20.
//  Copyright © 2020 김민준. All rights reserved.
//

import UIKit

class SHSFViewController: UIViewController {

    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var ArtistLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var Quotes : [Quote]?
    
    func fetchQuotes(){
        do {
            try Quotes = context.fetch(Quote.fetchRequest())
        } catch {
            fatalError("Fucking Quotes fetching Problem Occur")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SHSF View Did Load is called")
        fetchQuotes()
        if Quotes!.count == 0 {
            for quote in BasicQuoteCollection{
                let newQuote = Quote(context: context)
                newQuote.artist = quote.artist
                newQuote.content = quote.content
            }
            do{
                try self.context.save()
                fetchQuotes()
            } catch{
                fatalError("Saving Basic Quotes Failed")
            }
        }
        let randomIndex = Int(arc4random_uniform(UInt32(Quotes!.count)))
        ContentLabel.text = Quotes![randomIndex].content
        ArtistLabel.text = Quotes![randomIndex].artist
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SHSF ViewWillAppear is called")
        let randomIndex = Int(arc4random_uniform(UInt32(Quotes!.count)))
        ContentLabel.text = Quotes![randomIndex].content
        ArtistLabel.text = Quotes![randomIndex].artist
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
