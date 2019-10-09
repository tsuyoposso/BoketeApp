//
//  ViewController.swift
//  Bokete
//
//  Created by 長坂豪士 on 2019/10/08.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    
    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch (status) {
            case .authorized: break
            case .denied: break
            case .notDetermined: break
            case .restricted: break
                
            }
            
        }
        
        getImages(keyword: "funny")
        
    }

    // 検索キーワードの値を元に画王を引っ張ってくる
    // pixabay.com
    func getImages(keyword:String) {
        
        // APIKEY  13883294-301824168ff26c343a0e9f9bf
        
        let url = "https://pixabay.com/api/?key=13883294-301824168ff26c343a0e9f9bf&q=\(keyword)"
        
        //AlamoFireを使ってhttpリクエストを投げる
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString  = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil {
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                } else {
                    // string型で取ってきた"webformatURL"をURL型にキャストして、画像として出力 -> string: imageString!がよくわからん
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }
                
                // string型で取ってきた"webformatURL"をURL型にキャストして、画像として出力 -> string: imageString!がよくわからん
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
            case .failure(let error):
                print(error)
                
                
            }
            
            
        }
        
    }
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count += 1
        
        // テキストフィールドに何もない場合はデフォルトで"funny"の検索結果を返す
        if searchTextField.text == "" {
            getImages(keyword: "funny")
            
        } else {
            
            getImages(keyword: searchTextField.text!)
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        count = 0
        
        if searchTextField.text == "" {
            getImages(keyword: "funny")
            
        } else {
            
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shareVC = segue.destination as? ShareViewController
        
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
    
}

