//
//  ViewController.swift
//  snacks
//
//  Created by Esperanza on 2022-01-26.
//

import UIKit

class ViewController: UIViewController {
    
    //set up view : tableView / UIView / UIImageView
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    let navBar: UIView = {
        let navBar = UIView()
//        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = UIColor.lightGray
        return navBar
    }()
    
    let navBarTitle: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.text = "SNACKS"
        navBarTitle.textColor = .black
        navBarTitle.textAlignment = .center
        navBarTitle.font = UIFont.boldSystemFont(ofSize: 25)
        navBarTitle.translatesAutoresizingMaskIntoConstraints = false
        return navBarTitle
    }()
    
    
    let plusButton: UIButton = {
      let plusButton = UIButton(type: .system)
      plusButton.setTitle("✚", for: .normal)
      plusButton.translatesAutoresizingMaskIntoConstraints = false
      plusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
      plusButton.addTarget(self, action: #selector(plusIconPressed), for: .touchUpInside)
      return plusButton
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
      
        return stackView
    }()
    
//    let oreos : UIImageView = {
//        let oreos = UIImageView()
//        oreos.image = UIImage(named: "oreos.png")
//        oreos.isUserInteractionEnabled = true
//        oreos.translatesAutoresizingMaskIntoConstraints = false
//        return oreos
//      }()
    
    private var navBarIsOpen = false
    private var selectedSnacks = [String()]
    private let snacksTitle: [String] = ["oreos", "pizza_pocketes", "pop_tarts", "popsicle", "ramen"]
    private var navBarTitleHeightConstraints: NSLayoutConstraint!
  
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88)
        
        
        
        //create 5 imageviews
        let imageView1 = UIImageView(image: UIImage(named: "oreos.png"))
        let imageView2 = UIImageView(image: UIImage(named: "pizza_pockets.png"))
        let imageView3 = UIImageView(image: UIImage(named: "pop_tarts.png"))
        let imageView4 = UIImageView(image: UIImage(named: "popsicle.png"))
        let imageView5 = UIImageView(image: UIImage(named: "ramen.png"))
        let imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5]
        
        //set up layout in stackview
//        stackView = UIStackView(frame: CGRect(x: 0, y: 88, width: view.frame.width, height: 100))
        
        //add 5 images to stackview
        for i in 0..<imageViews.count {
            imageViews[i].isUserInteractionEnabled = true
        
            //gesture recognizer for the stackview (make below code about gesture simplify)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageViews[i].addGestureRecognizer(tapGestureRecognizer)
            imageViews[i].tag = i
            //ex: imageView[1].tag = 1, oreos.tag = 1, pizza....tag = 2.....
            stackView.addArrangedSubview(imageViews[i])
        }
        
        //from the beginning, the imageviews array is hidden, when user press plus icon, it will show stackview
        stackView.isHidden = true
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(stackView)
        subviews()
        constraints()
        navBarTitleHeightConstraints =  navBarTitle.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor, constant: 20)
        navBarTitleHeightConstraints.isActive = true
        

        
      
        
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        
    
        

//        oreos.addGestureRecognizer(tapGestureRecognizer)
//        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action:                 #selector(imageTapped(tapGestureRecognizer:)))
        
    }
  
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if navBarIsOpen {
            if let i = sender.view?.tag {
                selectedSnacks.append(snacksTitle[i])
                let indexPath = IndexPath(row: selectedSnacks.count - 1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    
}
    
    @objc func plusIconPressed(_ sender:UIButton!) {
        
        if !navBarIsOpen {
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.stackView.isHidden = false
                self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
                self.navBar.layoutIfNeeded()
                self.navBarTitleHeightConstraints.constant = -40
                self.navBarTitle.text = "Pick up one snack!"
                let rotateTransform = CGAffineTransform(rotationAngle: .pi / 2)
                self.plusButton.transform = rotateTransform } ,completion: nil )
        } else {
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.stackView.isHidden = true
                self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88)
                self.navBar.layoutIfNeeded()
                self.navBarTitleHeightConstraints.constant = 20
                self.navBarTitle.text = "SNACKS"
                let rotateTransform = CGAffineTransform(rotationAngle: -.pi / 2)
                self.plusButton.transform = rotateTransform
            } , completion: nil )
              }
            navBarIsOpen.toggle()
    }

}

//extension

extension ViewController {
    func subviews() {
        
        navBar.addSubview(plusButton)
        navBar.addSubview(navBarTitle)
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
    }
    
    func constraints() {
//        NSLayoutConstraint.activate([
//            navBar.topAnchor.constraint(equalTo: view.topAnchor),
//            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
//            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
//            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            navBar.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ]);
        NSLayoutConstraint.activate([
            navBarTitle.centerXAnchor.constraint(equalTo: self.navBar.centerXAnchor),
//            navBarTitle.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
           
            
            stackView.bottomAnchor.constraint(equalTo: self.navBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.navBar.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: self.navBar.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
            ]);
        
       
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSnacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = selectedSnacks[indexPath.row]
        return cell
    }
    
    


}


