//
//  HomeViewModel.swift
//  SimpleToDoList
//
//  Created by Ethan Lee on 2022/05/23.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
            
    struct Input {
        let viewDidLoadEvent: Observable<Void>?
        let addJobEvent: Observable<Job>?
        let editJobEvent: Observable<Job>?
        let deleteJobEvent: Observable<Job>?
    }
    
    struct Output {
        let jobList = BehaviorRelay<[Job]>(value: [])
    }
    
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func convert(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent?
            .subscribe(onNext: { [weak self] in
                self?.homeUseCase.loadTodoList()
                    .subscribe(onNext: { jobList in
                        output.jobList.accept(jobList)
                    }).disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.addJobEvent?
            .subscribe(onNext: { [weak self] job in
                self?.homeUseCase.saveToDoList(job: job)
                    .subscribe(onNext: { jobList in
                        output.jobList.accept(jobList)
                    }).disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.editJobEvent?
            .subscribe(onNext: { [weak self] job in
                self?.homeUseCase.editToDoList(job: job)
                    .subscribe(onNext: { jobList in
                        output.jobList.accept(jobList)
                    }).disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.deleteJobEvent?
            .subscribe(onNext: { [weak self] job in
                self?.homeUseCase.deleteToDoList(job: job)
                    .subscribe(onNext: { jobList in
                        output.jobList.accept(jobList)
                    }).disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    
}
