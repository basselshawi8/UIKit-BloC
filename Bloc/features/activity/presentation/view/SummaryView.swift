//
//  SummaryView.swift
//  Bloc
//
//  Created by iMac on 10/25/22.
//

import Foundation
import UIKit
import Combine

class SummaryView:UIView {
    
    let bloc : BaseBloc
    
    var anyCancables = Set<AnyCancellable>()
    
    lazy var textLabel : UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.black
        lable.textAlignment = .center
        return lable
    }()

    init(bloc:BaseBloc) {
        self.bloc = bloc
        super.init(frame: CGRect.zero)
        listenToState()
        self.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(30)
        }
        textLabel.text = ""
       
    }
    
    func listenToState(){
        if let _bloc : ActivityBloc = bloc as? ActivityBloc {
            let statePublisher = _bloc.state
            statePublisher?.sink { value in
                if value is GetActivitySuccessState {
                    let successState = value as! GetActivitySuccessState
                    self.textLabel.text = "\(successState.model.type) \(successState.model.price) \(successState.model.activity)"
                    
                }
                else if value is GetActivityFailureState {
                    
                }
                else if value is GetActivityWaitingState {
                    
                }
            }.store(in: &anyCancables)
        }
        
    }
}
