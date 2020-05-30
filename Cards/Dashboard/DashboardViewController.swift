 //
 //  DashboardViewController.swift
 //  Cards
 //
 //  Created by Lizan Pradhanang on 5/29/20.
 //  Copyright © 2020 Lizan Pradhanang. All rights reserved.
 //
 
 import UIKit
 import Lottie
 import FirebaseAuth
 import FirebaseDatabase
 import ObjectMapper
 
 class DashboardViewController: UIViewController {
    
    @IBOutlet weak var cardAnimation: AnimationView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var addCardBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cards: [CardModel]? {
        didSet {
            tableView.backgroundView = (cards?.count == 0) ? backgroundView : nil
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        animationView.contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        let img = UIImageView()
        img.image = UIImage.init(named: "title")
        img.contentMode = .scaleAspectFit
        self.navigationItem.titleView = img
        
        addCardBtn.rounded()
        content.layer.cornerRadius = 8
        
        //        animationView.loopMode = .autoReverse
        //        animationView.backgroundColor = UIColor.init(hex: "131318")
        //        animationView.animationSpeed = 0.5
        //        animationView.play()
        
        cardAnimation.loopMode = .loop
        cardAnimation.backgroundColor = UIColor.init(hex: "1C1C1C")
        cardAnimation.animationSpeed = 1
        cardAnimation.play()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = backgroundView 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCards()
    }
    
    func fetchCards() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).observe(.value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? [String: Any] {
                let datas = Array(value.values).compactMap{$0 as? String}
                let models : [CardModel] = datas.compactMap { (value)  in
                    let dcrypted = self.decrypt(base64: value)
                    let data = Data.init(base64Encoded: dcrypted ?? "")
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: String] {
                            let model = Mapper<CardModel>().map(JSON: dict)
                            return model
                        } else {
                            return nil
                        }
                    } catch {
                        print(error.localizedDescription)
                        return nil
                    }
                }
                self.cards = models
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addCardAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "NewCard", bundle: nil).instantiateViewController(withIdentifier: "NewCardViewController") as! NewCardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
 }

 extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cards?.count ?? 0) == 0 ? 0 : (cards?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row + 1) > (cards?.count ?? 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardCell") as! AddCardCell
            cell.setup()
            cell.didTapAdd = {
                let vc = UIStoryboard.init(name: "NewCard", bundle: nil).instantiateViewController(withIdentifier: "NewCardViewController") as! NewCardViewController
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as! CardTableViewCell
        cell.model = self.cards?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row + 1) > (cards?.count ?? 0) {
            return 360
        }
        return 220
    }
 }
