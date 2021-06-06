//
//  PhotoDetailViewController.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotoDetailViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <YYText/YYLabel.h>

@interface PhotoDetailViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *titleLabel;
@end

@implementation PhotoDetailViewController

#pragma mark - Life's Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - Config UI
- (void)configUI{
    
    self.title = @"Photo Detail";
    self.view.backgroundColor = UIColor.whiteColor;

    [self.view addSubview:self.imageView];
    __weak UIImageView *weakImageView = self.imageView;
    [weakImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(30);
        make.trailing.mas_equalTo(-30);
        make.height.equalTo(weakImageView.mas_width);
        make.centerY.equalTo(self.view).offset(-30);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(0.0);
    }];
}

#pragma mark - Public
- (void)loadData:(Photo *)photo{
    UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:photo.thumbnailUrl];
    [self.imageView sd_setImageWithURL:photo.imageURL placeholderImage:thumbnailImage];
    [self.titleLabel setText:photo.title];
}

#pragma mark - Getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YYLabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
