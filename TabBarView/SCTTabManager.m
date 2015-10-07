//
//  SCTTabManager.m
//  TabBarView
//
//  Created by Shou Cheng Tuan on 2015/10/7.
//  Copyright (c) 2015年 Shou Cheng Tuan . All rights reserved.
//

#import "SCTTabManager.h"

@interface SCTTabManager()
@property (nonatomic) NSInteger tabbedCount;
@end

@implementation SCTTabManager

- (id)init
{
    if (self = [super init]) {
        self.tabBarController = [[UITabBarController alloc] init];
        [self hiddenTabBar:NO];
    }
    return self;
}

- (id)initWithDelegate:(id<SCTTabbedViewManagerDelegate>)delegate withHiddenTabBar:(BOOL)hideTabBar
{
    if (self = [super init]) {
        self.tabBarController = [[UITabBarController alloc] init];
        self.delegate = delegate;
        self.tabBarController.tabBar.hidden = hideTabBar;
    }
    return self;
}

- (void)setup
{
    if ([self.delegate respondsToSelector:@selector(tabbedViewControllers)]) {
        NSArray *array = [self.delegate tabbedViewControllers];
        NSArray *ncArray = [self navigationControllersWithRootViewController:array];
        self.tabBarController.viewControllers = ncArray;
        self.tabbedCount = array.count;
    }
}

- (void)setDelegate:(id<SCTTabbedViewManagerDelegate>)delegate
{
    _delegate = delegate;
    
    UIViewController *delegateVC = (UIViewController *)_delegate;
    [delegateVC.view addSubview:self.tabBarController.view];
    [self setup];
}

- (void)selectTabViewIndex:(NSInteger)index
{
    self.tabBarController.selectedIndex = index;
}

- (NSArray *)navigationControllersWithRootViewController:(NSArray *)viewControllers
{
    NSMutableArray *navigationControllers = [NSMutableArray array];
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        
        if (!self.tabBarController.tabBar.hidden) {
            vc.tabBarItem = [self createTabBarItems:idx];
        }
        UINavigationController *nc = [self createNavigationController:vc];
        [navigationControllers addObject:nc];
    }];
    return navigationControllers;
}

- (UINavigationController *)createNavigationController:(UIViewController *)viewController
{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    return nc;
}

- (UITabBarItem *)createTabBarItems:(NSInteger)index
{
    BOOL haveTitle = [self.delegate respondsToSelector:@selector(tabBarItemTitles)];
    BOOL haveImage = [self.delegate respondsToSelector:@selector(tabBarItemImages)];
    bool haveSelectedImage = [self.delegate respondsToSelector:@selector(tabBarItemSelectedImages)];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *selectedImages = [NSMutableArray array];

    if (haveTitle) {
        [titles addObjectsFromArray:[self.delegate tabBarItemTitles]];
    }
    if (haveImage) {
        [images addObjectsFromArray:[self.delegate tabBarItemImages]];
    }
    if (haveSelectedImage) {
        [selectedImages addObjectsFromArray:[self.delegate tabBarItemSelectedImages]];
    }
    
    NSString *title = haveTitle ? titles[index] : nil;
    NSString *imagePath = haveImage ? images[index] : nil;
    NSString *selectedImagePath = haveSelectedImage ? selectedImages[index] : nil;
    
    UIImage *image = haveImage ? [UIImage imageNamed:imagePath] : nil;
    UIImage *selectedImage = haveSelectedImage ? [UIImage imageNamed:selectedImagePath] : nil;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    item.tag = index;
    return item;
}

- (void)hiddenTabBar:(BOOL)isHiddenTabBar
{
    _isHiddenTabBar = isHiddenTabBar;
    self.tabBarController.tabBar.hidden = _isHiddenTabBar;
}
@end
