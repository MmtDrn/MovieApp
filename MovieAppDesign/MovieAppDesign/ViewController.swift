//
//  ViewController.swift
//  MovieAppDesign
//
//  Created by MacBook on 8.03.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tableViewCategory: UITableView!
    
    var ref:DatabaseReference!
    var list = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableViewCategory.delegate = self
        tableViewCategory.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllCategory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let moviesVC = segue.destination as! MoviesViewController
        moviesVC.category = list[indeks!]
    }

    func getAllCategory(){
        
        ref.child("kategoriler").observe(.value) { DataSnapshot in
            
            if let cameData = DataSnapshot.value as? [String:AnyObject] {
                
                self.list.removeAll()
                
                for cameRow in cameData {
                    
                    if let dict = cameRow.value as? NSDictionary {
                        
                        let key = cameRow.key
                        let name = dict["kategori_ad"] as? String ?? ""
                        
                        let cat = Category(category_name: name, category_id: key)
                        
                        self.list.append(cat)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableViewCategory.reloadData()
            }
        }
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cat = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! CategoryTableViewCell
        
        cell.labelCategoryName.text = cat.category_name!
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovies", sender: indexPath.row)
    }
}

