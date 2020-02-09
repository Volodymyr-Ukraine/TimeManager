//
//  RequesterURL.swift
//  TimeManager
//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import Foundation
import Alamofire

public class RequesterURL {
    
    // MARK: -
    // MARK: Constants
    
    static public let ask: RequesterURL = RequesterURL()
    private let kToken: String = "userToken"
    public let mainURL: String = "https://testapi.doitserver.in.ua/api"
    
    // MARK: -
    // MARK: Init

    private init(){
    }
    
    // MARK: -
    // MARK: Methods
    
    public func loginUser(user: LoginData,
                          toDoIfSuccess: ((LoginResultData)->())?,
                          toDoIfError: ((LoginResultData)->())?) {
        let pathEndpoint = mainURL + (user.doRegister ? "/users" : "/auth")
        let json = """
        {
            "email": "\(user.mail)",
            "password": "\(user.password)"
        }
        """
        guard let jsonData = json.data(using: .utf8, allowLossyConversion: false),
            let url = URL(string: pathEndpoint) else {
                print("wrong URL")
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        AF.request(request).responseJSON{ response in
            do{
                let decoder = JSONDecoder()
                guard let data = response.data else {
                    print("Error - Data in nil")
                    return
                }
                print(String(data: data, encoding: .ascii))
                
                let result = try decoder.decode(LoginResultData.self, from: data)
                print(result)
                if let token = result.token {
                    UserDefaults.standard.setValue(token, forKey: self.kToken)
                    toDoIfSuccess?(result)
                } else {
                    UserDefaults.standard.setValue(nil, forKey: self.kToken)
                    toDoIfError?(result)
                }
            } catch {
                print("error: \(error)")
                print("catched data:")
                print(String(data: response.data ?? Data(), encoding: .ascii))
                return
            }
        }
    }
    
    public func getTaskList(_ page: Int,
                            sorting: SortingTypesEnum,
                            direction: Bool,
                            toDoIfSuccess: ((TaskList)->())?,
                            toDoIfError: ((TaskList)->())?){
        let pathEndpoint = mainURL + "/tasks"
        let params = ["page": "\(page)",
                      "sort": sorting.rawValue + ((direction) ? " asc" : "desc")]
        guard let url = URL(string: pathEndpoint) else {
                print("wrong URL")
                return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: self.kToken) ?? "")",
            "Accept": "application/json"
        ]
        AF.request(url, method: .get, parameters: params, headers: headers, interceptor: nil)
            .responseJSON{ response in
                do{
                    let decoder = JSONDecoder()
                    guard let data = response.data else {
                        print("Error - Data in nil")
                        return
                    }
                    print(String(data: data, encoding: .ascii))
                        
                    let result = try decoder.decode(TaskList.self, from: data)
                    print(result)
                    if let meta = result.meta,
                        let tasks = result.tasks {
                        toDoIfSuccess?(TaskList(tasks: tasks, meta: meta, message: nil))
                    } else {
                        toDoIfError?(result)
                    }
                    
                    } catch {
                        print("error: \(error)")
                        print("catched data:")
                        print(String(data: response.data ?? Data(), encoding: .ascii))
                        return
                    }
        }
    }
    
    public func deleteTask(id taskID: Int?,
                           toDoIfSuccess: ( ()->() )?,
                           toDoIfError: ((TaskList)->Void)?){
        guard let id = taskID else {
            toDoIfError?(TaskList(tasks: nil, meta: nil, message: "The task was not saved - You can not delete it"))
            return
        }
        let pathEndpoint = mainURL + "/tasks/\(id)"
               
               guard let url = URL(string: pathEndpoint) else {
                       print("wrong URL")
                       return
               }
               let headers: HTTPHeaders = [
                   "Authorization": "Bearer \(UserDefaults.standard.string(forKey: self.kToken) ?? "")",
                   "Accept": "application/json"
               ]
        AF.request(url, method: .delete, parameters: nil, headers: headers, interceptor: nil)
        .responseJSON{ response in
            do{
                let decoder = JSONDecoder()
                guard let data = response.data else {
                    print("Error - Data in nil")
                    return
                }
                print(String(data: data, encoding: .ascii))
                if data.count == 2 {
                        toDoIfSuccess?()
                }
                let result = try decoder.decode(TaskList.self, from: data)
                print(result)
                if let message = result.message {
                    toDoIfError?(result)
                } else {
                    toDoIfSuccess?()
                }
                
            } catch {
                print("error: \(error)")
                print("catched data:")
                print(String(data: response.data ?? Data(),     encoding: .ascii))
                return
            }
        }
    }
    
    public func updateTask(_ task: TaskData, toDoIfSuccess: ( (TaskDetail)->() )?,
                       toDoIfError: ((TaskDetail)->Void)?){
        
        let pathEndpoint = mainURL + "/tasks/\(task.id)"
           
           guard let url = URL(string: pathEndpoint) else {
                   print("wrong URL")
                   return
           }
           let headers: HTTPHeaders = [
               "Authorization": "Bearer \(UserDefaults.standard.string(forKey: self.kToken) ?? "")",
               "Accept": "application/json"
           ]
        let param: [String: Any] = [ "title": "\(task.title)",
                "dueBy": task.dueBy,
                "priority": "\(task.priority.rawValue)"
            ]
        
        AF.request(url, method: .put, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
    .responseJSON{ response in
        do{
            let decoder = JSONDecoder()
            guard let data = response.data else {
                print("Error - Data in nil")
                return
            }
            print(String(data: data, encoding: .ascii))
            if data.count == 2 {
                    toDoIfSuccess?(TaskDetail(task: nil, message: nil))
                    return
            }
            let result = try decoder.decode(TaskDetail.self, from: data)
            print(result)
            if let message = result.message {
                toDoIfError?(result)
            } else {
                toDoIfSuccess?(result)
            }
            
        } catch {
            print("error: \(error)")
            print("catched data:")
            print(String(data: response.data ?? Data(),     encoding: .ascii))
            return
        }
    }
    }
    
    public func createTask(_ task: TaskData, toDoIfSuccess: ( (TaskDetail)->() )?,
                           toDoIfError: ((TaskDetail)->Void)?){
            
            let pathEndpoint = mainURL + "/tasks"
               
               guard let url = URL(string: pathEndpoint) else {
                       print("wrong URL")
                       return
               }
               let headers: HTTPHeaders = [
                   "Authorization": "Bearer \(UserDefaults.standard.string(forKey: self.kToken) ?? "")",
                   "Accept": "application/json"
               ]
            let param: [String: Any] = [ "title": "\(task.title)",
                    "dueBy": task.dueBy,
                    "priority": "\(task.priority.rawValue)"
                ]
            
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
        .responseJSON{ response in
            do{
                let decoder = JSONDecoder()
                guard let data = response.data else {
                    print("Error - Data in nil")
                    return
                }
                print(String(data: data, encoding: .ascii))
                
                let result = try decoder.decode(TaskDetail.self, from: data)
                print(result)
                if let message = result.message {
                    toDoIfError?(result)
                } else {
                    toDoIfSuccess?(result)
                }
                
            } catch {
                print("error: \(error)")
                print("catched data:")
                print(String(data: response.data ?? Data(),     encoding: .ascii))
                return
            }
        }
        }
}
