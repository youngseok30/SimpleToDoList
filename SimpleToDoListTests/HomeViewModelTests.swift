//
//  HomeViewModelTests.swift
//  SimpleToDoListTests
//
//  Created by Ethan Lee on 2022/05/23.
//

import XCTest
import RxSwift
import RxTest
@testable import SimpleToDoList

class HomeViewModelTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        self.viewModel = HomeViewModel(
            homeUseCase: MockHomeUseCase()
        )
        self.disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    func test_addJobEvent() {
        let mockAddJob = Job(index: 3, description: "mock job")
        let input = HomeViewModel.Input(viewDidLoadEvent: nil, addJobEvent: Observable.just(mockAddJob), editJobEvent: nil, deleteJobEvent: nil)
        let result = self.viewModel.convert(input: input, disposeBag: self.disposeBag).jobList
        
        XCTAssert(result.value.contains(mockAddJob))
    }
    
    func test_editJobEvent() {
        let mockEditJob = Job.init(index: 2, description: "edit mock job")
        let input = HomeViewModel.Input(viewDidLoadEvent: nil, addJobEvent: nil, editJobEvent: Observable.just(mockEditJob), deleteJobEvent: nil)
        let result = self.viewModel.convert(input: input, disposeBag: self.disposeBag).jobList
        
        XCTAssert(result.value.contains(mockEditJob))
    }
    
    func test_removeJobEvent() {
        let mockRemoveJob = Job.init(index: 2, description: "exercise")
        let input = HomeViewModel.Input(viewDidLoadEvent: nil, addJobEvent: nil, editJobEvent: nil, deleteJobEvent: Observable.just(mockRemoveJob))
        let result = self.viewModel.convert(input: input, disposeBag: self.disposeBag).jobList
        
        XCTAssert(!result.value.contains(mockRemoveJob))
    }
    
    func test_viewdidLoadEvent() {
        let input = HomeViewModel.Input(viewDidLoadEvent: Observable.just(()), addJobEvent: nil, editJobEvent: nil, deleteJobEvent: nil)
        let result = self.viewModel.convert(input: input, disposeBag: self.disposeBag).jobList
        
        XCTAssert(!result.value.isEmpty)
    }
}
