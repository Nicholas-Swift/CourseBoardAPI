//
//  CourseRequestHelper.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/6/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension RequestHelper {
    
    // MARK: Get Current Courses -- READY
    static func getCurrentCourses(complete: @escaping ( _ courses: [Course]?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/current-courses"
        let url = RequestHelper.baseUrl + path
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
                // Success
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        var courses: [Course] = []
                        for i in json {
                            
                            print(json)
                            let body = i.1 // Json
                            
                            let course = Course(json: body)
                            
                            courses.append(course)
                        }
                        
                        complete(courses, nil)
                    }
                
                // Failure
                case .failure(let error):
                    print("error:")
                    print(error)
                    complete(nil, error as NSError?)
            }
        }
    }
    
    // MARK: Get Specific Course -- READY
    static func getCourse(id: String, complete: @escaping ( _ course: Course?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/courses/\(id)"
        let url = RequestHelper.baseUrl + path
        
        // Request the data from api
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let course = Course(json: json)
                    
                    complete(course, nil)
                }
                
            // Failure
            case .failure(let error):
                print("error:")
                print(error)
                complete(nil, error as NSError?)
            }
        }
        
    }
    
    // MARK: Create Course -- READY
    static func createCourse(course: Course, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/courses"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Set up parameters with course
        var parameters: [String: AnyObject] = [:]
        
        if let instructor = course.instructor?.id {
            parameters["instructor"] = instructor as AnyObject?
        } else {
            complete(false, NSError(domain: "No course instructor id", code: 400, userInfo: nil))
        }
        
        if let title = course.title {
            parameters["title"] = title as AnyObject?
        } else {
            complete(false, NSError(domain: "No course title", code: 400, userInfo: nil))
        }
        
        if let description = course.description {
            parameters["description"] = description as AnyObject?
        } else {
            complete(false, NSError(domain: "No course description", code: 400, userInfo: nil))
        }
        
        if let startsOn = course.startsOn {
            parameters["startsOn"] = startsOn as AnyObject?
        } else {
            complete(false, NSError(domain: "No course start date", code: 400, userInfo: nil))
        }
        
        if let endsOn = course.endsOn {
            parameters["endsOn"] = endsOn as AnyObject?
        } else {
            complete(false, NSError(domain: "No course end date", code: 400, userInfo: nil))
        }
        
        if let location = course.location {
            parameters["location"] = location as AnyObject?
        } else {
            complete(false, NSError(domain: "No course location", code: 400, userInfo: nil))
        }
        
        if let hours = course.hours {
            parameters["hours"] = hours as AnyObject?
        } else {
            complete(false, NSError(domain: "No course hours", code: 400, userInfo: nil))
        }
        
        if let objectives = course.objectives {
            parameters["objectives"] = objectives as AnyObject?
        } else {
            complete(false, NSError(domain: "No course objectives", code: 400, userInfo: nil))
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
    
    // MARK: Update Course -- READY
    func updateCourse(course: Course, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and url
        let path = "/api/courses"
        let url = RequestHelper.baseUrl + path
        
        // Headers
        let headers = ["Authorization": "Basic " + RequestHelper.authToken]
        
        // Set up parameters with course
        var parameters: [String: AnyObject] = [:]
        
        if let instructor = course.instructor?.id {
            parameters["instructor"] = instructor as AnyObject?
        } else {
            complete(false, NSError(domain: "No course instructor id", code: 400, userInfo: nil))
        }
        
        if let title = course.title {
            parameters["title"] = title as AnyObject?
        } else {
            complete(false, NSError(domain: "No course title", code: 400, userInfo: nil))
        }
        
        if let description = course.description {
            parameters["description"] = description as AnyObject?
        } else {
            complete(false, NSError(domain: "No course description", code: 400, userInfo: nil))
        }
        
        if let startsOn = course.startsOn {
            parameters["startsOn"] = startsOn as AnyObject?
        } else {
            complete(false, NSError(domain: "No course start date", code: 400, userInfo: nil))
        }
        
        if let endsOn = course.endsOn {
            parameters["endsOn"] = endsOn as AnyObject?
        } else {
            complete(false, NSError(domain: "No course end date", code: 400, userInfo: nil))
        }
        
        if let location = course.location {
            parameters["location"] = location as AnyObject?
        } else {
            complete(false, NSError(domain: "No course location", code: 400, userInfo: nil))
        }
        
        if let hours = course.hours {
            parameters["hours"] = hours as AnyObject?
        } else {
            complete(false, NSError(domain: "No course hours", code: 400, userInfo: nil))
        }
        
        if let objectives = course.objectives {
            parameters["objectives"] = objectives as AnyObject?
        } else {
            complete(false, NSError(domain: "No course objectives", code: 400, userInfo: nil))
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
    
    // MARK: Delete Course -- READY
    func deleteCourse(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/courses/\(id)"
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
    
    // MARK: Enroll Course -- READY
    func enrollCourse(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/courses/\(id)/enroll"
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
    
    // MARK: Unenroll Course -- READY
    func unenrollCourse(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/courses/\(id)/unenroll"
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
    
    // MARK: Publish Course -- READY
    func publishCourse(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/courses/\(id)/publish"
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
    
    // MARK: Unpublish Course -- READY
    func unpublishCourse(id: String?, complete: @escaping ( _ bool: Bool?, _ error: NSError?) -> Void) {
        
        // Create the path and resource
        let path = "/api/courses/\(id)/unpublish"
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
    
}
