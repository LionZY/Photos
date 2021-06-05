//
//  NetworkKit.h
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkKit : NSObject
/// Simple interface for requesting network data
/// @param urlSting  request url sting value
/// @param success  success callback block
/// @param failed  failed callback block
+ (void)GET:(NSString *)urlSting
    success:(void (^)(id _Nullable))success
     failed:(void (^)(NSError * _Nonnull))failed;
@end

NS_ASSUME_NONNULL_END
