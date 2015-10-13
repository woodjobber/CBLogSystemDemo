//
//  NSObject+CBReverseComparison.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//


#import "GNUMLogViewController.h"
#import "GNUMLogReviewViewController.h"
#import "GNUMLogSystem.h"


static NSString *UITableViewCellReuseIdentifier = @"UITableViewCell";

@interface GNUMLogViewController ()

@property (nonatomic, strong) NSMutableArray *logDatas;

@end

@implementation GNUMLogViewController

#pragma mark - Life

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = @"Show Log";
        
        self.logDatas = [NSMutableArray array];
        [self.logDatas addObjectsFromArray:[GNUMLogSystem availableLogs]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleCloseBarButtonitem)];
}

#pragma mark - Private

- (NSString *)logPathStringWithIndexPath:(NSIndexPath *)indexPath
{
    return [self.logDatas objectAtIndex:indexPath.row];
}

- (void)handleCloseBarButtonitem
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellReuseIdentifier];
    }
    NSString *logPath = [self logPathStringWithIndexPath:indexPath];
    cell.textLabel.text = [logPath lastPathComponent];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.logDatas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *logPathString = [self logPathStringWithIndexPath:indexPath];
    NSURL *logPathURL = [NSURL fileURLWithPath:logPathString];
    GNUMLogReviewViewController *logReviewViewController = [[GNUMLogReviewViewController alloc] initWithLogPathURL:logPathURL];
    [self.navigationController pushViewController:logReviewViewController animated:YES];
}

@end
