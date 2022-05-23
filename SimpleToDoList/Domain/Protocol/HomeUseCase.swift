//
//  HomeUseCase.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import Foundation
import RxSwift

typealias JobList = Observable<[Job]>

protocol HomeUseCase {
    
    func loadTodoList() -> JobList
    func saveToDoList(job: Job) -> JobList
    func editToDoList(job: Job) -> JobList
    func deleteToDoList(job: Job) -> JobList
    
}
