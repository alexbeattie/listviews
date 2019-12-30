//
//  PhotosGridController.swift
//  hgh
//
//  Created by Alex Beattie on 12/30/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools


class PhotoGridCell: LBTAListCell<String> {
    let photosGridController = PhotosGridController(scrollDirection:.horizontal)

    override var item: String! {
        didSet {
            imageView.image = UIImage(named: item)
        }
    }
    let imageView = UIImageView(image: UIImage(named: "house"), contentMode: .scaleAspectFill)
    override func setupViews() {
        backgroundColor = .yellow
        
//        addSubview(imageView)
//        imageView.fillSuperview()
        
        stack(imageView)
    }
    
}
class PhotosGridController: LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        
        super .viewDidLoad()
        collectionView.backgroundColor = .lightGray
//        PhotosGridController(layout: .init(), scrollDirection: .horizontal)
        self.items = ["dog","house","jamie","sweat","sb"]
        
    }
    
    let cellPadding:CGFloat = 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 || indexPath.item == 1 {
            let width = (view.frame.width - 3 * cellPadding) / 2
            return .init(width: width, height: width)

        }
        let width = (view.frame.width - 4.1 * cellPadding) / 3
        return .init(width: width, height: width)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    }
}

struct PhotosGridPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) -> UIViewController {
            PhotosGridController()
        }
        func updateUIViewController(_ uiViewController: PhotosGridPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) {
            
        }
    }
}
