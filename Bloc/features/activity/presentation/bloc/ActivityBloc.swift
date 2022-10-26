//
//  ActivityBloc.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Combine

class ActivityBloc : BaseBloc{
    
    var state: Published<BaseState>.Publisher? = nil
    @Published var stateValue : any BaseState = InitialActivityState()
    
    private var cancelables : Set<AnyCancellable> = []
    
    
    init(){
        state = $stateValue
    }
    
    func addEvent<ActivityEvent>(event:ActivityEvent) {
        if event is GetActivityEvent {
            mapGetActivityEvent(event: event as! GetActivityEvent)
        }
        
    }
    
    func mapGetActivityEvent(event:GetActivityEvent) {
        stateValue = GetActivityWaitingState()
        let repository : ActivityRespository? = ServiceLocator.shared.getService()
        if let _repository = repository {
            _repository.getActivity(params: event._param).receive(on: DispatchQueue.main).sink { completion in
                switch completion {
                case .failure(let err):
                    self.stateValue = GetActivityFailureState(error: err)
                    break
                case .finished:
                   
                    break
                }
                
            } receiveValue: { model in
                self.stateValue = GetActivitySuccessState(model: model)
                
            }.store(in: &cancelables)

        
        }
    }
    
}


