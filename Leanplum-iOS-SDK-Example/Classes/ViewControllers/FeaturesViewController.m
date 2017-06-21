//
//  FeaturesViewController.m
//  Leanplum-iOS-SDK-Example
//  Copyright © 2017 Leanplum.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//      http://www.apache.org/licenses/LICENSE-2.0
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "FeaturesViewController.h"

@interface FeaturesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* cells;

@end

@implementation FeaturesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Features";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configure];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)configure {
    self.cells = [NSMutableArray new];
    
    [self.cells addObject:@{
                            @"item" : @"Push Notifications",
                            @"count": @0
                            }];
    [self.cells addObject:@{
                            @"item" : @"In-app Messages",
                            @"count": @0
                            }];
    [self.cells addObject:@{
                            @"item" : @"App Inbox",
                            @"count": @0
                            }];
    [self.cells addObject:@{
                            @"item" : @"A/B Test",
                            @"count": @0
                            }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* data = [self.cells objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default_cell"];
    cell.textLabel.text = data[@"item"];
    cell.detailTextLabel.text = @"";
    
    if ([data[@"item"] isEqualToString:@"App Inbox"]) {
        cell.detailTextLabel.text = [data[@"count"] stringValue];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cells count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* viewController = nil;
    
    switch (indexPath.row) {
        case 0:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:
                              @"push_notification_view_controller"];
            break;
        case 1:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:
                              @"in_app_messages_view_controller"];
            break;
        case 2:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:
                              @"app_inbox_view_controller"];
            break;
        default:
            break;
    }
    if (viewController != nil) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end

