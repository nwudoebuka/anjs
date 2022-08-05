//
//  MainViewModel.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation
import CoreData
import UIKit

enum EventsViewModelState {
    case EventsViewModelDidStartRetrievingItems
    case EventsViewModelDidFailToRetrieveItems
    case EventsViewModelDidEndRetrievingItems
}

protocol EventsViewModelDelegate{
    func EventsViewModelDidTransitionToState(model: MainViewModel, state: EventsViewModelState)
}

final class MainViewModel: ObservableObject  {
    @Published var tableData:[Event]?
    @Published var mainData:[Event]?
    private var apiLoader: ServiceProtocol?
    public var delegate:EventsViewModelDelegate?
    var eventList: [EventModel]?
    var errorMessage: String?
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
      
    }
    
    public func getEvents() {
        delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidStartRetrievingItems)
        apiLoader?.getEvents(completion: { [weak self] result in
            guard let self = self else {
                return
            }
    
            switch result {
            case .success(let response):
             
              self.eventList = response.children
              
              var children = self.eventList?.map { $0.children }
              let childrenFlat = children?.flatMap { $0 }.compactMap{ $0 }
              let eventList = childrenFlat.map{$0.map{$0.events}.flatMap { $0 }.compactMap{ $0 }}
              self.tableData = eventList
              self.mainData = self.tableData
              self.delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidEndRetrievingItems)
            case .failure(let failure):
              debugPrint("failed viewmodel \(failure)")
              self.errorMessage = failure.localizedDescription
              self.delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidFailToRetrieveItems)
           
            }
        })
    }
    

}
