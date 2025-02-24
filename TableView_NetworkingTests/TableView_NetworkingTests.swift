//
//  TableView_NetworkingTests.swift
//  TableView+NetworkingTests
//
//  Created by Tia M on 2/22/25.
//

import XCTest
@testable import TableView_Networking

final class UsersViewControllerSpy: IUsersViewController {
    
    var presenter: IUsersPresenter
    
    required init(presenter: IUsersPresenter) {
        self.presenter = presenter
    }
    
    var reloadTableCalles = false
    
    func reloadTable() {
        reloadTableCalles = true
    }
}

final class UsersPresenterSpy: IUsersPresenter {
    var view: IUsersViewController?
    var router: IUsersRouter?
//    var usersLoader: IUsersLoader
    
    var users: [User] = []
    
    var viewDidLoadCalled = false
    var userCellSelectedCalled = false

//    init(usersLoader: IUsersLoader) {
//        self.usersLoader = usersLoader
//    }
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func userCellSelected(index: Int) {
        userCellSelectedCalled = true
    }
    
    func getUsersCount() -> Int {
        users.count
    }
    
    func getUser(index: Int) -> User {
        users[index]
    }
}

final class UsersLoaderSpy: IUsersLoader {
    
    var loadUsersCalled = false
    
    func loadUsers(handler: @escaping (Result<TableView_Networking.Users, any Error>) -> Void) {
        loadUsersCalled = true
    }
}


final class UsersScreenTests: XCTestCase {
    
    func testPresenterCallsViewDidLoad() {
        
        // given
        let usersPresenter = UsersPresenterSpy()
        let usersVC = UsersViewController.init(presenter: usersPresenter)
        
        usersPresenter.view = usersVC
       
        // when
        let _ = usersVC.view
        
        // then
        XCTAssertTrue(usersPresenter.viewDidLoadCalled)
    }
    
    func testUserCellSelected() {
        // given
        let usersPresenter = UsersPresenterSpy()
        
        // when
        usersPresenter.userCellSelected(index: 0)

        // then
        XCTAssertTrue(usersPresenter.userCellSelectedCalled)
    }
    
    func testGetUsersCount() {
        // given
        let usersPresenter = UsersPresenterSpy()
        
        usersPresenter.users = [User(
            id: 1,
            firstName: "Emily",
            lastName: "Johnson",
            username: "emilys",
            email: "emily.johnson@x.dummyjson.com",
            phone: "+81 965-431-3024"
        )]
        
        // when
        let count = usersPresenter.getUsersCount()

        // then
        XCTAssertEqual(count, 1)
    }
    
    func testGetUser() {
        // given
        let usersPresenter = UsersPresenterSpy()
        
        usersPresenter.users = [User(
            id: 1,
            firstName: "Emily",
            lastName: "Johnson",
            username: "emilys",
            email: "emily.johnson@x.dummyjson.com",
            phone: "+81 965-431-3024"
        )]
        
        // when
        let user = usersPresenter.getUser(index: 0)

        // then
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.firstName, "Emily")
    }
    
    func testloadUsers() {
        // given
        let usersLoader = UsersLoaderSpy()
        let usersPresenter = UsersPresenter(usersLoader: usersLoader)
        
        // when
        usersPresenter.viewDidLoad()
        
        // then
        XCTAssertTrue(usersLoader.loadUsersCalled)
    }
}

final class NetworkClientStub: INetworkClient {
    
    var data: Data?
    var error: Error?
    
    func fetch(url: URL, handler: @escaping (Result<Data, any Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else if let data = data {
            handler(.success(data))
        }
    }
}

final class UsersLoaderTests: XCTestCase {
    
    func testUsersParsing() throws {
        
        // given
        let json = """
        {
            "users": [
                {
                    "id": 1,
                    "firstName": "Emily",
                    "lastName": "Johnson",
                    "maidenName": "Smith",
                    "age": 28,
                    "gender": "female",
                    "email": "emily.johnson@x.dummyjson.com",
                    "phone": "+81 965-431-3024",
                    "username": "emilys"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        // when
        let users = try decoder.decode(Users.self, from: json)
        
        // then
        let user = users.users[0]
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.firstName, "Emily")
        XCTAssertEqual(user.lastName, "Johnson")
        XCTAssertEqual(user.username, "emilys")
        XCTAssertEqual(user.email, "emily.johnson@x.dummyjson.com")
        XCTAssertEqual(user.phone, "+81 965-431-3024")
    }
    
    func testUsersLoader() {
        
        // given
        let json = """
        {
            "users": [
                {
                    "id": 1,
                    "firstName": "Emily",
                    "lastName": "Johnson",
                    "maidenName": "Smith",
                    "age": 28,
                    "gender": "female",
                    "email": "emily.johnson@x.dummyjson.com",
                    "phone": "+81 965-431-3024",
                    "username": "emilys"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let networkClient = NetworkClientStub()
        networkClient.data = json
        
        let usersLoader = UsersLoader(networkClient: networkClient)
        
        // when
        let expectation = expectation(description: "Users loading expectation")
        
        usersLoader.loadUsers { result in
            
        // then
            switch result {
            case .success(let users):
                let user = users.users[0]
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.firstName, "Emily")
            case .failure:
                XCTFail("Fail loading")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}

