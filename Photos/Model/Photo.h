//
//  Photo.h
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
@property (nonatomic, assign) NSInteger photoId; //Map to field “id”
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumbnailUrl;

- (NSURL *)thumbnailURL;
- (NSURL *)imageURL;

@end

NS_ASSUME_NONNULL_END
