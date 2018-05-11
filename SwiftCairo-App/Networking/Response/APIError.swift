//
//  APIError.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 3/28/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation

/*
 0 => problem in service
 1 => true service
 2 => the user information not matched “ email || password“
 3 => the user is block
 4 => the user not activated his account
 5 => the user not registered
 6 => the user not auth
 7 => in socialite register missing parm
 8 => email required or duplicated(user pre-registered in register mode - user in project when invited mode)
 9=> password required or min:6 char
 10 => not supported lang, supported lang (ar,en,tr)
 11=> timezone is required
 12 => username missing or duplicated
 13=> name of project required
 14=> url of project has error (used before or have syntax error)
 15=> team emails has error (not email or duplicated)
 16=> can’t create more than 3 project in free account
 17=> user not member in project
 18=> user not have any active project
 19 => TRIAL PERIOD FINISHED
 20=> SUBSCRIPTION PERIOD FINISHED
 21=> project not exists
 22=> PROJECT DELETED
 23 => archived project
 24 => user not in project (current user not member of project)
 25 => project id not sent ( as parameter for  must auth request )
 26=> UNAUTHORIZED ACCESS
 27=> Privacy not exist
 28 => request parameter has error or lack
 
 // tasks page
 29=>  not have access to others user tasks ( usut :privacy  )
 30=> deleted team member tasks can’t show, just admin can show deleted user tasks
 31 => not have access to group tasks
 32=> deleted group tasks can’t show, just admin can show deleted group tasks
 33=> (when update or create task) task title can be empty
 34=> current task has add tag before
 35 => can’t make this action for archived tasks
 36=> not have available space to store files ,founder user used  all available space in all his projects
 37=> receiver user not have privacy to chat others (can't chat with other team member)
 38 => not have permission to delete others tasks (udau)
 39=> DELETE OPERATION DONE JUST FOR YOUR ATTACHMENT (when select many attachment and (one/or more) of them not have access to it, then delete all accessed attachment and make alert for others)
 40=> update fail ,  to to change project founder must be new founder user have subscription account
 41=>  update fail , to change project founder must have subscription account
 42=> project founder date can't update (delete or update privacy)
 43=> duplicate group name
 44=> have active timer
 45=> not have active timer
 46=> not have paused timer
 47=> invited user already member of current project (when send invited)
 48 => invitation not found
 49 => INVITATION HAS BEEN DELETED
 50 => INVITATION has  error
 51 => INVITATION NOT FOR YOU
 52 => project has been deleted
 53 => error in activation operation
 54 => current password wrong
 55=> request reset password has error, email not found
 56=> reset password has error, token error or reset token for other email
 57 => INVITATION_REJECT_BEFORE
 58 => INVITATION_APPORVED_BEFORE
 
 */

/// Errors enum, to be sent back to network caller, so he handle it gracefully.
enum APIError: Int, LocalizedError, Codable {
    case serviceProblem, success, userInfoNotMatching, userBlocked, userNotActivated, userNotAuth, missingParams, emailDublicated, passwordMissing, languageNotSupported, timezoneRequired, usernameDublicated, projectNameReuqired
}
