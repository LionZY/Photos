//
//  PhotoDetailViewController.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotoDetailViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface PhotoDetailViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
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
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-30);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(self.imageView.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(0.0);
    }];
}

#pragma mark - Public
- (void)loadData:(Photo *)photo{
    [self.imageView sd_setImageWithURL:photo.imageURL];
    [self.titleLabel setText:photo.title];
}

#pragma mark - Getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
