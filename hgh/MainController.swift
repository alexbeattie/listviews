//
//  MainController.swift
//  hgh
//
//  Created by Alex Beattie on 12/30/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools


class PostCell: LBTAListCell<String> {
    
    let imageView = UIImageView(backgroundColor: .blue)
    let nameLabel =  UILabel(text: "name label")
    let dateLabel = UILabel(text: "friday at 11:11am")
    let postTextLabel = UILabel(text: "here is my post text")
//    let imageViewGrid = UIView(backgroundColor: .yellow)
    
    let photosGridController = PhotosGridController()
    
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(hstack(imageView.withHeight(40).withWidth(40),
                     stack(nameLabel, dateLabel),
            spacing: 8).padLeft(12).padRight(12).padTop(12),
              postTextLabel, photosGridController.view, spacing: 8)
    }
}
//new 
class StoryHeader: UICollectionReusableView {
    
    let storiesController = StoriesController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        stack(storiesController.view) 
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
class StoryPhotoCell: LBTAListCell<String> {
    override var item: String! {
           didSet {
               imageView.image = UIImage(named: item)
                titleLabel.text = "New Construction"
           }
       }
    let imageView = UIImageView(image: UIImage(named: "house"), contentMode: .scaleAspectFill)
    let titleLabel = UILabel(text: "New Construction", font: .boldSystemFont(ofSize: 14), textColor: .white, textAlignment: .center, numberOfLines: 1)
    override func setupViews() {
//        backgroundColor = .red
        imageView.layer.cornerRadius = 20
        stack(imageView)
        
        
        setupGradientLayer()
        
        
        
        stack(UIView(),titleLabel).withMargins(.allSides(8))
    }

    let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.2]
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
class StoriesController: LBTAListController<StoryPhotoCell, String>, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: view.frame.height - 24)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["Willow","Camden","Fairhaven","Magnolia"]
//        items.tex
    }
}
//LBTAListHeaderController<PostCell, String, Header>

class MainController: LBTAListHeaderController<PostCell, String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        self.items = ["hello", "w9ro", "hello", "w9ro"]
        setUpNavBar()
        
    }
    let logoImageView = UIImageView(image: UIImage(named: "sherwoodlogo"), contentMode: .scaleAspectFit)
    let searchButton = UIButton(title: "Search", titleColor: .black)

    fileprivate func setUpNavBar() {
        let width = view.frame.width - 120 - 16 - 60
        let titleView = UIView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 80)
//        titleView.addSubview(logoImageView)
       
        
        
        titleView.hstack(logoImageView.withWidth(120), UIView(backgroundColor: .clear).withWidth(width),searchButton.withWidth(60))
        navigationItem.titleView = titleView
        
        //        navigationItem.title = "MY NAV BAR"
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        
        let magicalSafeArea: CGFloat = 88
        print(scrollView.contentOffset.y)
        let offset = scrollView.contentOffset.y + magicalSafeArea
        
        let alpha:CGFloat = 1 - ((scrollView.contentOffset.y + magicalSafeArea) / magicalSafeArea)
        [logoImageView, searchButton].forEach{$0.alpha = alpha}
        logoImageView.alpha = alpha
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 410)
    }
}






import SwiftUI
struct MainPreview: PreviewProvider {
    static var previews: some View  {
//        Text("main preview")
        ContainerView().edgesIgnoringSafeArea(.all)
        
    }
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: MainController())
        }
        
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
    }
}
