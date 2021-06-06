//
//  PhotosListViewCell.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotosListViewCell.h"
#import "UIImage+Round.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <YYText/YYLabel.h>

@interface PhotosListViewCell ()
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) YYLabel *titleView;
@property (nonatomic, assign) BOOL load;
@end

@implementation PhotosListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.thumbnailImageView.image = nil;
    self.titleView.text = nil;
    self.load = NO;
}

#pragma mark - Config Subviews
- (void)configUI{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:self.thumbnailImageView];
    __weak UIImageView *weakThumbnailImageView = self.thumbnailImageView;
    [weakThumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10.0);
        make.bottom.mas_equalTo(-10.0);
        make.leading.mas_equalTo(10.0);
        make.width.equalTo(weakThumbnailImageView.mas_height);
    }];
    
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.thumbnailImageView.mas_trailing).offset(11.0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.mas_equalTo(-44.0);
    }];
}

#pragma mark - Load Data
- (void)loadData:(Photo *)photo{
    [self.titleView setText:photo.title];
}

- (void)loadImage:(Photo *)photo{
    [self setLoad:YES];
    __weak UIImageView *weakImageView = self.thumbnailImageView;
    [weakImageView sd_setImageWithURL:photo.thumbnailURL completed:^(UIImage * _Nullable image,
                                                                               NSError * _Nullable error,
                                                                               SDImageCacheType cacheType,
                                                                               NSURL * _Nullable imageURL) {
        CGSize imageViewSize = weakImageView.bounds.size;
        CGFloat imageViewCornerRadius = imageViewSize.width / 2;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *roundImage = [UIImage createRoundedRectImage:image size:imageViewSize radius:imageViewCornerRadius];
            NSString *roundImageKey = [imageURL.absoluteString stringByAppendingString:@"_round"];
            [[SDImageCache sharedImageCache] storeImage:roundImage forKey:roundImageKey completion:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakImageView setImage:roundImage];
            });
        });
    }];
}

- (void)loadImageFromCache:(Photo *)photo{
    self.load = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *roundImageKey = [photo.thumbnailUrl stringByAppendingString:@"_round"];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:roundImageKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = image;
        });
    });
}

- (void)loadImage:(Photo *)photo inRect:(CGRect)inRect inFrame:(CGRect)inFrame{
    if (self.load) {
        return;
    }
    
    if (!CGRectEqualToRect(inRect, CGRectNull) && !CGRectIntersectsRect(inRect, inFrame)) {
        [self loadImageFromCache:photo];
    } else {
        [self loadImage:photo];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter
- (UIImageView *)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [UIImageView new];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _thumbnailImageView;
}

- (YYLabel *)titleView{
    if (!_titleView) {
        _titleView = [YYLabel new];
        _titleView.numberOfLines = 2;
    }
    return _titleView;
}

@end
