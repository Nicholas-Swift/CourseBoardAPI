//
//  ProductsRequestHelper.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/17/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension RequestHelper {
    
    // MARK: Get Current Products -- READY
    static func getCurrentProducts(complete: @escaping ( _ products: [Product]?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/products"
        let url = RequestHelper.baseUrl + path
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
            
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var products: [Product] = []
                    for i in json {
                        
                        let body = i.1 // Json
                        
                        let course = Product(json: body)
                        
                        products.append(course)
                    }
                    
                    complete(products, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
    }
    
    // MARK: Get Specific Product -- READY
    static func getProduct(id: String, complete: @escaping ( _ product: Product?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/products/\(id)"
        let url = RequestHelper.baseUrl + path
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let product = Product(json: json)
                    
                    complete(product, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
        
    }
    
    // MARK: Create Product -- READY
    static func createProduct(product: Product, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/courses"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Set up parameters with course
        var parameters: [String: AnyObject] = [:]
        
        if let instructor = product.instructor?.id {
            parameters["instructor"] = instructor as AnyObject?
        } else {
            complete(false, NSError(domain: "No product instructor id", code: 400, userInfo: nil))
        }

        if let name = product.name {
            parameters["name"] = name as AnyObject?
        } else {
            complete(false, NSError(domain: "No product name", code: 400, userInfo: nil))
        }
        
        if let course = product.course?.id {
            parameters["course"] = course as AnyObject?
        } else {
            complete(false, NSError(domain: "No product course id", code: 400, userInfo: nil))
        }
        
        if let problem = product.problem {
            parameters["problem"] = problem as AnyObject?
        } else {
            complete(false, NSError(domain: "No product problem", code: 400, userInfo: nil))
        }
        
        // Request the data from api
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
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
    
    // MARK: Update Product -- READY
    func updateProduct(product: Product, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/products"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Set up parameters with course
        var parameters: [String: AnyObject] = [:]
        
        if let instructor = product.instructor?.id {
            parameters["instructor"] = instructor as AnyObject?
        } else {
            complete(false, NSError(domain: "No product instructor id", code: 400, userInfo: nil))
        }
        
        if let name = product.name {
            parameters["name"] = name as AnyObject?
        } else {
            complete(false, NSError(domain: "No product name", code: 400, userInfo: nil))
        }
        
        if let course = product.course?.id {
            parameters["course"] = course as AnyObject?
        } else {
            complete(false, NSError(domain: "No product course id", code: 400, userInfo: nil))
        }
        
        if let problem = product.problem {
            parameters["problem"] = problem as AnyObject?
        } else {
            complete(false, NSError(domain: "No product problem", code: 400, userInfo: nil))
        }
        
        // Request the data from api
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
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
    
    // MARK: Delete Product -- READY
    func deleteProduct(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/products/\(id)"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Request the data from api
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
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
    
    // MARK: Join Product -- READY
    func joinProduct(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/products/\(id)/join"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
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
    
    // MARK: Leave Product -- READY
    func leaveProduct(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/products/\(id)/leave"
        let url = RequestHelper.baseUrl + path
        
        // Headers and parameters
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
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
    
}
