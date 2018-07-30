//
//  ImageTask.swift
//  MovieBuff
//
//  Created by nimma01 on 20/06/18.
//  Copyright © 2018 Mahendra. All rights reserved.
//

import Foundation
import UIKit

protocol ImageTaskDownloader {
    func imageDownloaded(position:Int,image:UIImage?,error:Error?)
}

class ImageTask {
    
    let position : Int
    let url : URL
    let session : URLSession
    let delegate: ImageTaskDownloader
    
    var image : UIImage?
    
    private var task:URLSessionDownloadTask?
    private var resumeData : Data?
    private var isDownloading = false
    private var isFinishedDownloading = false
    
    init(position:Int,url:URL, session:URLSession, delegate: ImageTaskDownloader){
        self.position = position
        self.url = url
        self.session = session
        self.delegate = delegate
    }
    
    func resume() {
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            }
            else{
                task = session.downloadTask(with: self.url, completionHandler: downloadTaskCompletionHandler)
            }
            
            task?.resume()
        }
    }
    
    func pause () {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: {(data) in
                self.resumeData = data
            })
            self.isDownloading = false
        }
    }
    
    private func downloadTaskCompletionHandler(url:URL?, response: URLResponse?, error:Error?) {
        if let error = error {
            print("Error downloading",error)
            self.delegate.imageDownloaded(position: self.position,image:nil,error:error)
            return
        }
        
        guard let url = url else {return}
        guard let data = FileManager.default.contents(atPath: url.path) else {return}
        guard let image = UIImage(data: data) else {return}
        
        DispatchQueue.main.async {
            self.image = image
            self.delegate.imageDownloaded(position: self.position,image:image,error:nil)
        }
        self.isFinishedDownloading = true;
        
        
    }
    
}
