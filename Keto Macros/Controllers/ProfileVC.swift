//
//  ProfileVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/29/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var item = ["One", "Two"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //Sets up the initial view
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //Determines number of cells in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    //Determines content for each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileCell
        cell.credential.text = item[indexPath.item]
        cell.mainView.layer.cornerRadius = 15
        
        switch indexPath.item {
        case 0:
            cell.mainView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case 1:
            cell.mainView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        default:
            break
        }
        
        return cell
    }

}
