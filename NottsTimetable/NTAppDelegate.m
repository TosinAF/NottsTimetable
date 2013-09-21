//
//  NTAppDelegate.m
//  NottsTimetable
//
//  Created by Tosin Afolabi on 20/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "NTAppDelegate.h"
#import "NTScheduleViewController.h"
#import "UIColor+FlatUIColors.h"

@interface NTAppDelegate ()

@property (nonatomic,strong) UITabBarController *tabBarController;

@end

@implementation NTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.tabBarController = [[UITabBarController alloc] init];

    int i = 0;
    NSArray *titleString = [[NSArray alloc] initWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", nil];
    NSArray *imageString = [[NSArray alloc] initWithObjects:@"Monday.png", @"Tuesday.png", @"Wednesday.png", @"Thursday.png", @"Friday.png", nil];

    NSMutableArray *scheduleControllers = [[NSMutableArray alloc] init];

    /* Setting up The View Controllers For Each Tab */

    for (i = 0; i <= 4 ; i++) {

        // Uses the NS_ENUM NTScheduleViewDay to initialize the class for the specific day
        NTScheduleViewController *specificDaySchedule = [[NTScheduleViewController alloc] initWithStyle:UITableViewStylePlain forDay:i];

        specificDaySchedule.tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleString objectAtIndex:i] image:[UIImage imageNamed:[imageString objectAtIndex:i]] tag:i];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:specificDaySchedule];
        [scheduleControllers addObject:navController];
    }

    self.tabBarController.viewControllers = scheduleControllers;

    [self setSelectedTabBarItem];

    /* Customize tabBar */

    //[[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.427 green:0.678 blue:0.859 alpha:1]];

    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName:[UIColor cloudsColor],
                                                        NSFontAttributeName:[UIFont fontWithName:@"Signika-Light" size:0.0]}
                                                        forState:UIControlStateNormal];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cloudsColor]} forState:UIControlStateHighlighted];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self setSelectedTabBarItem];
}

#pragma mark - Private Methods

- (void)setSelectedTabBarItem
{
    /*
     * Get the Current Weekday & Set The Selected Tab Bar to that day
     */

    CFAbsoluteTime at = CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef tz = CFTimeZoneCopySystem();
    SInt32 weekdayNum = CFAbsoluteTimeGetDayOfWeek(at, tz);

    if (weekdayNum != 0 || weekdayNum != 6) {
        [self.tabBarController setSelectedIndex:weekdayNum - 1];
    }
}

@end
