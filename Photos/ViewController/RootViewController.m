//
//  RootViewController.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "RootViewController.h"

#import <Masonry/Masonry.h>
#import <JLRoutes/JLRoutes.h>

@interface RootViewController () 
@property (nonatomic, strong) UIButton *entryButton;
@end

@implementation RootViewController

#pragma mark - Life's Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - Config UI
- (void)configUI{
    self.title = @"Root";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.entryButton];
    [self.entryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Actions
- (void)jumpToListView{
    NSURL *url = [NSURL URLWithString:@"/photos_list"];
    [JLRoutes routeURL:url];
}

#pragma mark - Getter
- (UIButton *)entryButton{
    if (!_entryButton) {
        _entryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_entryButton setTitle:@"Entry" forState:UIControlStateNormal];
        [_entryButton addTarget:self action:@selector(jumpToListView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _entryButton;
}

@end
