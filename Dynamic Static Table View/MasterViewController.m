//
//  MasterViewController.m
//  Dynamic Static Table View
//
//  Created by Rob MacEachern on 2015-03-10.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//

#import "MasterViewController.h"
#import "BFTableViewCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView registerClass:[BFTableViewCell class] forCellReuseIdentifier:@"Dynamic Cell"];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[self indexOfCustomSectionForTableView:self.tableView]];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView] + 1; // Add a section to end of static table view
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        // Custom section is driven by an array in this case
        return self.objects.count;
    } else {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfCustomSectionForTableView:tableView]) {
        // Configure cell in dynamic section
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Dynamic Cell" forIndexPath:indexPath];
        NSObject *customObject = self.objects[indexPath.row];
        cell.textLabel.text = customObject.description;
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfCustomSectionForTableView:tableView]) {
        // Height of custom section cells
        return 44;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfCustomSectionForTableView:tableView]) {
        // Indentation level for custom section cells
        return 0;
    } else {
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return 22;
    } else {
        return [super tableView:tableView heightForHeaderInSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return 22;
    } else {
        return [super tableView:tableView heightForFooterInSection:section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return nil;
    } else {
        return [super tableView:tableView viewForFooterInSection:section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return nil;
    } else {
        return [super tableView:tableView viewForHeaderInSection:section];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return @"Dynamic Section (tap + to add)";
    } else {
        return [super tableView:tableView titleForHeaderInSection:section];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == [self indexOfCustomSectionForTableView:tableView]) {
        return nil;
    } else {
        return [super tableView:tableView titleForFooterInSection:section];
    }
}

#pragma mark Private Internal

- (NSInteger)indexOfCustomSectionForTableView:(UITableView *)tableView {
    return tableView.numberOfSections - 1;
}

@end
