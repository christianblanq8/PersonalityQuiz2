//
//  QuestionViewController.swift
//  Midterm_Project
//
//  Created by Christian Blanquera on 3/4/24.
//  Copyright © 2024 RutgersChristianBlanquera. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question (text: "Which food do you like the most?",
        type: .single,
        answer: [
        Answer(text:"Steak",type: .dog),
        Answer(text:"Fish",type: .cat),
        Answer(text:"Carrots",type: .rabbit),
        Answer(text:"Corn",type: .turtle),
    ]),
                                 
     Question(text:"Which activities do you enjoy",type: .multiple, answer: [
        Answer(text:"Eating",type: .dog),
        Answer(text:"Sleeping",type: .cat),
        Answer(text:"Cuddling",type: .rabbit),
        Answer(text:"Swimming",type: .turtle),
    ]),
  Question(text:"How much do you enjoy car rides?",type: .ranged, answer: [
        Answer(text:"I LOVE THEM",type: .dog),
        Answer(text:"I dislike them",type: .cat),
        Answer(text:"I get a lil nervous",type: .rabbit),
        Answer(text:"I barely notice them",type: .turtle),
      ]),
 ]

var questionIndex = 0
    
var answerChosen: [Answer] = []
                                 

        
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question a\(questionIndex+1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count)
       
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
        updateSingleStack(using: currentAnswers)
        case .multiple:
        updateMultipleStack(using: currentAnswers)
        case .ranged:
         updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text,for: .normal)
        singleButton2.setTitle(answers[1].text,for: .normal)
        singleButton3.setTitle(answers[2].text,for: .normal)
        singleButton4.setTitle(answers[3].text,for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answer
        
        switch sender{
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    

    
    @IBAction func multipleAnswerButtonPressed() {
    
        let currentAnswers = questions[questionIndex].answer
    
    if multiSwitch1.isOn {
        answerChosen.append(currentAnswers[0])
    }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
            if multiSwitch4.isOn {
                answerChosen.append(currentAnswers[3])
            }
            
            nextQuestion()
        }

    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answer
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    

    func nextQuestion() {
        questionIndex+=1
    
        if questionIndex < questions.count {
        updateUI()
        } else {
        performSegue(withIdentifier: "ResultsSegue", sender: nil)
    }
    
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answerChosen
        }
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
