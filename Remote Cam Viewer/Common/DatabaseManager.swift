//
//  DatabaseManager.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import FirebaseDatabase

fileprivate struct DatabaseKeys {
    static let usersRef = "users"
}

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private var db: Database
    
    private init() {
        db = Database.database()
    }
    
    func addCamera(camera: Camera) {
        guard let uid = AuthManager.currentUser?.uid else { return }
        let ref = db.reference().child(DatabaseKeys.usersRef).child(uid)
        do {
            let cameraData = try JSONEncoder().encode(camera)
            guard let cameraDict = try JSONSerialization.jsonObject(with: cameraData,
                                                                    options: .allowFragments) as? [String: Any] else {
                return
            }
            ref.childByAutoId().updateChildValues(cameraDict)
        } catch {
            debugPrint(error)
        }
    }
    
    func fetchCamerasForCurrentUser(completion: @escaping ((_ cameras: [Camera]?) -> Void)) {
        guard let uid = AuthManager.currentUser?.uid else {
            completion(nil)
            return
        }
        let ref = db.reference().child(DatabaseKeys.usersRef).child(uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() == false {
                completion(nil)
                return
            }
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(nil)
                return
            }
            
            let cameras = snapshots.flatMap({ $0.value as? [String: Any]})
                .flatMap({ (dict) -> Camera? in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                        return try JSONDecoder().decode(Camera.self, from: jsonData)
                    } catch {
                        return nil
                    }
                })
            completion(cameras)
        }
        completion(nil)
    }
}
