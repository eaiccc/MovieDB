//
//  BookMovieViewController.swift
//  MovieDB
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Link. All rights reserved.
//

import UIKit

class BookMovieViewController: UIViewController {
    var movie:Movie?
    fileprivate(set) lazy var webView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        if let url = URL(string:"https://www.cathaycineplexes.com.sg/") {
            webView.loadRequest(URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
