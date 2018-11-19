//
//  ConfigurationViewController.swift
//  GasTop
//
//  Created by Alumno on 10/21/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var userReviews: [Review] = [];
    
    let userDefaults = UserDefaults.standard;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self;
        usernameTextField.text = userDefaults.string(forKey: "username")

        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = UIView() //show only populated rows
        tableView.isScrollEnabled = false;

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
        Review.getReviews(fromUserId: userDefaults.integer(forKey: "id"), callback: { (reviews:[Review]) in
            self.userReviews = reviews;
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Text Field Delegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    // MARK: - Table View delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myReviewsCell", for: indexPath);
        
        return cell;
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        if let targetViewController = segue.destination as? ReviewTableViewController
        {
            targetViewController.reviews = userReviews;
            
        }
    }

    
    @IBAction func Logout(_ sender: UIButton) {
        self.removeFromParentViewController();
        User.logout();
        self.performSegue(withIdentifier: "toLogin", sender: self)

    }
    
}
