//
//  InAppMessagesViewController.m
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

#import "InAppMessagesViewController.h"
#import "PreviewViewController.h"

@interface InAppMessagesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* cells;
@property (strong, nonatomic) NSArray* sections;
@end

@implementation InAppMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Messages";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configure];
}

-(void)configure
{
    self.sections = @[@"Templates", @"Actions"];

    self.cells = [NSMutableArray new];

    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Alert",
                            @"method": @"alert_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Center Popup",
                            @"method": @"center_popup_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Confirm",
                            @"method": @"confirm_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Interstitial",
                            @"method": @"interstitial_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Push Pre-Permissions",
                            @"method": @"permission_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[0],
                            @"item" : @"Web Interstitial",
                            @"method": @"web_interstitial_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[1],
                            @"item" : @"Open URL",
                            @"method": @"open_url_example"
                            }];
    [self.cells addObject:@{
                            @"section" : self.sections[1],
                            @"item" : @"Register For Push",
                            @"method": @"register_example"
                            }];
}

-(NSArray *) rowsFor:(NSInteger) section
{
    return [self.cells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable object, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDictionary* data = object;
        return data[@"section"] == self.sections[section];
    }]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* data = [self rowsFor:indexPath.section][indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default_cell"];
    cell.textLabel.text = data[@"item"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self rowsFor:section].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary* data = [self rowsFor:indexPath.section][indexPath.row];
    PreviewViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"preview_view_controller"];
    
    if (viewController != nil) {
        viewController.data = data;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


@end
