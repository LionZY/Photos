//
//  PhotosListViewController.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "PhotosListViewController.h"
#import "Photo.h"
#import "PhotosListViewCell.h"
#import "PhotosService.h"

#import <Masonry/Masonry.h>
#import <JLRoutes/JLRoutes.h>
#import <YYModel/YYModel.h>

NSString *cellID = @"PhotosListViewCell";

@interface PhotosListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *photosListView; //Photos List View
@property (nonatomic, strong) NSArray<Photo *> *photos;
@end

@implementation PhotosListViewController

#pragma mark - Life's Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
}

#pragma mark - Config UI
- (void)configUI{
    
    self.title = @"Photos List";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.photosListView];
    [self.photosListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    Class cellClass = [PhotosListViewCell class];
    [self.photosListView registerClass:cellClass forCellReuseIdentifier:cellID];
}

#pragma mark - Request Data
- (void)requestData{
    [PhotosService photos:^(NSArray<Photo *> * _Nonnull photos, NSError * _Nonnull error) {
        if (error) {
            //TODO: handle error
        } else {
            self.photos = photos;
            [self.photosListView reloadData];
        }
    }];
}

#pragma mark - Implement UITableViewDataSource's Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.photos.count;
    return rows;
}

#pragma mark - Implement UITableViewDelegate's Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    Photo *photo = self.photos[indexPath.row];
    [cell loadData:photo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Photo *photo = self.photos[indexPath.row];
    NSMutableDictionary *photoDictionary = [photo.yy_modelToJSONObject mutableCopy];
    NSURL *url = [NSURL URLWithString:@"/photos_list/detail"];
    [JLRoutes routeURL:url withParameters:photoDictionary];
    
}

#pragma mark - Getters
- (UITableView *)photosListView{
    if (!_photosListView) {
        _photosListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _photosListView.delegate = self;
        _photosListView.dataSource = self;
        _photosListView.tableHeaderView = [UIView new];
        _photosListView.tableFooterView = [UIView new];
    }
    return _photosListView;
}
@end
