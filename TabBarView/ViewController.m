//
//  ViewController.m
//  TabBarView
//
//  Created by Shou Cheng Tuan  on 2015/10/6.
//  Copyright (c) 2015年 Shou Cheng Tuan . All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *vcRed = [self createTabbedNavigationController:@"red" withTag:0];
    UIViewController *vcBlue = [self createTabbedNavigationController:@"blue" withTag:1];
    UIViewController *vcYellow = [self createTabbedNavigationController:@"yellow" withTag:2];
    tabBarController.viewControllers = @[vcRed, vcBlue, vcYellow];
    tabBarController.delegate = self;
    
    self.tabBarController = tabBarController;
    [self.view addSubview:tabBarController.view];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    CGSize screenSize = self.view.bounds.size;
    toolBar.frame = CGRectMake(0, screenSize.height - 50, screenSize.width, 50);
    UIBarButtonItem *itemRed = [self createPlainBarButton:@"red" withTag:0];
    UIBarButtonItem *itemBlue = [self createPlainBarButton:@"blue" withTag:1];
    UIBarButtonItem *itemYellow = [self createPlainBarButton:@"yellow" withTag:2];
    UIBarButtonItem *sizeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = @[itemRed, sizeItem, itemBlue, sizeItem, itemYellow];
    [self.view addSubview:toolBar];
}

- (UINavigationController *)createTabbedNavigationController:(NSString *)title withTag:(NSInteger)tag
{
    UIViewController *vc = [self createDummyViewController:title];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
    return [self createNavigationController:vc];
}

- (UINavigationController *)createNavigationController:(UIViewController *)viewController
{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    return nc;
}

- (UIViewController *)createDummyViewController:(NSString *)title
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = title;
    
    return vc;
}

- (UIBarButtonItem *)createPlainBarButton:(NSString *)title withTag:(NSInteger)tag
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(toggleContentView:)];
    item.tag = tag;

    return item;
}

- (void)toggleContentView:(id)sender
{
    UIBarButtonItem *item = sender;
    NSInteger tag = item.tag;
    self.tabBarController.selectedIndex = tag;
    
}

@end
