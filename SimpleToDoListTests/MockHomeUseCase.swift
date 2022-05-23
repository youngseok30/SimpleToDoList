//
//  MockHomeUseCase.swift
//  SimpleToDoListTests
//
//  Created by Ethan Lee on 2022/05/23.
//

import Foundation
import RxSwift
@testable import SimpleToDoList

final class MockHomeUseCase: HomeUseCase {
    
    private var index = 0
    private var mocJobList: [Job] = [.init(index: 0, description: "study swift"),
                                     .init(index: 1, description: "buld app"),
                                     .init(index: 2, description: "exercise")]
    
    func loadTodoList() -> JobList {
        return JobList.create { [weak self] observe in
            observe.onNext(self?.mocJobList ?? [])
            
            return Disposables.create()
        }
    }
    
    func saveToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            self?.mocJobList.append(job)
            observe.onNext(self?.mocJobList ?? [])
            
            return Disposables.create()
        }
    }
    
    func editToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            if let index = job.index {
                self?.mocJobList[index] = job
            }
            
            observe.onNext(self?.mocJobList ?? [])

            return Disposables.create()
        }
    }
    
    func deleteToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            if let index = job.index {
                self?.mocJobList.remove(at: index)
            }
            
            observe.onNext(self?.mocJobList ?? [])

            return Disposables.create()
        }
    }
        
}
