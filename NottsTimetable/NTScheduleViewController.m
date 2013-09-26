//
//  NTScheduleViewController.m
//  NottsTimetable
//
//  Created by Tosin Afolabi on 20/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "UIColor+FlatUIColors.h"
#import "NTEmptyScheduleCell.h"
#import "NTFilledScheduleCell.h"
#import "NTScheduleViewController.h"

static NSString *EmptyCellIdentifier = @"EmptyScheduleCell";
static NSString *FilledCellIdentifier = @"FilledScheduleCell";

#define EMPTY_CELL_HEIGHT 44
#define FILLED_CELL_HEIGHT 70

@interface NTScheduleViewController ()

@property (nonatomic,copy) NSString *dayString;
@property (nonatomic,strong) NSMutableDictionary *classes;
@property (nonatomic,strong) NSMutableArray *classTimes;
@property (nonatomic,strong) NSMutableArray *filledCells;

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

        self.filledCells = [[NSMutableArray alloc] init];

        /* Set Up Test Data Source */

        self.classes = [[NSMutableDictionary alloc] init];

        [self.classes setObject:@{@"Class":@"G52APR", @"Lecturer":@"C. Higgins", @"Location":@"JC Exchange LT3", @"Type":@"Lecture", @"Time":@10, @"Duration":@1} forKey:@10];

        [self.classes setObject:@{@"Class":@"G52APR", @"Lecturer":@"C. Higgins", @"Location":@"JC CompSci A32", @"Type":@"Lab", @"Time":@11, @"Duration":@1} forKey:@11];

        [self.classes setObject:@{@"Class":@"G52IFR", @"Lecturer":@"C. Higgins", @"Location":@"JC Exchange LT3", @"Type":@"Lecture", @"Time":@13, @"Duration":@1} forKey:@13];

        [self.classes setObject:@{@"Class":@"G52ADS", @"Lecturer":@"C. Higgins", @"Location":@"JC Exchange LT3", @"Type":@"Lab", @"Time":@14, @"Duration":@1} forKey:@14];

        [self.classes setObject:@{@"Class":@"G52IIP", @"Lecturer":@"C. Higgins", @"Location":@"JC Dearing C42", @"Type":@"Lecture", @"Time":@15, @"Duration":@1} forKey:@15];

        [self.classes setObject:@{@"Class":@"G52SEM", @"Lecturer":@"C. Higgins", @"Location":@"JC BS South B52", @"Type":@"Lecture", @"Time":@17, @"Duration":@1} forKey:@17];

        self.classTimes = [[NSMutableArray alloc] init];
        for (NSDictionary *class in self.classes ) {
            [self.classTimes addObject:self.classes[class][@"Time"]];
        }
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor midnightBlueColor]];

    /* Register Class for Cell Reuse Identifier */
    
    [self.tableView registerClass:[NTEmptyScheduleCell class] forCellReuseIdentifier:EmptyCellIdentifier];
    [self.tableView registerClass:[NTFilledScheduleCell class] forCellReuseIdentifier:FilledCellIdentifier];

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

    /* Configure Table View */

    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.400 green:0.424 blue:0.471 alpha:1]];
    [self.tableView setContentInset:(UIEdgeInsetsMake(0, 0, -100, 0))];
    //[self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self showTableFooterView];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber *latestClassTime = [self.classTimes valueForKeyPath:@"@max.intValue"];
    NSDictionary *lastClass = [self.classes objectForKey:latestClassTime];
    int lastClassTime = [lastClass[@"Time"] integerValue];
    return lastClassTime + 1 - 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSNumber *indexPathRow = [NSNumber numberWithInt:[indexPath row]];
    for (NSNumber *filledCell in self.filledCells) {

        if ( [filledCell integerValue] == [indexPathRow integerValue]) {

            NSNumber *cellKey = [NSNumber numberWithInt:[indexPath row] + 9];
            NSDictionary *cellDetails = [self.classes objectForKey:cellKey];

            NTFilledScheduleCell *cell = (NTFilledScheduleCell *)[tableView dequeueReusableCellWithIdentifier:FilledCellIdentifier forIndexPath:indexPath];
            [cell setCellWithClass:cellDetails[@"Class"] ofType:cellDetails[@"Type"] atLocation:cellDetails[@"Location"] andTime:cellDetails[@"Time"] withLecturer:cellDetails[@"Lecturer"]];

            return cell;
        }
    }

    NTEmptyScheduleCell *cell = (NTEmptyScheduleCell *)[tableView dequeueReusableCellWithIdentifier:EmptyCellIdentifier forIndexPath:indexPath];
    [cell.timeLabel setText:[NSString stringWithFormat:@"%i:00", [indexPath row] + 9]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSNumber *currentClassTime = [NSNumber numberWithInt:[indexPath row] + 9];

    for (NSNumber *classTime in self.classTimes) {
        if ([classTime integerValue] == [currentClassTime integerValue]) {
            [self.filledCells addObject:[NSNumber numberWithInt:[indexPath row]]];
            return FILLED_CELL_HEIGHT;
        }
    }

    return EMPTY_CELL_HEIGHT;
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

- (void)showTableFooterView {

    UILabel* footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];

    NSDictionary *normalTextDict = @{NSFontAttributeName:[UIFont fontWithName:@"Signika-Regular" size:16], NSForegroundColorAttributeName:[UIColor cloudsColor]};
    NSMutableAttributedString *normalText = [[NSMutableAttributedString alloc] initWithString:@"No More Classes" attributes:normalTextDict];

    NSDictionary *emojiTextDict = @{NSFontAttributeName:[UIFont fontWithName:@"AppleColorEmoji" size:16]};
    NSAttributedString *emojiText = [[NSAttributedString alloc] initWithString:@"\ue409" attributes:emojiTextDict];

    [normalText appendAttributedString:emojiText];

    footerLabel.attributedText = normalText;
    [footerLabel setBackgroundColor:[UIColor clearColor]];
    [footerLabel setTextAlignment:NSTextAlignmentCenter];

    self.tableView.tableFooterView = footerLabel;
}

@end
