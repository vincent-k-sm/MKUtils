
import Alamofire
import Foundation
import MKUtils

open class NetworkCore {
    
    private var defaultHeader: HTTPHeaders = [:]

    let session: Alamofire.Session = .init()
    
    public init() {
        self.defaultHeader.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
    }
    
    public func setCookies(cookies: [HTTPCookie], completion: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for i in cookies {
                self.session.sessionConfiguration.httpCookieStorage?.setCookie(i)
            }
            completion()
        }
        
    }
    
    // 헤더 셋팅해주는 함수
    open func setHeader(_ header: HTTPHeaders?) -> HTTPHeaders? {
        var retHeader: HTTPHeaders = self.defaultHeader
        if let header = header {
            for header in header {
                retHeader.update(header)
            }
        }
        return retHeader
    }
    
}

public extension NetworkCore {

    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        header: HTTPHeaders? = nil,
        params: [String: Any]? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<Data, NetworkErrorInfo>) -> Void
    ) {
        
        let newHeader = self.setHeader(header)
        let req = AF.request(url, method: method, parameters: params, encoding: encoding, headers: newHeader)
        
        req.responseData(completionHandler: { [weak self] response in
            guard let self = self else { return }
            self.responseData(responseData: response, completion: completion)
        })
    }
}

extension NetworkCore {
    private func responseData(responseData: AFDataResponse<Data>, completion: @escaping (Result<Data, NetworkErrorInfo>) -> Void) {
      
        switch responseData.result {
            
            case let .success(data):
                completion(.success(data))
                           
           case let .failure(error):
                var debugMessage: String = error.localizedDescription
                var message: String = ""
                
                if let data = responseData.data {
                    message = String(data: data, encoding: .utf8) ?? ""
                }
                
                let newError: NetworkErrorInfo = .init(
                    requestURL: responseData.request?.url?.absoluteString ?? "",
                    errorCode: responseData.response?.statusCode ?? -1,
                    debugMessage: debugMessage,
                    message: message
                )
                
                completion(.failure(newError))
                       
        }
    }
}
