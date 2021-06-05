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
        NSArray<Photo *> *photos = [NSArray yy_modelArrayWithClass:Photo.class json:responseObject];
        completeBlock(photos, nil);
    } failed:^(NSError * _Nonnull error) {
        completeBlock(nil, error);
    }];
}
@end
