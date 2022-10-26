//
//  ActivityView.swift
//  Bloc
//
//  Created by iMac on 10/25/22.
//

import Foundation
import UIKit
import Combine

class ActivityView:UIView {
    
    let bloc : BaseBloc
    
    var anyCancables = Set<AnyCancellable>()
    var blocBody:UIStackView?
    
    init(bloc:BaseBloc) {
        self.bloc = bloc
        super.init(frame: CGRect.zero)
        //listenToState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.bloc.addEvent(event: GetActivityEvent(param: GetActivityParam(name: "")))
        buildBloc()
    }
    
    func addBody(_body:UIStackView) {
        blocBody?.removeFromSuperview()
        blocBody = _body
        self.addSubview(blocBody!)
        blocBody?.pin(
            to: self.safeAreaLayoutGuide,
            insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        )
        
    }
    
    @objc func refresh() {
        self.bloc.addEvent(event: GetActivityEvent(param: GetActivityParam(name: "")))
    }
    
}
//MARK: - BlocBuilder

extension ActivityView {
    func buildBloc(){
        let blocBuilder = BlocBuilder<ActivityBloc> { state in
            if state is GetActivitySuccessState {
                
                let successState = state as! GetActivitySuccessState
                return UIStackView().vertical(spacing: 4).views(
                    UILabel().with({ instance in
                        instance.text = successState.model.activity
                        instance.textColor = .black
                    }),
                    UILabel().with({ instance in
                        instance.text = successState.model.type
                        instance.textColor = .black
                    }),
                    successState.model.type.isEmpty == true ? UIView() : UILabel().with({ instance in
                        instance.text = successState.model.link
                        instance.textColor = .black
                    }),
                    UIButton().with({ instance in
                        instance.setTitle("Refresh", for: .normal)
                        instance.setTitleColor(UIColor.systemBlue, for: .normal)
                        instance.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
                    })
                )
            }
            else if state is GetActivityWaitingState {
                return UILabel().with({ instance in
                    instance.text = "Waiting"
                    instance.textColor = .black
                })
            }
            else {
                return UILabel().with({ instance in
                    instance.text = "Failed"
                    instance.textColor = .black
                })
            }
        } buildWhen: { prev, current in
            return current is GetActivitySuccessState || current is GetActivityWaitingState ? true : false
        }
        
        self.addSubview(blocBuilder)
        blocBuilder.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}

//MARK: - Bloc Listener

extension ActivityView {
    func listenToState(){
        
        let _ = BlocListener<ActivityBloc>.init { state in
            
            if state is GetActivitySuccessState {
                
                let successState = state as! GetActivitySuccessState
                
                self.addBody(_body: UIStackView().vertical(spacing: 20).views(
                    UILabel().with({ instance in
                        instance.text = successState.model.activity
                        instance.textColor = .black
                    }),
                    UILabel().with({ instance in
                        instance.text = successState.model.type
                        instance.textColor = .black
                    }),
                    successState.model.type.isEmpty == true ? UIView() : UILabel().with({ instance in
                        instance.text = successState.model.link
                        instance.textColor = .black
                    }),
                    UIButton().with({ instance in
                        instance.setTitle("Refresh", for: .normal)
                        instance.setTitleColor(UIColor.systemBlue, for: .normal)
                        instance.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
                    })
                ))
                
            }
            else if state is GetActivityFailureState {
                
                self.addBody(_body: UIStackView().vertical(spacing: 20).views(
                    
                    UILabel().with({ instance in
                        instance.text = "Failed"
                        instance.textColor = .black
                    })
                    
                ))
            }
            else if state is GetActivityWaitingState {
                
                self.addBody(_body: UIStackView().vertical(spacing: 20).views(
                    
                    UILabel().with({ instance in
                        instance.text = "Waiting"
                        instance.textColor = .black
                    })
                    
                ))
                
            }
            
        } listenWhen: { prev, current in
            return current is GetActivitySuccessState || current is GetActivityWaitingState || current is GetActivityFailureState ? true : false
        }
        
    }
}

