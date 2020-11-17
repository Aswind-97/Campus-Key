//
//  Directory.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit
import WebKit

class Directory: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        
        let url = URL(string: "https://3dmap.csun.edu/?id=1100#!ct/25911,25835")
        let URLrequest = URLRequest(url: url!)
        self.webView.load(URLrequest)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
