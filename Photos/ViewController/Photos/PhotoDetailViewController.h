//
//  PhotoDetailViewController.h
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : UIViewController
- (void)loadData:(Photo *)photo;
@end

NS_ASSUME_NONNULL_END
