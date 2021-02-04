//
//  GitApiDataModel.swift
//  GMInterviewApplication
//
//  Created by PRANOTI KULKARNI on 12/21/20.
//

import UIKit

protocol User {
    var authorName: String { get }
    var commitSHA: String { get }
    var commitMessage: String { get }
}
struct UserData: Codable {
    let sha : String?
    let commit : Commit?
    
    struct Commit: Codable {
        let author: Author?
        let message: String?
    }
    
    struct Author: Codable {
        let name: String?
    }
}

extension UserData: User {
    var authorName: String {
        get {
            guard let authorName = self.commit?.author?.name else {
                return "No Author Data"
            }
           return "Author Name: " + authorName
        }
    }
    
    var commitMessage: String {
        get {
            guard let commitMessage = self.commit?.message else {
                return "No Commit Message"
            }
           return "Commit Message: " + commitMessage
        }
    }
    
    var commitSHA: String {
        get {
            guard let sha = self.sha else {
                return "No CommitSHA available"
            }
           return "CommitSHA: " + sha
        }
    }
}
