//
//  PhotosListViewCell.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotosListViewCell.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface PhotosListViewCell ()
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIImageView *thumbnailMarkImageView;
@property (nonatomic, strong) UILabel *titleView;
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
    
    [self addSubview:self.thumbnailMarkImageView];
    [self.thumbnailMarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.thumbnailImageView);
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
    [self.thumbnailImageView sd_setImageWithURL:photo.thumbnailURL];
    [self.titleView setText:photo.title];
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

- (UIImageView *)thumbnailMarkImageView{
    if (!_thumbnailMarkImageView) {
        _thumbnailMarkImageView = [UIImageView new];
        
        //Avoid performance issues caused by off-screen rendering
        _thumbnailMarkImageView.image = [UIImage imageNamed:@"corner_radius_mask"];
        _thumbnailMarkImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _thumbnailMarkImageView;
}

- (UILabel *)titleView{
    if (!_titleView) {
        _titleView = [UILabel new];
        _titleView.numberOfLines = 2;
    }
    return _titleView;
}

@end
