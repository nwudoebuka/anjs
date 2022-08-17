//
//  MainViewModel.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation
import CoreData
import UIKit

final class MainViewModel: ObservableObject  {
    @Published var tableData:[Event]? = []
    @Published var mainData:[Event]?
    private var apiLoader: ServiceProtocol?
    var eventList: [EventModel]?
    var errorMessage: String?
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
      
    }
    
    public func getEvents() {
        apiLoader?.getEvents(completion: { [weak self] result in
            guard let self = self else {
                return
            }
    
            switch result {
            case .success(let response):
             
              self.eventList = response.children
              self.recursion(response: response)
              self.mainData = self.tableData
            case .failure(let failure):
              debugPrint("failed viewmodel \(failure)")
              self.errorMessage = failure.localizedDescription
           
            }
        })
    }
    
  private func recursion(response: EventModel){
  
    if !response.events.isEmpty{
      tableData?.append(contentsOf: response.events)
      debugPrint("recursive table data is \(tableData)")
      return
    }
    for child in response.children{
      
      recursion(response: child)
    }
  }
  

}
