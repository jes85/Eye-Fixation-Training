//
//  EFTUserSettingsTableViewController.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 12/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTUserSettingsTableViewController.h"
#import "EFTConstants.h"
#import "EFTSelectCrossSizeTableViewController.h"
#import "EFTNumberOfTapsTableViewCell.h"

@interface EFTUserSettingsTableViewController ()
@property (nonatomic) NSArray *reuseIdentifiers;
@end

@implementation EFTUserSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.reuseIdentifiers = @[kStartSizeCellReuseIdentifier, kEndSizeCellReuseIdentifier, kNumberOfTapsCellReuseIdentifier];
    
    
    //ask natalie what to put as footer
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

//Doing this to fix warning: "Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a tableview cell's content view. We're considering the collapse unintentional and using standard height instead."
- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifiers[indexPath.row] forIndexPath:indexPath];
    
    
    // Num Taps Cell
    
    if(indexPath.row ==2){
        EFTNumberOfTapsTableViewCell *customCell = (EFTNumberOfTapsTableViewCell *) cell;
        NSUInteger taps = [[[NSUserDefaults standardUserDefaults] valueForKey:kNumberOfTapsSetting] integerValue];
        customCell.numTapsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)taps];
        customCell.numberOfTapsUserSetting = taps;
        return customCell;
    }


    // Start/End Cross Size Cells
    
    else{
        NSUInteger VAIndex;
        if(indexPath.row == 0){
            VAIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:kStartSizeSetting] integerValue];
        }
        else if(indexPath.row == 1){
            VAIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:kEndSizeSetting] integerValue];
        }
        cell.detailTextLabel.text = [[EFTConstants arrayOfVisualAcuityStrings] objectAtIndex:VAIndex];
    
    }
    return cell;
}

-(IBAction)sizeChanged:(UIStoryboardSegue *) segue
{
    //determine which size changed
    [self.tableView reloadData];
    
}
-(IBAction)sizeChangeCancelled:(UIStoryboardSegue *) segue
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        if([nc.childViewControllers[0] isKindOfClass:[EFTSelectCrossSizeTableViewController class]]){
            EFTSelectCrossSizeTableViewController *vc = nc.childViewControllers[0];
            if([segue.identifier isEqualToString:kStartSizeCellSegue] ){
                vc.startOrEnd = 0;
                vc.navigationController.visibleViewController.title = kStartSizeTitle;
            }else{
                vc.startOrEnd = 1;
                vc.navigationController.visibleViewController.title = kEndSizeTitle;
            }
           
        }
    }
        
}


@end
