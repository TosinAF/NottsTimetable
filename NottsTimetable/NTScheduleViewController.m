//
//  NTScheduleViewController.m
//  NottsTimetable
//
//  Created by Tosin Afolabi on 20/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "UIColor+FlatUIColors.h"
#import "NTScheduleViewController.h"

@interface NTScheduleViewController ()

@property (nonatomic,copy) NSString *dayString;

@end

@implementation NTScheduleViewController

- (id)initWithStyle:(UITableViewStyle)style forDay:(NTScheduleViewDay)day {
    self = [super initWithStyle:style];
    if (self) {

        switch (day) {

            case NTScheduleViewDayMonday:
                self.dayString = @"Monday";
                break;

            case NTScheduleViewDayTuesday:
                self.dayString = @"Tuesday";
                break;

            case NTScheduleViewDayWednesday:
                self.dayString = @"Wednesday";
                break;

            case NTScheduleViewDayThursday:
                self.dayString = @"Thursday";
                break;

            case NTScheduleViewDayFriday:
                self.dayString = @"Friday";
                break;
        }
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* Set Up Navigation Bar */

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.047 green:0.467 blue:0.765 alpha:1]];

    UIButton *configureScheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [configureScheduleButton setFrame:CGRectMake(0, 0, 30, 30)];
    [configureScheduleButton setTitle:@"\uE727" forState:UIControlStateNormal];
    [configureScheduleButton.titleLabel setFont:[UIFont fontWithName:@"Entypo" size:40]];
    [configureScheduleButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];

    UIButton *addClassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addClassButton setFrame:CGRectMake(0, 0, 30, 30)];
    [addClassButton setTitle:@"\u2295" forState:UIControlStateNormal];
    [addClassButton.titleLabel setFont:[UIFont fontWithName:@"Entypo" size:40]];
    [addClassButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];

    [self setNavBarTitle];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:configureScheduleButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addClassButton];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    cell.textLabel.text = @"test";
    
    return cell;
}

#pragma mark - Private Methods

- (void)setNavBarTitle {

    /*
     * Splits the Original Title View into a Title & Subtitle View
     */

    UIView *viewContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [viewContainer setBackgroundColor:[UIColor clearColor]];

    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 200, 24)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Signika-Light" size:20];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    titleView.text = self.dayString;
    titleView.adjustsFontSizeToFitWidth = YES;

    UILabel *subtitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 200, 44-28)];
    subtitleView.backgroundColor = [UIColor clearColor];
    subtitleView.font = [UIFont fontWithName:@"Signika-Regular" size:10];
    subtitleView.textAlignment = NSTextAlignmentCenter;
    subtitleView.textColor = [UIColor cloudsColor];
    subtitleView.text = @"Week 2";
    subtitleView.adjustsFontSizeToFitWidth = YES;

    [viewContainer addSubview:titleView];
    [viewContainer addSubview:subtitleView];
    self.navigationItem.titleView = viewContainer;
}

@end
