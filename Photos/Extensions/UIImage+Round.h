//
//  UIImage+Round.h
//  Photos
//
//  Created by Lion on 2021/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(Round)
+ (id)createRoundedRectImage:(UIImage*)image withKey:(NSString *)key;
+ (id)createRoundedRectImage:(UIImage *)image size:(CGSize)size radius:(int)radius;
@end

NS_ASSUME_NONNULL_END
