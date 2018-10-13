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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        requestTask?.cancel()

    }
    
    let url = "https://nodeswiftcairo.herokuapp.com/api/timelines"
    
    let headers = ["x-api-key":"0a568370aca4428aa292520e9bdf72c9"]
    let params = ["email": "ali@alic.om", "password": "2341234"]
    var requestTask: DataRequest?

    /// First trial, sends url, params, and so on, very basic usage of alamofire
    /// then id decode the json into static model
    // updates the view, vc, vm insdise the closure
    func requestUser0() {
        
        requestTask = request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData {[unowned self] (response) in
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
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftCairoUser { [weak self] (response) in
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
        UserRouter.login(email: "ali@ali.gmail.com", password: "test12345").send(SwiftCairoUser.self) {[weak self] (response) in
            switch response {
            case .failure(let error):
                // TODO: - Handle error as you want, printing isn't handling.
                print(error)
            case .success(let value):
                self?.textView.text = value.apiToken
            }
        }
        
        func getUser() {
            
        }
    }
}




struct User: CodableInit {
    let id: Int
    let firstName: String
    let lastName: String
    let image: String
    let email: String
}



class UserManager {
    static let shared = UserManager()
    func currentUser(completion: @escaping (User) -> Void) {
        guard let user = currentUser else {
            callApi(completion: completion)
            return
        }
        completion(user)
        callApi(completion: completion)
    }
    
    func callApi(completion: @escaping (User) -> Void)  {
        UserRouter.userProfile.send(User.self) { (response) in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let user):
                self.currentUser = user
                completion(user)
            }
        }
    }
    
    
    var memoryUser: User?

    var currentUser: User? {
        get {
            return UserDefaults.standard.object(forKey: "User") as? User
        }set{
            UserDefaults.standard.set(newValue, forKey: "User")
        }
    }
    
    var realmUser: User?
}
