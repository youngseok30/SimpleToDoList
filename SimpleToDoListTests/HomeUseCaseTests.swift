//
//  HomeUseCaseTests.swift
//  SimpleToDoListTests
//
//  Created by Ethan Lee on 2022/05/21.
//

import XCTest
import RxSwift
import RxTest
@testable import SimpleToDoList

class HomeUseCaseTests: XCTestCase {
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var homeUseCase: HomeUseCase!
    private var cacheRepository: CacheRepository!
    private var mockJob: Job!

    override func setUpWithError() throws {
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.cacheRepository = DefaultCacheRepository()
        self.homeUseCase = DefaultHomeUseCase(
            cacheRepository: self.cacheRepository
        )
        
        self.mockJob = Job(index: 0, description: "sleep")
    }

    override func tearDownWithError() throws {
        self.cacheRepository = nil
        self.homeUseCase = nil
        self.disposeBag = nil
    }
        
    func test_saveTodoList() {
        self.homeUseCase.saveToDoList(job: self.mockJob)
            .subscribe(onNext:{ result in
                XCTAssert(true)
            },
            onError: { error in
                XCTAssert(false)
            }).disposed(by: self.disposeBag)
    }
    
    func test_loadToDoList() {
        self.homeUseCase.loadTodoList()
            .subscribe(onNext:{ result in
                XCTAssert(true)
            },
            onError: { error in
                XCTAssert(false)
            }).disposed(by: self.disposeBag)
    }
    
    func test_deleteToDoList() {
        self.homeUseCase.deleteToDoList(job: self.mockJob)
            .subscribe(onNext:{ result in
                XCTAssert(true)
            },
            onError: { error in
                XCTAssert(false)
            }).disposed(by: self.disposeBag)
    }
    
}
