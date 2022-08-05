//
//  JsonError.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation
public enum JsonError :  Error, LocalizedError {
  case badPayload(message: String)
 
  public var errorDescription: String? {
      switch self {
      case .badPayload(let message):
          return message
  
      }
  }
  
}

struct errorMessages {
    static let jsonDefault = "Something isn't right. Please try again."
}
