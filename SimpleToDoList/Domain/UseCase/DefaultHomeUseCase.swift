//
//  DefaultHomeUseCase.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/21.
//

import Foundation
import RxSwift

final class DefaultHomeUseCase: HomeUseCase {
    
    let cacheRepository: CacheRepository
    
    init(cacheRepository: CacheRepository) {
        self.cacheRepository = cacheRepository
    }
    
    func loadTodoList() -> JobList {
        return Observable<[Job]>.create { [weak self] observe in
            if let savedToDoList: [Job] = self?.cacheRepository.load(.list) {
                observe.onNext(savedToDoList)
            }
            
            return Disposables.create()
        }
    }
    
    func saveToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            var savedJob: [Job] = self?.cacheRepository.load(.list) ?? [Job]()
            savedJob.append(job)
            self?.cacheRepository.save(.list, value: savedJob)
            observe.onNext(savedJob)
            
            return Disposables.create()
        }
    }
    
    func editToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            if var savedJob: [Job] = self?.cacheRepository.load(.list), let index = job.index {
                savedJob[index] = job
                self?.cacheRepository.save(.list, value: savedJob)
                observe.onNext(savedJob)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteToDoList(job: Job) -> JobList {
        return JobList.create { [weak self] observe in
            if var savedJob: [Job] = self?.cacheRepository.load(.list) {
                savedJob.removeAll{ $0 == job }
                self?.cacheRepository.save(.list, value: savedJob)
                observe.onNext(savedJob)
            }
            
            return Disposables.create()
        }
    }
    
}
