//
//  AvatarPickerVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //MARK:- Properties
    var imageNames = ["dark","light"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

    }

  //MARK:- IBActions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        self.myCollectionView.reloadData()
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellID, for: indexPath) as? AvatarCell {
            cell.configureCell(number: indexPath.row, imageName: imageNames[segmentControl.selectedSegmentIndex], background: segmentControl.selectedSegmentIndex)
            return cell
        }else{
            return AvatarCell()
        }
    }
}
