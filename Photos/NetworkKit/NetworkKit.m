//
//  NetworkKit.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "NetworkKit.h"

#import <AFNetworking/AFNetworking.h>

@interface NetworkKit ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@end

@implementation NetworkKit

#pragma mark - Public

/// Simple interface for requesting network data
/// @param urlSting  request url sting value
/// @param success  success callback block
/// @param failed  failed callback block
+ (void)GET:(NSString *)urlSting
               success:(void (^)(id _Nullable))success
                failed:(void (^)(NSError * _Nonnull))failed{
     
    NetworkKit *networkKit = [NetworkKit new];
    [networkKit.manager GET:urlSting
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
