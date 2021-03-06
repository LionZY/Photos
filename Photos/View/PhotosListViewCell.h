//
//  PhotosListViewCell.h
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosListViewCell : UITableViewCell
- (void)loadData:(Photo *)photo;
- (void)loadImage:(Photo *)photo;
- (void)loadImage:(Photo *)photo inRect:(CGRect)inRect inFrame:(CGRect)inFrame;
@end

NS_ASSUME_NONNULL_END
