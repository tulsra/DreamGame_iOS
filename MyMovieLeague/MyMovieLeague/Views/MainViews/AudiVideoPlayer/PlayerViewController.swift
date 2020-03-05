//
//  PlayerViewController.swift
//  MyMovieLeague
//
//  Created by Thulasi Ram Boddu on 3/5/20.
//  Copyright © 2020 DreamGame. All rights reserved.
//

import UIKit
import AVFoundation
import GradientProgressBar

class PlayerViewController: UIViewController,AVAudioPlayerDelegate {

    var resourceName:String = ""
    var viewTitle = ""
    var audioPlayer = AVAudioPlayer()
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var  timer = Timer()
    @IBOutlet weak var progressBar: GradientProgressBar!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var audioClipIcon: UIImageView!
    
    var completion:()->() = {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if viewTitle == "audio" {
            setupAudio()
        }
        else if viewTitle == "video" {
            setupVideo()
        }
    }
        
    func setupUI() {
        progressBar.backgroundColor = UIColor.clear
        progressBar.setProgress(0.0/10.0, animated: true)
        progressBar.animationDuration = 1.0
        progressBar.gradientColors = [
            UIColor(red: 79.0/255.0, green: 172.0/255.0, blue: 51.0/255.0, alpha: 1),
            UIColor(red: 242.0/255.0, green: 210.0/255.0, blue: 83.0/255.0, alpha: 1),
            UIColor(red: 229.0/255.0, green: 49.0/255.0, blue: 46.0/255.0, alpha: 1)
        ]
        progressBar.layer.cornerRadius = 2
        progressBar.layer.masksToBounds = true
        progressBar.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    }
    
    func setupAudio() {
        if let sound  = Bundle.main.path(forResource: resourceName, ofType: "mp3") {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                audioPlayer.delegate  = self
                audioPlayer.play()
                self.timer.invalidate()
                var timertime = 1.0
                self.lblTimer.text = "0/10"
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (kTimer) in
                    
                    if timertime == Double(Int(self.audioPlayer.duration)) {
                        self.timer.invalidate()
                    }
                    
                    self.progressBar.setProgress(Float(timertime/Double(Int(self.audioPlayer.duration))), animated: true)
                    self.lblTimer.text = "\(Int(timertime))/\(Int(self.audioPlayer.duration))"
                    timertime += 1.0
                })
            }
            catch {
                print(error)
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.completion()
    }
    
    
    func setupVideo(){
        if let sound  = Bundle.main.path(forResource: resourceName, ofType: "mp4") {
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            self.audioClipIcon.isHidden = true
            playerItem = AVPlayerItem(url: URL(fileURLWithPath: sound))
            player  =   AVPlayer(playerItem: playerItem!)
            let playerLayer=AVPlayerLayer(player: player!)
            playerLayer.frame = CGRect(x: 0, y: 0, width: self.playView.frame.size.width, height: self.playView.frame.size.height)
            self.playView.layer.addSublayer(playerLayer)
            player?.play()
            
            self.timer.invalidate()
            var timertime = 1.0
            self.lblTimer.text = "0/10"
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (kTimer) in
                
                if let dur = self.player?.currentItem?.asset.duration {
                    
                if timertime == CMTimeGetSeconds(dur) {
                    self.timer.invalidate()
                }
                
                self.progressBar.setProgress(Float(timertime/Double(Int(CMTimeGetSeconds(dur)))), animated: true)
                self.lblTimer.text = "\(Int(timertime))/\(Int(CMTimeGetSeconds(dur)))"
                }
                timertime += 1.0
            })
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        NotificationCenter.default.removeObserver(self)
        self.completion()
    }
    
    deinit {
        print("DEINIT PlayerViewController")
         NotificationCenter.default.removeObserver(self)
    }
    
}
