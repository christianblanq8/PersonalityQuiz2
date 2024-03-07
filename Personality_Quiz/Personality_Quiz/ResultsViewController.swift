//
//  ResultsViewController.swift
//  Midterm_Project
//
//  Created by Christian Blanquera on 3/4/24.
//  Copyright © 2024 RutgersChristianBlanquera. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]!
    override func viewDidLoad() {
        super.viewDidLoad()

        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        
    
        
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map{ $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswerSorted = frequencyOfAnswers.sorted(by: 
            {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswerSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
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
