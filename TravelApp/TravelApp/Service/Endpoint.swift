//
//  Endpoint.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 13.06.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
}

enum Endpoint {
    case getUsers
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return Constants.NetworkConstant.baseURL
    }
    
    var path: String {
        switch self {
        case .getUsers:
//            return "/users"
            return Constants.NetworkConstant.getUsers
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError("Base URL Error") }
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}
