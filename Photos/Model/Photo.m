//
//  Photo.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "Photo.h"

@implementation Photo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"photoId" : @"id",
    };
}

- (NSURL *)thumbnailURL{
    return [NSURL URLWithString:self.thumbnailUrl];
}

- (NSURL *)imageURL{
    return [NSURL URLWithString:self.url];
}

@end
