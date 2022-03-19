//
//  BasketViewController.swift
//  MovieAppDesign
//
//  Created by MacBook on 19.03.2022.
//

import UIKit
import Firebase

class BasketViewController: UIViewController {
    
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var list = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

extension BasketViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basket", for: indexPath) as! BasketTableViewCell
        
        cell.labelMovieName.text = "-\(movie.movie_name!)"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(movie.movie_image!).png") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageMovie.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ [self]
            (contextualAction, view, boolValue) in
            
            list.remove(at: indexPath.row)
            tableView.reloadData()

        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
