//
//  ViewController.swift
//  CourseBoardAPI
//
//  Created by Nicholas Swift on 10/4/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CourseBoardAPI.login(email: "nswift", password: "q1w2e3", complete: { (bool: Bool, error: NSError?) in
            
            CourseBoardAPI.getCourses(complete: { (courses: [Course]?, error: NSError?) in
                for course in courses ?? [] {
                    CourseBoardAPI.getPostsFromCourse(courseId: course.id!, complete: { (post: [Post]?, error: NSError?) in
                        for p in post ?? [] {
                            print(p.body)
                        }
                    })
                }
            })
            
//            CourseBoardAPI.getPostsFromEnrolledCourses(userId: "578524a4a4e38b03006a2be6", complete: { (posts: [Post]?, error: NSError?) in
//                
//                if let posts = posts {
//                    for post in posts {
//                        print(post.body)
//                    }
//                }
//                
//            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

