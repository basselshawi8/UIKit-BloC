//
//  BaseBloc.swift
//  Bloc
//
//  Created by iMac on 10/25/22.
//

import Foundation
import Combine
import UIKit


protocol BaseEvent: AnyObject,Equatable {
    
}

protocol BaseState: AnyObject,Equatable {
    
}

protocol BaseBloc {
    
    func addEvent<BaseEvent>(event:BaseEvent)
    var state:Published<BaseState>.Publisher? {get set}
    
}

class BlocListener<B : BaseBloc> {
    
    let bloc:BaseBloc?
    let listener:(_ state:any BaseState)->Void
    let listenWhen:(_ prev:any BaseState, _ current: any BaseState)->Bool
    private var anyCanelable=Set<AnyCancellable>()
    private var prevState:(any BaseState)?
    
    init(bloc: BaseBloc? = nil, listener: @escaping (_: any BaseState)->Void , listenWhen: @escaping (_: any BaseState, _: any BaseState) -> Bool) {
        
        if bloc == nil {
            if let _bloc : B = ServiceLocator.shared.getService() {
                self.bloc = _bloc
            }
            else {
                self.bloc = bloc
            }
        }
        else {
            self.bloc = bloc
        }
        self.listener = listener
        self.listenWhen = listenWhen
        self.bloc?.state?.sink(receiveValue: { receivedState in
            let listenCondition = self.listenWhen(self.prevState ?? receivedState,receivedState)
            self.prevState = receivedState
            if listenCondition == false {
                return
            }
            self.listener(receivedState)
            
            
        }).store(in: &anyCanelable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BlocBuilder<B : BaseBloc> : UIView {
    
    let bloc:BaseBloc?
    let builder:(_ state:any BaseState)->UIView
    let buildWhen:(_ prev:any BaseState, _ current: any BaseState)->Bool
    internal var anyCanelable=Set<AnyCancellable>()
    internal var prevState:(any BaseState)?
    
    init(bloc: BaseBloc? = nil, builder: @escaping (_: any BaseState) -> UIView, buildWhen: @escaping (_: any BaseState, _: any BaseState) -> Bool) {
        
        if bloc == nil {
            if let _bloc : B = ServiceLocator.shared.getService() {
                self.bloc = _bloc
            }
            else {
                self.bloc = bloc
            }
        }
        else {
            self.bloc = bloc
        }
        self.builder = builder
        self.buildWhen = buildWhen
        super.init(frame: CGRect.zero)
        self.bloc?.state?.sink(receiveValue: { receivedState in
            let buildCondition = self.buildWhen(self.prevState ?? receivedState,receivedState)
            self.prevState = receivedState
            if buildCondition == false {
                return
            }
            let content = self.builder(receivedState)
            self.removeAllSubViews()
            self.addSubview(content)
            content.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            
        }).store(in: &anyCanelable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BlocConsumer<B:BaseBloc>:BlocBuilder<B>  {
    
    let listener:(_ state:any BaseState)->Void
    let listenWhen:((_ prev:any BaseState, _ current: any BaseState)->Bool)?
    

    
    init(bloc: BaseBloc? = nil, builder: @escaping (_: any BaseState) -> UIView, buildWhen: @escaping (_: any BaseState, _: any BaseState) -> Bool,listener:@escaping (_: any BaseState) ->Void,listenWhen:@escaping (_: any BaseState, _: any BaseState) -> Bool) {
        
        self.listener = listener
        self.listenWhen = listenWhen
        super.init(bloc:bloc, builder: builder, buildWhen: buildWhen)
    
        self.bloc?.state?.sink(receiveValue: { receivedState in
            let listenCondition = self.listenWhen == nil ? true : self.listenWhen!(self.prevState ?? receivedState,receivedState)
            
            self.prevState = receivedState
          
            if listenCondition == true {
                self.listener(receivedState)
            }
            
            
        }).store(in: &anyCanelable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
