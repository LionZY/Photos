//
//  PhotosTests.m
//  PhotosTests
//
//  Created by Lion on 2021/6/4.
//

#import <XCTest/XCTest.h>
#import <AFNetworking/AFNetworking.h>

@interface PhotosTests : XCTestCase
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@end

@implementation PhotosTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testNetworkApi{
    
    /*
    XCTestExpectation *ex = [self expectationWithDescription:@"request complete"];
    
    NSString *urlSting = @"https://jsonplaceholder.typicode.com/photos";
    [self GET:urlSting success:^(id _Nullable responseObject) {
        XCTAssert(responseObject != nil && [responseObject isKindOfClass:NSArray.class] , @"data error");
        [ex fulfill];
    } failed:^(NSError * _Nonnull error) {
        XCTAssert(error != nil, @"no error");
        [ex fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssert(1, @"request timeout");
    }];
    */
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Public

/// Simple interface for requesting network data
/// @param urlSting  request url sting value
/// @param success  success callback block
/// @param failed  failed callback block
- (void)GET:(NSString *)urlSting
               success:(void (^)(id _Nullable))success
                failed:(void (^)(NSError * _Nonnull))failed{

    [self.manager GET:urlSting
                 parameters:nil
                    headers:nil
                   progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success && responseObject){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed && error){
            failed(error);
        }
    }];
}

#pragma mark - Getter
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:self.sessionConfig];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}

- (NSURLSessionConfiguration *)sessionConfig{
    if (!_sessionConfig) {
        _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return _sessionConfig;
}

@end
