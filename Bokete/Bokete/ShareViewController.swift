//
//  ShareViewController.swift
//  Bokete
//
//  Created by 長坂豪士 on 2019/10/09.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        // フォントサイズを動的に変化させる
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    

    @IBAction func share(_ sender: Any) {
        
        // スクリーンショットを撮る
        
        takeScreenShot()
        
        let items = [screenShotImage] as [Any]
        // アクティビティビューに乗っけてシェアする
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    // スクリーンショットを撮るときの定型文
    func takeScreenShot() {
        
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height) // 動画では/1.3してた
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    

    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
