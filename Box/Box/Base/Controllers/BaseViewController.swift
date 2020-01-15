//
//  BaseViewController.swift
//  Box
//
//  Created by Yan Hu on 2019/11/25.
//  Copyright © 2019 yan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy private var backButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "arrow-back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    lazy private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = titleColor
        return label
    }()
    
    lazy private(set) var navBar: UIView = {
        let view = UIView()
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(6)
            make.width.height.equalTo(44)
            make.bottom.equalTo(view)
        }
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.height.equalTo(44)
            make.bottom.equalTo(view)
        }
        return view
    }()
    
    override var title: String? {
        didSet {
            titleLable.text = title
        }
    }
    
    var titleColor: UIColor = .white {
        didSet {
            titleLable.textColor = titleColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backButton.isHidden = navigationController?.viewControllers.count == 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .purple
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(44 + statusBarHeight)
            make.top.equalTo(view)
        }
    }
    
    @objc func back() {
        back(true)
    }
    
    func back(_ animation: Bool = true) {
        if isModal {
            dismiss(animated: animation, completion: nil)
        } else {
            navigationController?.popViewController(animated: animation)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    let statusBarHeight = Config.statusBarHeight
    let margin = Config.margin
    let margin1 = Config.margin1
    let margin2 = Config.margin2
    let cornerRadiusLarge = Config.cornerRadiusLarge
    let cornerRadiusSmall = Config.cornerRadiusSmall
    let space = Config.space
    
    let itemGap: CGFloat = Config.itemGap
    let iconLength1 = Config.iconLength1

}

class BaseScrollViewController: BaseViewController {
    lazy private(set) var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.width.equalTo(scrollView)
        }
        return scrollView
    }()
    
    lazy private(set) var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .modena
        view.cornerRadius = cornerRadiusLarge
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(margin)
            make.right.bottom.equalTo(view).offset(-margin)
            make.left.equalTo(margin)
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        return presentingViewController != nil ||
               navigationController?.presentingViewController?.presentedViewController === navigationController ||
               tabBarController?.presentingViewController is UITabBarController
    }
    
}