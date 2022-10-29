//
//  ActivityScreen.swift
//  Bloc
//
//  Created by iMac on 10/25/22.
//

import Foundation
import UIKit

class ActivityScreen : UIViewController {
    
    lazy var activityView : ActivityView? = {
        guard let bloc : ActivityBloc = ServiceLocator.shared.getService() else {
            return nil
        }
        return ActivityView(bloc: bloc)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(activityView!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        activityView!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview()
            make.height.equalTo(500)
        }
    }
}
