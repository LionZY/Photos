//
//  PhotosService.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotosService.h"
#import "NetworkKit.h"
#import <YYModel/YYModel.h>

@implementation PhotosService
+ (void)photos:(void (^)(NSArray<Photo *> *, NSError *))completeBlock{
    NSString *urlSting = @"https://jsonplaceholder.typicode.com/photos";
    [NetworkKit GET:urlSting success:^(id _Nonnull responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray<Photo *> *photos = [NSArray yy_modelArrayWithClass:Photo.class json:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeBlock) {
                    completeBlock(photos, nil);
                }
            });
        });
    } failed:^(NSError * _Nonnull error) {
        if (completeBlock) {
            completeBlock(nil, error);
        }
    }];
}
@end
