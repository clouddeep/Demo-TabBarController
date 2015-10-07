//
//  ViewController.m
//  TabBarView
//
//  Created by Shou Cheng Tuan  on 2015/10/6.
//  Copyright (c) 2015年 Shou Cheng Tuan . All rights reserved.
//

#import "ViewController.h"
#import "SCTTabManager.h"

@interface ViewController () <UITabBarControllerDelegate, SCTTabbedViewManagerDelegate>

@property (strong, nonatomic) SCTTabManager *tabManager;
@end

@implementation ViewController

#define USE_TAB_MANAGER 1
#define USE_TOOL_BAR 1

#if !USE_TAB_MANAGER

- (void)loadView
{
    [super loadView];
    
    // Tab Bar Controller
    self.tabBarController = [[UITabBarController alloc] init];
    _tabBarController.delegate = self;
    _tabBarController.tabBar.hidden = YES;
    
    UIViewController *vcRed = [self createTabbedNavigationController:@"red" withTag:0];
    UIViewController *vcBlue = [self createTabbedNavigationController:@"blue" withTag:1];
    UIViewController *vcYellow = [self createTabbedNavigationController:@"yellow" withTag:2];
    
    RedTableView *tableView = [[RedTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [vcRed.view addSubview:tableView];
    
    _tabBarController.viewControllers = @[vcRed, vcBlue, vcYellow];
    
    // Tool Bar
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    CGSize screenSize = self.view.bounds.size;
    toolBar.frame = CGRectMake(0, screenSize.height - 50, screenSize.width, 50);
    UIBarButtonItem *itemRed = [self createPlainBarButton:@"red" withTag:0];
    UIBarButtonItem *itemBlue = [self createPlainBarButton:@"blue" withTag:1];
    UIBarButtonItem *itemYellow = [self createPlainBarButton:@"yellow" withTag:2];
    UIBarButtonItem *sizeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = @[itemRed, sizeItem, itemBlue, sizeItem, itemYellow];
    
    [self.view addSubview:toolBar];
    [self.view addSubview:_tabBarController.view];
}

- (UINavigationController *)createTabbedNavigationController:(NSString *)title withTag:(NSInteger)tag
{
    UIViewController *vc = [self createDummyViewController:title];
    
    if (!self.tabBarController.tabBar.hidden) {
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
    }
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

#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
#if USE_TAB_MANAGER
    self.tabManager = [[SCTTabManager alloc] initWithDelegate:self withHiddenTabBar:YES];
#endif
    
#if USE_TOOL_BAR
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    CGSize screenSize = self.view.bounds.size;
    toolBar.frame = CGRectMake(0, screenSize.height - 50, screenSize.width, 50);
    UIBarButtonItem *itemRed = [self createPlainBarButton:@"red" withTag:0];
    UIBarButtonItem *itemBlue = [self createPlainBarButton:@"blue" withTag:1];
    UIBarButtonItem *itemYellow = [self createPlainBarButton:@"yellow" withTag:2];
    UIBarButtonItem *sizeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = @[itemRed, sizeItem, itemBlue, sizeItem, itemYellow];
    
    [self.view addSubview:toolBar];

#endif

}

#if USE_TAB_MANAGER
- (NSArray *)tabbedViewControllers
{
    UIViewController *vcRed = [UIViewController new];
    vcRed.title = @"Red";
    vcRed.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vcBlue = [UIViewController new];
    vcBlue.title = @"Blue";
    vcBlue.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vcYellow = [UIViewController new];
    vcYellow.title = @"Yellow";
    vcYellow.view.backgroundColor = [UIColor yellowColor];

    return @[vcRed, vcBlue, vcYellow];
}

- (NSArray *)tabBarItemTitles
{
    return @[@"red", @"blue", @"yellow"];
}

#endif

#if USE_TOOL_BAR
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

    [self.tabManager selectTabViewIndex:tag];
    
}
#endif
@end
