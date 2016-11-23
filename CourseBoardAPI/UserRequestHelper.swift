//
//  UserRequestHelper.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/22/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension RequestHelper {
    
    // Get Instructors -- READY
    static func getInstructors(complete: @escaping ( _ instructors: [User]?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/instructors"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        print(headers)
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var instructors: [User] = []
                    for i in json {
                        
                        let body = i.1 // Json
                        
                        let instructor = User(json: body)
                        
                        instructors.append(instructor)
                    }
                    
                    complete(instructors, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
    }
    
    // Get Students -- READY
    static func getStudents(complete: @escaping ( _ students: [User]?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/students"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var students: [User] = []
                    for i in json {
                        
                        let body = i.1 // Json
                        
                        let student = User(json: body)
                        
                        students.append(student)
                    }
                    
                    complete(students, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
    }
    
    // Get Specific User -- READY
    static func getUser(id: String, complete: @escaping ( _ user: User?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/users/\(id)"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let user = User(json: json)
                    
                    complete(user, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
    }
    
    // Get Self -- READY
    static func getMe(complete: @escaping ( _ user: User?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/me"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let user = User(json: json)
                    
                    complete(user, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
    }
    
    // Update Self -- READY
    static func updateMe(user: User, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/me"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // MAKE SURE USER HAS ALL REQUIRED STUFF HERE??
        
        // Request the data from api
        Alamofire.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    complete(true, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(false, error as NSError?)
            }
        }
    }
    
    // Login to Account -- READY
    static func login(email: String, password: String, complete: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/auth/login"
        let url = RequestHelper.baseUrl + path
        
        // Set up parameters
        let parameters = ["email": email, "password": password]
        
        // Request the data from API
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    let token = json["token"].stringValue
                    RequestHelper.authToken = token
                    
                    complete(true, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error: \(error)")
                complete(false, error as NSError?)
            }
        }
    }
    
    // Signup -- READY
    static func signup(email: String, username: String, password: String, complete: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/auth/signup"
        let url = RequestHelper.baseUrl + path
        
        // Set up parameters
        let parameters = ["email": email, "username": username, "password": password]
        
        // Request the data from API
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    complete(true, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(false, error as NSError?)
            }
        }
    }
    
    // Request Password
    static func requestPassword(email: String, username: String, password: String, complete: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/auth/passwords"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from API
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    complete(true, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(false, error as NSError?)
            }
        }
    }
    
    // Update Password
    static func updatePassword(email: String, username: String, password: String, complete: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/auth/passwords"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from API
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    complete(true, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(false, error as NSError?)
            }
        }
    }
    
}
