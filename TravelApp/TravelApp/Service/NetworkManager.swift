//
//  NetworkManager.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 13.06.2024.
//

import Foundation

protocol ServiceType {
    typealias completionHandler<T> = Swift.Result<T, Error>
    func getUsers(completion: @escaping (completionHandler<[User]>) -> Void)
}

struct NetworkManager {
    
    enum SerializationError: Swift.Error {
        case requestError(internal: Swift.Error)
        case serializationError(internal: Swift.Error)
    }
    
    static let shared = NetworkManager()
    private init() { }
    
    //MARK: Base Func
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(SerializationError.requestError(internal: error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (response.statusCode >= 200 && response.statusCode <= 299) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(SerializationError.serializationError(internal: error)))
            }
        }
        
        task.resume()
    }
}

//MARK: - Get Users
extension NetworkManager: ServiceType {
    
    func getUsers(completion: @escaping (completionHandler<[User]>) -> Void) {
        let endpoint = Endpoint.getUsers
        request(endpoint, completion: completion)
    }
}
