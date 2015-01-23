//
//  EFTSelectCrossSizeTableViewController.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 9/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTSelectCrossSizeTableViewController.h"
#import "EFTConstants.h"


#define kSmallestCrossSizeLabel             @"  (Smallest)"
#define kLargestCrossSizeLabel              @"  (Largest)"

@interface EFTSelectCrossSizeTableViewController ()
@property (nonatomic) NSArray *startOrEndSettingsList;
@end

@implementation EFTSelectCrossSizeTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.startOrEndSettingsList = @[kStartSizeSetting, kEndSizeSetting];
    
    
    //ask natalie what to put as footer
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return kSettingsTitle;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[EFTConstants arrayOfVisualAcuityStrings] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVisualAcuityCellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *visualAcuity = [EFTConstants arrayOfVisualAcuityStrings][indexPath.row];
    
    
    // Display Checkmark on appropriate cell
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if(self.startOrEnd == 0){
        if(indexPath.row == [[userDefaults objectForKey:kStartSizeSetting] integerValue]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if (self.startOrEnd == 1){
        if(indexPath.row == [[userDefaults objectForKey:kEndSizeSetting] integerValue]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }

    // Concatenate (Smallest) and (Largest) on first and last cell labels
    
    if(indexPath.row == 0){
        visualAcuity = [visualAcuity stringByAppendingString:kSmallestCrossSizeLabel];
    }else if (indexPath.row == [[EFTConstants arrayOfVisualAcuityStrings] count] - 1){
        visualAcuity = [visualAcuity stringByAppendingString:kLargestCrossSizeLabel];
    }
    cell.textLabel.text = visualAcuity;
    
    
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
		
        // if the cell was already selected, return (there's no need to do anything)
		UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
		if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
			return;
		}
        
		// otherwise, uncheck all visible cells.
		for (UITableViewCell *cell in [tableView visibleCells]) {
			if (cell.accessoryType != UITableViewCellAccessoryNone) {
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
		}
		selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
        // update UserDefaults for which visual acuity is selected
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSNumber numberWithInteger:indexPath.row] forKey:self.startOrEndSettingsList[self.startOrEnd]];
       	
}


@end
