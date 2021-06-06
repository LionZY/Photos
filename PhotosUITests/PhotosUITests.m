//
//  PhotosUITests.m
//  PhotosUITests
//
//  Created by Lion on 2021/6/4.
//

#import <XCTest/XCTest.h>

#import <Masonry/Masonry.h>
#import <JLRoutes/JLRoutes.h>
#import "RootViewController.h"

@interface PhotosUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation PhotosUITests

- (void)setUp {
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
}

- (void)tearDown {
    
}

- (void)testExample {
    XCUIElement *entryElement = self.app.buttons[@"Entry"];
    [entryElement tap];
        
    //TODO: test table scroll performance
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
