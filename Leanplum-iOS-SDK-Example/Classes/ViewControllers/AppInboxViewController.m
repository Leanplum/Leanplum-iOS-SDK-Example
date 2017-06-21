//
//  AppInboxViewController.m
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

#import "AppInboxViewController.h"
#import <Leanplum/Leanplum.h>

@interface AppInboxViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* cells;

@end

@implementation AppInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"App Inbox";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configure];
}

- (void)configure
{
    self.cells = [NSMutableArray new];
    
    [[Leanplum newsfeed] onChanged:^{
        [self prepareMessages];
    }];
    [self prepareMessages];
}

- (void)prepareMessages
{
    NSArray* messages = [[Leanplum newsfeed] allMessages];
    if (messages != nil) {
        self.cells = messages;
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPNewsfeedMessage* message = [self.cells objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default_cell"];
    cell.textLabel.text = [message title];
    cell.detailTextLabel.text = [message subtitle];
    [cell.imageView setHidden:[message isRead]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cells.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LPNewsfeedMessage* message = [self.cells objectAtIndex:indexPath.row];
    [self showMessage:message];
}

-(void)showMessage:(LPNewsfeedMessage *)message
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:message.title
                                message:message.subtitle
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* readAction = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleCancel
                                 handler:^(UIAlertAction * _Nonnull action) {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     [message read];
                                 }];
    [alert addAction:readAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
