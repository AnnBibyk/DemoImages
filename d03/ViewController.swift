//
//  ViewController.swift
//  d03
//
//  Created by Anna BIBYK on 1/18/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    @IBOutlet var myCollectionView: UICollectionView!
    
    let array:[URL] = [
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/seaice11.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/s68-56050.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45532312914_2634bd334e_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/stsci-h-p1844b-q-4571x2571.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width - 10
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        let imageURL = array[indexPath.row]
        
        cell.activity.startAnimating()
        cell.backgroundColor = UIColor.black
        cell.activity.color = UIColor.white
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    cell.activity.hidesWhenStopped = true
                    cell.activity.stopAnimating()
                    cell.image.image = UIImage(data: data)
                }
            } else {
                let nameURL = self.array[indexPath.row]
                let alert = UIAlertController(title: "Error", message: "Cannot access to \(nameURL)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    override func prepare(for seague: UIStoryboardSegue, sender: Any?) {
        let des = seague.destination as! ScrollViewController
        let cell = sender! as! CollectionViewCell
        if cell.image.image != nil {
            des.image = cell.image.image!
        } else {
            let alert = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

