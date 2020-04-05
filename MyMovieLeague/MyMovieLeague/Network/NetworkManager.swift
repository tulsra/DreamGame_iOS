
import Foundation
import Alamofire
import ObjectMapper

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String:Any]
public typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case serverError = "Internal Server Error"
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

public enum Method: String {
    case appLatestVersion = "/api/Public/GetAppLatestVersion"
    case splashSettings = "/api/Public/GetSplashSettings"
    case verifyPhoneNumber = "/api/verify_phone_number"
    case verifyToken = "/connect/token"

    case getProfile = "/api/Profile"
    case saveProfile = "/api/Profile/SaveProfile"
    case movie = "/api/Movie"
    
}

enum NetworkEnvironment: String {
    case sandbox = "http://dreammovieapi.azurewebsites.net"
    case production = "http://dreammovieapi.azurewebsites.net/api"
}

enum Result<String>{
    case success
    case failure(String)
}


class NetworkManager {
    
    let environment : NetworkEnvironment = .sandbox
    var method:Method = .appLatestVersion
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> String{
        switch response.statusCode {
        case 200...299: return "success"
        case 400...499: return NetworkResponse.authenticationError.rawValue
        case 500: return NetworkResponse.serverError.rawValue
        case 501...599: return NetworkResponse.badRequest.rawValue
        case 600: return NetworkResponse.outdated.rawValue
        default: return NetworkResponse.failed.rawValue
        }
    }

    
    func get(method: Method, urlParam: Parameters, bodyParm: Parameters? ,completion: @escaping (_ resopnse: Any?,_ error: String?)->()){
        
        self.method = method
        if !Common.hasConnectivity() {
            completion(nil,networkUnavailable)
            return
        }
        let url =  String(format:"\(environment.rawValue)\(method.rawValue)?\(urlParam.urlEncodeString)")
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var request = URLRequest(url: try! urlString!.asURL())
        request.httpMethod = HTTPMethod.get.rawValue
        
        if getAuthToken() != "" {
            print(getAuthToken())
            request.addValue(getAuthToken(), forHTTPHeaderField: "Authorization")
        }
        
        if let bodyParameters = bodyParm {
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyParameters)
            request.httpBody = jsonData
        }
        
        
        AF.request(request).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                guard let responseData = response.data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                let jsonString = String(data: responseData, encoding: String.Encoding.utf8) ?? ""
                print(jsonString)
                
                if let respObj = self.obj(JSONString: jsonString) {
                    completion(respObj, nil)
                }
                else {
                    completion(nil, jsonString)
                }
            case .failure(let error):
                
                print(error)
                if let resp = response.response {
                    let errorMessage = self.handleNetworkResponse(resp)
                    if errorMessage == NetworkResponse.authenticationError.rawValue {
                        AppController.shared.forceLogoutAction()
                        return
                    }
                    completion(nil, errorMessage)
                }
                else {
                    completion(nil, "We are building... Please wait for some time.")
                }
                
            }
            
        }
    }
    
    func post(method: Method, urlParam: Parameters?, bodyParm: Parameters?,isURLEncode:Bool = true ,completion: @escaping (_ resopnse: Any?,_ error: String?)->()){
        self.method = method
        if !Common.hasConnectivity() {
            completion(nil,networkUnavailable)
            return
        }
        var url = String(format:"\(environment.rawValue)\(method.rawValue)")
        
        if isURLEncode, let parm = urlParam {
            url = String(format:"\(environment.rawValue)\(method.rawValue)?\(parm.urlEncodeString)")
        }
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        var request = URLRequest(url: try! urlString!.asURL())
        request.httpMethod = HTTPMethod.post.rawValue
        
        if getAuthToken() != "", method != .movie  {
            request.addValue(getAuthToken(), forHTTPHeaderField: "Authorization")
        }
        
        var headers = HTTPHeaders.init()
        headers["Content-Type"]   = "application/json"
        if method == .verifyToken {
            headers["Content-Type"]   = "application/x-www-form-urlencoded"
        }
        
        if let bodyParameters = bodyParm {
                 
            if method == .verifyToken {
                
                let str = bodyParameters.urlEncodeString
                let data = Data(str.utf8)
                request.httpBody  = data
                
            }
            else {
                var  jsonData = NSData()
                
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted) as NSData
                } catch {
                    print(error.localizedDescription)
                }
                
                request.allHTTPHeaderFields = headers
                request.httpBody = jsonData as Data
            }
        }
        
        AF.request(request).validate().responseData { response in
            
            switch response.result {
            case .success:
                guard let responseData = response.data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                let jsonString = String(data: responseData, encoding: String.Encoding.utf8) ?? ""
                print(jsonString)
                if method == .verifyToken {
                    completion(jsonString, nil)
                    return
                }
                
                if let respObj = self.obj(JSONString: jsonString) {
                    completion(respObj, nil)
                }
                else {
                    completion(nil, jsonString)
                }
                    
            case .failure(let error):
                print(error)
                switch method {
                default:
                    if let kResp = response.response {
                        let errorMessage = self.handleNetworkResponse(kResp)
                        if errorMessage == NetworkResponse.authenticationError.rawValue {
                            if method != .verifyPhoneNumber || method != .verifyToken {
                                AppController.shared.forceLogoutAction()
                            }
                            completion(nil, errorMessage)
                            return
                        }
                        completion(nil, errorMessage)
                    }
                    else {
                        completion(nil, "Server not responding. Please try after some time.")
                    }
                    
                }
            }
        }
        
    }
   
    
    func put(method: Method, parameters: Parameters,isURLEncode:Bool = true ,completion: @escaping (_ resopnse: Any?,_ error: String?)->()){
        self.method = method
        if !Common.hasConnectivity() {
            completion(nil,networkUnavailable)
            return
        }
        var url = String(format:"\(environment.rawValue)\(method.rawValue)")
        
        if isURLEncode {
            url = String(format:"\(environment.rawValue)\(method.rawValue)?\(parameters.urlEncodeString)")
        }
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        
        var request = URLRequest(url: try! urlString!.asURL())
        request.httpMethod = HTTPMethod.put.rawValue
        
        if getAuthToken() != ""  {
            request.addValue(getAuthToken(), forHTTPHeaderField: "Authorization")
        }
        
        if !isURLEncode {
            
            var headers = HTTPHeaders.init()
            headers["Content-Type"]   = "application/json"
            
            var  jsonData = NSData()
            
            do {
                jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) as NSData
            } catch {
                print(error.localizedDescription)
            }
            
            request.allHTTPHeaderFields = headers
            request.httpBody = (jsonData as Data)
            
        }
        
        AF.request(request).validate().responseData { response in
            
            switch response.result {
            case .success:
                guard let responseData = response.data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                let jsonString = String(data: responseData, encoding: String.Encoding.utf8) ?? ""
                print(jsonString)
                
                if let respObj = self.obj(JSONString: jsonString) {
                    completion(respObj, nil)
                }
                else {
                    completion(nil, jsonString)
                }
            case .failure(let error):
                print(error)
                switch method {
                default:
                    if let kResp = response.response {
                        let errorMessage = self.handleNetworkResponse(kResp)
                        if errorMessage == NetworkResponse.authenticationError.rawValue {
                            AppController.shared.forceLogoutAction()
                            return
                        }
                        completion(nil, errorMessage)
                    }
                    else {
                        completion(nil, "Server not responding. Please try after some time.")
                    }
                    
                }
            }
            
        }
        
    }
}



