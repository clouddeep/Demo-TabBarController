//
//  SCTTabManager.h
//  TabBarView
//
//  Created by Shou Cheng Tuan on 2015/10/7.
//  Copyright (c) 2015年 Shou Cheng Tuan . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol SCTTabbedViewManagerDelegate <NSObject>

/*
 * It will automaticall add these view controllers as 
 * navigationController's root to the tab
 */
- (NSArray *)tabbedViewControllers;

@optional
/*
 * You should return one of titles and images, if you just return images, 
 * you should return selected images.
 */
- (NSArray *)tabBarItemTitles;
- (NSArray *)tabBarItemImages;
- (NSArray *)tabBarItemSelectedImages;

@end


@interface SCTTabManager : NSObject

@property (weak, nonatomic) id<SCTTabbedViewManagerDelegate> delegate;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, setter=hiddenTabBar:) BOOL isHiddenTabBar; // default is NO
- (id)initWithDelegate:(id<SCTTabbedViewManagerDelegate>)delegate withHiddenTabBar:(BOOL)hideTabBar;
- (void)selectTabViewIndex:(NSInteger)index;
@end
