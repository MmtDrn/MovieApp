//
//  MoviesViewController.swift
//  MovieAppDesign
//
//  Created by MacBook on 8.03.2022.
//

import UIKit
import Firebase

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    var list = [Movie]()
    var category:Category!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        
        if let k = category {
            navigationItem.title = k.category_name
            getMovies(category_name: k.category_name!)
        }
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let weight = self.collectionViewMovies.frame.size.width
        let height = self.collectionViewMovies.frame.size.height
        
        design.itemSize = CGSize(width: (weight-20)/2, height: (height-60)/2)
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 20
        
        collectionViewMovies.collectionViewLayout = design
    }
    
    
    func getMovies(category_name:String){
        
        let search = ref.child("filmler").queryOrdered(byChild: "kategori_ad").queryEqual(toValue: category_name)
        
        search.observe(.value, with: { DataSnapshot in
            
            if let cameData = DataSnapshot.value as? [String:AnyObject] {
                
                self.list.removeAll()
                
                for cameRow in cameData {
                    
                    if let dict = cameRow.value as? NSDictionary {
                        
                        let key = cameRow.key
                        let name = dict["film_ad"] as? String ?? ""
                        let image = dict["film_resim"] as? String ?? ""
                        let year = dict["film_yil"] as? Int ?? 0
                        let category = dict["kategori_ad"] as? String ?? ""
                        let producer = dict["yonetmen_ad"] as? String ?? ""
                        
                        let movie = Movie(movie_name: name, movie_id: key, movie_image: image, movie_year: year, movie_category: category, producer_name: producer)
                        
                        self.list.append(movie)
                    }
                }
            }
            DispatchQueue.main.async {
                self.collectionViewMovies.reloadData()
            }

        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let detailVC = segue.destination as! MovieDetailsViewController
        detailVC.movie = list[indeks!]
    }
}

extension MoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,CollectionProtocol{
    
    func addToBasket(indexPath: IndexPath) {
        
        let navVc = tabBarController?.viewControllers![1] as! UINavigationController
        let basketVC = navVc.topViewController as! BasketViewController
        
        let movie = list[indexPath.row]
        
        basketVC.list.append(movie)
        
        tabBarController?.selectedIndex = 1
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = list[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath) as! MoviesCollectionViewCell
        
        cell.labelMovieName.text = movie.movie_name!
        cell.labelPrice.text = "2.99 $"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(movie.movie_image!).png") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageMovie.image = UIImage(data: data!)
                }
            }
        }
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovie", sender: indexPath.row)
    }
}

