//
//  ViewController.swift
//  BurgerList_Demo
//
//  Created by StevenTang on 2021/8/12.
//

import UIKit

class ViewController: UIViewController {

    var dataSource: [String] = ["顯示項目1", "顯示項目2", "顯示項目3", "顯示項目4", "顯示項目5"]
    var burgerButton = UIButton()
    let burgerTableView = UITableView()
    let burgerTransparentView = UIView()
    
    
    @IBOutlet weak var selectOptionButton: UIButton!
    
    @IBAction func popBurgerList(_ sender: Any) {
        burgerButton = selectOptionButton
        addBurgerTransparentView(frames: selectOptionButton.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBurgerTableView()
    }
    
    func setBurgerTableView() {
        burgerTableView.delegate = self
        burgerTableView.dataSource = self
        burgerTableView.isScrollEnabled = false
        burgerTableView.register(DemoTableViewCell.self, forCellReuseIdentifier: "DEMO_Cell")
        burgerTableView.separatorStyle = .none
    }
    
    func addBurgerTransparentView(frames: CGRect) {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        burgerTransparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(burgerTransparentView)
        
        burgerTableView.frame = CGRect(x: self.view.bounds.minX - 10
                                     , y: frames.origin.y + self.selectOptionButton.frame.height
                                     , width: 0
                                       , height: self.view.frame.height / 1.3)
        self.view.addSubview(burgerTableView)
        burgerTableView.layer.cornerRadius = 10
        burgerTableView.alpha = 0.8
        
        burgerTransparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        burgerTableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeBurgerTransparentView))
        burgerTransparentView.addGestureRecognizer(tapGesture)
        burgerTransparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .overrideInheritedCurve, animations: {
            self.burgerTransparentView.alpha = 0.1
            self.burgerTableView.frame = CGRect(x: self.view.bounds.minX - 10
                                              , y: frames.origin.y + self.selectOptionButton.frame.height
                                                , width: self.view.frame.width / 2 + 10
                                                , height: self.view.frame.height / 1.3)
        }, completion: nil)
        
    }
    
    @objc func removeBurgerTransparentView() {
        let frames = burgerButton.frame
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .overrideInheritedCurve, animations: {
            self.burgerTransparentView.alpha = 0
            self.burgerTableView.frame = CGRect(x: self.view.bounds.minX - 10
                                              , y: frames.origin.y +  self.selectOptionButton.frame.height
                                              , width: 0
                                                , height: self.view.frame.height / 1.3)
        }, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEMO_Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
