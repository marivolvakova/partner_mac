
import Foundation

class RestRequest: NSObject {
    enum HttpErrors: Int {
         case OK = 200
    }
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: SessionDelegate(), delegateQueue: nil)
     }()
    
    init(_ url: String, method: String, jsonBodyData: Data, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let requrl = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: requrl)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBodyData
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == HttpErrors.OK.rawValue {
                    completionHandler(data, nil)
                } else {
                    completionHandler(data, error)
                }
                return
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}

class SessionDelegate: NSObject, URLSessionDelegate {
    override init() {
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping @Sendable (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

}
