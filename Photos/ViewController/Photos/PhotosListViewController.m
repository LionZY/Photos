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
#import <MBProgressHUD/MBProgressHUD.h>
#import <SVProgressHUD/SVProgressHUD.h>

NSString *cellID = @"PhotosListViewCell";

@interface PhotosListViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *photosListView; //Photos List View
@property (nonatomic, strong) NSArray<Photo *> *photos;
@property (nonatomic, assign) CGRect finalPureLandRect;
@end

@implementation PhotosListViewController

#pragma mark - Life's Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PhotosService photos:^(NSArray<Photo *> * _Nonnull photos, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            //TODO: handle error
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } else {
            self.photos = photos;
            [self.photosListView reloadData];
            self.finalPureLandRect = CGRectNull;
            [self loadImagesIfNeed];
        }
    }];
}

#pragma mark - Private Methods
- (void)loadImagesIfNeed{
    [self.photosListView.visibleCells enumerateObjectsUsingBlock:^(__kindof PhotosListViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [self.photosListView indexPathForCell:cell];
        if (indexPath) {
            Photo *photo = self.photos[indexPath.row % 5];
            CGRect cellRect = [self.photosListView rectForRowAtIndexPath:indexPath];
            [cell loadImage:photo inRect:self.finalPureLandRect inFrame:cellRect];
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
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosListViewCell *photoListCell = (PhotosListViewCell *)cell;
    Photo *photo = self.photos[indexPath.row];
    [photoListCell loadData:photo];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Photo *photo = self.photos[indexPath.row];
    NSMutableDictionary *photoDictionary = [photo.yy_modelToJSONObject mutableCopy];
    NSURL *url = [NSURL URLWithString:@"/photos_list/detail"];
    [JLRoutes routeURL:url withParameters:photoDictionary];
    
}

#pragma mark - Implement UIScrollViewDelegate's Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.finalPureLandRect = CGRectNull;
    [self loadImagesIfNeed];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.isTracking) {
        [self loadImagesIfNeed];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (velocity.y > 1) {
        self.finalPureLandRect = CGRectMake(targetContentOffset->x,
                                            targetContentOffset->y,
                                            scrollView.frame.size.width,
                                            scrollView.frame.size.height);
        
        
               
    } else {
        self.finalPureLandRect = CGRectNull;
        [self loadImagesIfNeed];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.finalPureLandRect = CGRectNull;
    [self loadImagesIfNeed];
}


#pragma mark - Getters
- (UITableView *)photosListView{
    if (!_photosListView) {
        _photosListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _photosListView.delegate = self;
        _photosListView.dataSource = self;
        _photosListView.tableHeaderView = [UIView new];
        _photosListView.tableFooterView = [UIView new];
        _photosListView.estimatedRowHeight = 60.0;
        _photosListView.rowHeight = UITableViewAutomaticDimension;
    }
    return _photosListView;
}
@end
