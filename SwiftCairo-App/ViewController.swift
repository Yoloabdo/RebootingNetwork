//
//  ViewController.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 5/9/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestUser3()
    }

    
    let url = "https://f01098d1-94c3-403b-bbbd-f850b101b35b.mock.pstmn.io/login"
    
    let headers = ["x-api-key":"0a568370aca4428aa292520e9bdf72c9"]
    let params = ["email": "ali@alic.om", "password": "2341234"]

    /// First trial, sends url, params, and so on, very basic usage of alamofire
    /// then id decode the json into static model
    // updates the view, vc, vm insdise the closure
    func requestUser0() {
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .failure(let error):
                // handle error
                print(error)
            case .success(let value):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let user = try decoder.decode(SwiftCairoUser.self, from: value)
                    self.textView.text = user.apiToken
                }
                catch {
                    print(error)
                }
            }
        }
        
    }
    
    
    
    /// Second version, it uses request extension avalialbe on Quicktype site
    /// same as above request, with url, params, etc
    func requestUser1() {
        _ = request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftCairoUser { [weak self] (response) in
            self?.textView?.text = response.result.value.debugDescription
        }
    }
    
    /// third, same above but we rewrote the above extension to be generic
    func requestUser2(){
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).response(SwiftCairoUser.self) { [weak self] (response) in
            self?.textView.text = response.result.value.debugDescription
        }
    }
    
}

// MARK: - Our network layer protocol confirmation
extension ViewController {
    /// This 4th version uses our protocol that has implemented function to call our server, uses a URLRequest builder, to create the request and send it to our network request handler, the function is a wrapper around alamofire, this protocol will free us from adding "import alamofire" in every VC, VM, class we need to call network within.
    func requestUser3() {
        // creating request with the builder enum
        UserRouter.login(email: "ali@ali.gmail.com", password: "test12345").send(SwiftCairoUser.self).done { (user) in
            print(user)
            }.catch { (error) in
                // show error to user
                print(error.localizedDescription)
        }
    }
}

