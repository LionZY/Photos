//
//  Router.m
//  Photos
//
//  Created by Lion on 2021/6/4.
//

#import "Router.h"
#import "NSObject+TopViewController.h"
#import "PhotosListViewController.h"
#import "PhotoDetailViewController.h"
#import "Photo.h"

#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteHandler.h>
#import <YYModel/YYModel.h>

@implementation Router
+ (void)configRouters{
    [self jumpToPhotosList];
    [self jumpToPhotoDetail];
}

+ (void)jumpToPhotosList{
    JLRoutes *routes = [JLRoutes globalRoutes];
    [routes addRoute:@"/photos_list" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *topViewController = [self topViewController];
        UINavigationController *navi = [topViewController navigationController];
        
        //TODO: If navi is nil，present target view controller
        
        PhotosListViewController *photosList = [PhotosListViewController new];
        [navi pushViewController:photosList animated:YES];
        return YES;
    }];
}

+ (void)jumpToPhotoDetail{
    JLRoutes *routes = [JLRoutes globalRoutes];
    NSString *urlString = @"/photos_list/detail";
    [routes addRoute:urlString handler:^BOOL(NSDictionary<NSString *, id> * _Nonnull parameters) {
        UIViewController *topViewController = [self topViewController];
        UINavigationController *navi = [topViewController navigationController];
        
        //TODO: If navi is nil，present target view controller
        Photo *photo = [Photo yy_modelWithDictionary:parameters];
        PhotoDetailViewController *photoDetail = [PhotoDetailViewController new];
        [navi pushViewController:photoDetail animated:YES];
        [photoDetail loadData:photo];
        return YES;
    }];
}

@end
