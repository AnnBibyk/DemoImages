//
//  ScrollViewController.swift
//  d03
//
//  Created by Anna BIBYK on 1/18/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    var imageView : UIImageView?
    var image: UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.imageView = UIImageView(image: self.image!);
        setImageSize(width: self.view.bounds.width);
        self.imageView!.contentMode = .scaleAspectFill;
        self.imageView!.clipsToBounds = true;
        scrollView.addSubview(self.imageView!);
        scrollView.isScrollEnabled = true;
        scrollView.maximumZoomScale = 100;
        scrollView.minimumZoomScale = 1;
        scrollView.delegate = self;
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setImageSize(width: size.width);
    }
    
    func setImageSize(width: CGFloat) {
        self.imageView!.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: self.imageView!.bounds.height / self.imageView!.bounds.width * width
        );
        scrollView.contentSize = imageView!.frame.size;
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return (imageView);
    }
}
