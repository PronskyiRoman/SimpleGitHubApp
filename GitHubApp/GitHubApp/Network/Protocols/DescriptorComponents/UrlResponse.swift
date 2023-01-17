//
//  UrlResponse.swift
//  GitHubApp
//
//  Created by -_- on 16.01.2023.
//

import Foundation

final class UrlResponse<T: Codable> {
    // MARK: Value
    // http response status code
    private var data: Data?
    // http response data
    private var code: Int?
    
    // MARK: init
    init() { }
    
    // MARK: update Self
    // paramerets
    // responceData = Data? it is data returned by server for your request
    // responceCode = Int it is HTTPResponse status code for server response
    // returning
    // UrlResponse<T> = self object with associate type of response encapsulated in data object
    func update(selfBy responceData: Data?, and responceCode: Int?) -> UrlResponse<T> {
        code = responceCode
        data = responceData
        
        return self
    }
    
    // MARK: Public Response Data
    var statusCode: NetworkError {
        guard let code = code else { return .unknown((nil, "http code is nil", -1)) }
        
        switch code {
        case 100...199: return .informationalResponses((data, code))
        case 200...299: return .success((data, code))
        case 300...399: return .redirectionMessages((data, code))
        case 400: return .failureClientError((data, code))
        case 401...403: return .unauthorized((data, code))
        case 404...499: return .failureClientError((data, code))
        case 500...599: return .failureServerError((data, code))
            
        default: return .unknown((data, "Unknown http code", code))
        }
    }
    
    // MARK: Public Response Data
    func getData() -> T? {
        guard let data = data, !data.isEmpty else { return nil }
        
        // to possibility download some Json objects from network
        do {
            let decoder = getDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let error as NSError {
            // if get crach here
            // it means you have to check the data structure
            // it can't be decoded from received server data
            assertionFailure("Throw Error: Decoding Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    // in case if you want to preconfigure decoder
    private func getDecoder() -> JSONDecoder {
        JSONDecoder()
    }
}
