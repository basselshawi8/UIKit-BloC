//
//  ViewController.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import UIKit
import SnapKit

class SplashScreen: UIViewController {
    
    lazy var summaryView : SummaryView? = {
        guard let bloc : ActivityBloc = ServiceLocator.shared.getService() else {
            return nil
        }
        return SummaryView(bloc: bloc)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = ServiceLocator.shared
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let navigationController = UINavigationController(rootViewController: ActivityScreen())
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navigationController
        
        (UIApplication.shared.delegate as? AppDelegate)?.window?.insertSubview(summaryView!, at: 21)
        summaryView?.snp.makeConstraints({ make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        })
    }
    
}

