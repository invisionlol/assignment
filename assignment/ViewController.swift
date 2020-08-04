//
//  ViewController.swift
//  test
//
//  Created by INVISION on 3/8/2563 BE.
//  Copyright © 2563 INVISION. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import WebKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate {


    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mWebView: WKWebView!
    
    
    var mDataArray:[Item] = []
    var refreshControl = UIRefreshControl()
    var mUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        self.setRowHeight()
        self.pullRefresh()
        

    }
    
    func pullRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        mTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.feedData()
        refreshControl.endRefreshing()
        
    }
    
    func setRowHeight() {
        //Row Height
        self.mTableView.rowHeight = UITableView.automaticDimension
    }
    
    func feedData() {
        let url = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        
        AF.request(url, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
                
            case .success:
                do{
                    print(response.result)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(DataResponse.self, from: response.data!)
                    self.mDataArray = result.items
                    self.mTableView.reloadData()
                    
                } catch let err {
                    print(err)
                }
                break
            default:
                break
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as? DataTableViewCell
        let item = self.mDataArray[indexPath.row]
        cell?.mImageView.af.setImage(withURL: item.media.m.url())
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mTableView.deselectRow(at: indexPath, animated: true)
        let item = self.mDataArray[indexPath.row]
        
        let url = URL(string: item.link)
        let request = URLRequest(url: url!)
        self.mWebView.load(request)
        self.mTableView.addSubview(mWebView)
        print("WEB LOADED")
   

    }
    
}




extension String {
     func url() -> URL{
         return URL(string: self)!
     }
 }
