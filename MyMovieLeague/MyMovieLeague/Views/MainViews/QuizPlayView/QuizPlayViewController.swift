//
//  QuizPlayViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 3/4/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import GradientProgressBar
import SimpleImageViewer

class QuizPlayViewController: UIViewController {
    
    @IBOutlet weak var viewAgainHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var previewImgView: UIImageView!
    @IBOutlet weak var containerViewAgain: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var questionsProgressBar: GradientProgressBar!
    @IBOutlet weak var progressContainer: UIView!
    
    @IBOutlet weak var lblQuestionCountLbl: UILabel!
    @IBOutlet weak var lblTotalQuestionsCount: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!    
    @IBOutlet var choiceViews: [ChoiceView]!
    
    @IBOutlet weak var nextBtn: UIButton!
    var gameCard: QuizGameCard?
    
    var  timer = Timer()
    var question: Question?
    var currentIndex: Int = 0
    var selectedChoice = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
    }
    
    deinit {
        print("DEINIT QuizPlayViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        //            self.title = "My Games".uppercased()
        
        let menubutton = UIButton(type: .custom)
        menubutton.frame = CGRect(x: 0, y: 0, width: 18, height: 22)
        menubutton.setImage(UIImage(named: "back-arrow-white"), for: .normal)
        menubutton.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        let barButton1 = UIBarButtonItem(customView: menubutton)
        let currWidth1 = barButton1.customView?.widthAnchor.constraint(equalToConstant: 18)
        currWidth1?.isActive = true
        let currHeight1 = barButton1.customView?.heightAnchor.constraint(equalToConstant: 22)
        currHeight1?.isActive = true
        navigationItem.leftBarButtonItem = barButton1
        
        let image: UIImage = UIImage(named: "app-logo-small")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        
    }
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        self.viewAgainHeightConstant.constant = 0
        nextBtn.layer.cornerRadius = 25.0
        nextBtn.layer.masksToBounds = true
        questionsProgressBar.backgroundColor = UIColor.clear
        questionsProgressBar.setProgress(0.0/20.0, animated: true)
        questionsProgressBar.animationDuration = 1.0
        questionsProgressBar.gradientColors = [
            UIColor(red: 79.0/255.0, green: 172.0/255.0, blue: 51.0/255.0, alpha: 1),
            UIColor(red: 242.0/255.0, green: 210.0/255.0, blue: 83.0/255.0, alpha: 1),
            UIColor(red: 229.0/255.0, green: 49.0/255.0, blue: 46.0/255.0, alpha: 1)
        ]
        questionsProgressBar.layer.cornerRadius = 18
        questionsProgressBar.layer.masksToBounds = true
        questionsProgressBar.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        
        lblTimer.text = "0/0"
        progressContainer.layer.cornerRadius = 20
        progressContainer.layer.borderWidth = 2.0
        progressContainer.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        progressContainer.layer.masksToBounds = true
        
        lblQuestionCountLbl.textColor = UIColor(white: 1, alpha: 0.6)
        lblTotalQuestionsCount.textColor = UIColor(white: 1, alpha: 0.6)
        
        containerViewAgain.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        containerViewAgain.layer.masksToBounds = true
        containerViewAgain.layer.cornerRadius = 4.0
        
            
        self.setupQuestion()
        
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        if selectedChoice < 100 {
            if let kQuestion = self.question, kQuestion.correctAnswer == (selectedChoice + 1) {
                
                AppController.shared.window?.makeToast("Correct answer", duration: 2.0, position: .center,  completion: nil)
            }
            else {
                AppController.shared.window?.makeToast("Wrong answer", duration: 2.0, position: .center,  completion: nil)
            }
        }
        else {
            AppController.shared.window?.makeToast("No choice selected", duration: 2.0, position: .center,  completion: nil)
        }
        
        self.timer.invalidate()
        
        self.currentIndex +=  1
        self.setupQuestion()
        
    }
    @IBAction func previewAction(_ sender: Any) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.previewImgView
        }
        self.present(ImageViewerController(configuration: configuration), animated: true)
    }
    
    func setupQuestion() {
        
        if let gameCard = gameCard, let questions = gameCard.questions, questions.count > 0, self.currentIndex < questions.count  {
            self.lblQuestionCountLbl.text = "Question \(self.currentIndex+1)"
            self.lblTotalQuestionsCount.text = "/\(questions.count)"
            if let title = gameCard.title, title == "audio" || title == "video" || title == "image" {
              
                let kquestion = questions[self.currentIndex]
                self.question = kquestion
                self.questionsProgressBar.setProgress(Float(0.0/Double(self.question?.timerTime ?? 0)), animated: false)
                self.lblTimer.text = "\(Int(0.0))/\(self.question?.timerTime ?? 0)"
                let player = PlayerViewController()
                player.modalPresentationStyle = .fullScreen
                player.resourceName = self.question?.resourceURL ?? ""
                player.viewTitle = title
                player.completion  = {
                    player.dismiss(animated: true, completion: nil)
                    self.startQuestion()
                }
                self.present(player, animated: true, completion: nil)
                
                self.setQuestionText()
                
            }
            
             if let title = gameCard.title, title == "multiple" {
                let kquestion = questions[self.currentIndex]
                self.question = kquestion
                self.questionsProgressBar.setProgress(Float(0.0/Double(self.question?.timerTime ?? 0)), animated: false)
                self.lblTimer.text = "\(Int(0.0))/\(self.question?.timerTime ?? 0)"
                self.startQuestion()

                self.setQuestionText()
            }
            
        }
        else {
            let alertVC     =   AcknowledgeViewController()
            alertVC.type    =   .Quiz
            alertVC.gobackHome = {
            }
            self.navigationController?.pushViewController(alertVC, animated: true)
        }
    }
    
    func startQuestion() {
        var timertime = 0.0
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (kTimer) in
            print("Done!")
            
            if timertime == Double(self.question?.timerTime ?? 0) {
                self.timer.invalidate()
                self.currentIndex +=  1
                self.setupQuestion()
            }
            
            self.questionsProgressBar.setProgress(Float(timertime/Double(self.question?.timerTime ?? 0)), animated: true)
            self.lblTimer.text = "\(Int(timertime))/\(self.question?.timerTime ?? 0)"
            timertime += 1.0
        })
    }
    
    func setQuestionText() {
        self.selectedChoice = 100
        self.choiceViews.forEach {
            $0.unselectAction()
        }
        self.lblQuestion.text = self.question?.question ?? ""
        self.choiceViews.forEach {
            $0.titleText = self.question?.choices?[$0.tag].choice ?? ""
            $0.accessoryAction = { view in
                self.choiceViews.forEach {
                    if view.tag == $0.tag {
                        $0.selectAction()
                        self.selectedChoice = $0.tag
                        print(self.selectedChoice)
                    }
                    else {
                        $0.unselectAction()
                    }
                }
                
            }
        }
    }
}
