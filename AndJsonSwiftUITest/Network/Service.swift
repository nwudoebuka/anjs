//
//  Service.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation
protocol ServiceProtocol {
  func getEvents(completion: @escaping (Result<EventModel, Error>)-> Void)
}

final class Service:ServiceProtocol {
  
  
  func getEvents(completion: @escaping (Result<EventModel, Error>)-> Void){
  
    if let path = Bundle.main.path(forResource: "jsondata", ofType: "json") {
      debugPrint("saw get events")
      do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
              if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let eventsResponse = jsonResult as? Any {
                     debugPrint("gotten event is \(jsonResult)")
                let jsonData = try JSONSerialization.data(withJSONObject: eventsResponse)
                  let eventsResponseJson = try JSONDecoder().decode(EventModel.self, from: jsonData)
                completion(.success(eventsResponseJson))
              }else{
               completion(.failure(JsonError.badPayload(message:errorMessages.jsonDefault)))
              }
          } catch {
               // handle error
            debugPrint("saw get events error \(error)")
            completion(.failure(JsonError.badPayload(message:errorMessages.jsonDefault)))
          }
    }else{
      debugPrint("saw get events error first")
      completion(.failure(JsonError.badPayload(message:errorMessages.jsonDefault)))
    }
    

  }
  
}
