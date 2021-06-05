//
//  PhotosService.h
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosService : NSObject
+ (void)photos:(void (^)(NSArray<Photo *> *, NSError *))completeBlock;
@end

NS_ASSUME_NONNULL_END
