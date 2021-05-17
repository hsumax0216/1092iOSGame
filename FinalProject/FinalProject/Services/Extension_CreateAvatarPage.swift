//
//  Extension_CreateAvatarPage.swift
//  FinalProject
//
//  Created by 徐浩哲 on 2021/5/17.
//

import SwiftUI

extension CreateAvatarPage{
    func initalApp(){
       bodyPoseSelect = BodyPose.body
        avatarBody = "body/Blazer Black Tee"
        avatarHead = "head/Afro"
        avatarFace = "face/Blank"
        avatarAccessory = "accessories/* None"
        avatarFacialhair = "facial-hair/Full 2"
        
        picWidth = (screenWidth-10*4)/3
    }
    
    func randomAvatar(){
        let bodyArray = body_filename + pose_standing_filename + pose_sitting_filename
        let tmpString = bodyArray.randomElement() ?? "body/Blazer Black Tee"
        let cutIdx = tmpString.index(tmpString.startIndex, offsetBy: 4)
        switch tmpString.prefix(upTo: cutIdx){
        case "body":
            bodyPoseSelect = BodyPose.body
        case "pose":
            let poseIdx = tmpString.index(tmpString.startIndex, offsetBy: 13)
            if tmpString.prefix(upTo: poseIdx) == "pose/standing"{
                bodyPoseSelect = BodyPose.standing
            }
            else{
                bodyPoseSelect = BodyPose.sitting
            }
        default:
            print("random switch default")
        }
        avatarBody = tmpString
        avatarHead = head_filename.randomElement() ?? "head/Afro"
        avatarFace = face_filename.randomElement() ?? "face/Blank"
        avatarAccessory = accessories_filename.randomElement() ?? "accessories/* None"
        avatarFacialhair = facial_hair_filename.randomElement() ?? "facial-hair/Full 2"
    }
    
}
