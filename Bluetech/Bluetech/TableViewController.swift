//
//  TableViewController.swift
//  Bluetech
//
//  Created by Eugenie Tyan on 4/7/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var url = "https://zodchestvo-m.ru/test.json"
    var dataJSON = [CellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        getJSON(url: url)
        print(dataJSON)
    }
    
    func getJSON(url: String) {
        DispatchQueue.main.async {
            AF.request(url).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.updateDataJSON(json: json)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
        
    }
    
    func updateDataJSON(json: JSON) {
        json.array?.forEach({ (user) in
            let tags = user["tags"].arrayObject
            var stringTags = String()
            tags?.forEach {
                stringTags += $0 as! String
                stringTags += " "
            }
            
            let user = CellModel(name: user["name"].stringValue,
                                 phone: user["phone"].stringValue,
                                 tags: stringTags,
                                 image: user["picture"].stringValue)
            self.dataJSON.append(user)
            })
    }
    
    //MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataJSON.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let data = self.dataJSON[indexPath.row]
        let name = data.name
        let phone = data.phone
        let tags = data.tags
        
        
        let url = URL(string: data.image)!
        if let dataImage = try? Data(contentsOf: url) {
            let image = UIImage(data: dataImage)
            cell.setCellWithImage(image: image!, name: name, phone: phone, tags: tags)
        } else {
            cell.setCell(name: name, phone: phone, tags: tags)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tel = self.dataJSON[indexPath.row].phone
        let cleanPhoneNumber = tel.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if let url = URL(string: "tel://\(cleanPhoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction (style: .destructive, title: "Delete") { (action, view, completion) in
            self.dataJSON.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .red
        
        return action
    }
}
