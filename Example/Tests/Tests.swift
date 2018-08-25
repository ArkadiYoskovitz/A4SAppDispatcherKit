import XCTest
@testable import A4SAppDispatcherKit

class Tests : XCTestCase {
    
    var sut : TestAppDelegate!

    class TestAppDelegate : A4SAppDelegateDispatcher {
        
        var didFinishLaunchingCalled = 0
        let service : TestService
        
        override init() {
            didFinishLaunchingCalled = 0
            service = TestService()
        }
        override func obtainServices() -> [A4SAppDelegateService] {
            return [service]
        }
        
        override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            didFinishLaunchingCalled += 1
            return false
        }
    }

    class TestService : NSObject , A4SAppDelegateService {
    
        var willFinishLaunchingCalled : Int = 0
        var  didFinishLaunchingCalled : Int = 0
        
        func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            willFinishLaunchingCalled += 1
            return true
        }
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            didFinishLaunchingCalled += 1
            return false
        }
        
        override func responds(to aSelector: Selector!) -> Bool {
            if aSelector == #selector(UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)) {
                return false
            } else {
                return super.responds(to: aSelector)
            }
        }
    }

    override func setUp() {
        super.setUp()
        sut = TestAppDelegate()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDispatchToServiceWorksSuccess() {
        // given
        let service = sut.service
        // When
        _ = sut.application(UIApplication.shared, willFinishLaunchingWithOptions: [:])
        // Then
        XCTAssert(service.willFinishLaunchingCalled == 1, "willFinishLaunchingCalled should be one")
    }
    
    func testDispatchToServiceWorksFailure() {
        // given
        let service = sut.service
        // When
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        // Then
        XCTAssert(service.didFinishLaunchingCalled == 0, "didFinishLaunchingCalled should be zero")
    }
    func testDispatchToSubclassWorksSuccess() {
        // given
        
        // When
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        // Then
        XCTAssert(sut.didFinishLaunchingCalled == 1, "didFinishLaunchingCalled should be one")
    }
}
