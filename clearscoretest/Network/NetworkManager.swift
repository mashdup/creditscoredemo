//
//  NetworkManager.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import Foundation

class NetworkManager {
    
    static var `default`: NetworkManager = {
        return NetworkManager()
    }()
    
    enum Method: String {
        case get = "GET",
             post = "POST",
             put = "PUT",
             update = "UPDATE"
    }
    
    private var session: URLSession { URLSession.shared }
    
    private var baseUrl: URL? {
        URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com")
    }
    
    func request<T: Decodable>(_ objectType: T.Type, method: Method = .get, path: String?, completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        guard let baseUrl = baseUrl else {
            completion(.failure(NSError(domain: "NO_BASE_URL_FOUND", code: 400, userInfo: nil)))
            return
        }
        
        var url = baseUrl

        if let path = path {
            url = baseUrl.appendingPathComponent(path)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let response = response else {
                completion(.failure(NSError(domain: "NO_DATA_OR_RESPONSE", code: 0, userInfo: nil)))
                return
            }
            do {
                #if DEBUG
                print(response)
                
                let jsonString = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                print(jsonString)
                #endif
                try self.checkResponse(response as? HTTPURLResponse)
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(error))
                    return
                }
                let backendError = NSError(domain: response.debugDescription, code: response.statusCode, userInfo: ["response": response])
                
                completion(.failure(backendError))
            }
        }
        
        task.resume()
    }
    
    func checkResponse(_ response: HTTPURLResponse?) throws {
        guard let response = response else {
            throw NSError(domain: "NOT_VALID_HTTP_RESPONSE", code: 400, userInfo: nil)
        }
        switch response.statusCode {
        case 200...299:
            #if DEBUG
            print(response.description)
            #endif
        default:
            throw NSError(domain: response.description, code: response.statusCode, userInfo: nil)
        }
    }
}
