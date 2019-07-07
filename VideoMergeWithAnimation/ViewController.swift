//
//  ViewController.swift
//  VideoMergeWithAnimation
//
//  Created by com on 7/5/19.
//  Copyright © 2019 KMHK. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func mergeBtnTapped(_ sender: Any) {
        let urlVideo1 = Bundle.main.url(forResource: "movie1", withExtension: "mov")
        let urlVideo2 = Bundle.main.url(forResource: "movie2", withExtension: "mov")
        
        let videoAsset1 = AVAsset(url: urlVideo1!)
        let videoAsset2 = AVAsset(url: urlVideo2!)
        
        VideoManager.shared.merge(arrayVideos: [videoAsset1, videoAsset2]) {[weak self] (outputURL, error) in
            guard let aSelf = self else { return }
            
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
            else {
                if let url = outputURL {
                    aSelf.openPreviewScreen(url)
                }
            }
        }
    }
    
    @IBAction func animationMergeBtnTapped(_ sender: Any) {
        let urlVideo1 = Bundle.main.url(forResource: "movie1", withExtension: "mov")
        let urlVideo2 = Bundle.main.url(forResource: "movie2", withExtension: "mov")
        
        let videoAsset1 = AVAsset(url: urlVideo1!)
        let videoAsset2 = AVAsset(url: urlVideo2!)
        
        VideoManager.shared.mergeWithAnimation(arrayVideos: [videoAsset1, videoAsset2], animationType: segment.selectedSegmentIndex) { [weak self] (outputURL, error) in
            guard let aSelf = self else { return }
            
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
            else {
                if let url = outputURL {
                    aSelf.openPreviewScreen(url)
                }
            }
        }
    }
    
    func openPreviewScreen(_ videoURL:URL) -> Void {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        present(playerController, animated: true, completion: {
            player.play()
        })
    }
}

