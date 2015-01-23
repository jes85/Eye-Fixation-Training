//
//  EFTiPadSelectCrossSizeTableViewController.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 9/27/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTiPadSelectCrossSizeTableViewController.h"
#import "EFTiPadSelectCrossSizeTableViewCell.h"
#import "EFTViewController.h"
#import "EFTConstants.h"


#define kHeaderHeight                           30

@interface EFTiPadSelectCrossSizeTableViewController ()


@end

@implementation EFTiPadSelectCrossSizeTableViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
       
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self crossSizeForiPadAtIndex:indexPath.row] + kiPadRowHeightExtraSpace;
}

-(CGFloat)crossSizeForiPadAtIndex: (NSUInteger)index
{
    if(self.startOrEnd == 0){
        return [[[EFTConstants arrayOfCrossStartHeights] objectAtIndex:index] floatValue] * kiPadSizeFactor;
    }
    else{
        return [[[EFTConstants arrayOfCrossStartHeights] objectAtIndex:index] floatValue] * kEndSizeFactor * kiPadSizeFactor;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFTiPadSelectCrossSizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVisualAcuityCellReuseIdentifier];
    
    // Set text
    NSString *visualAcuity =[EFTConstants arrayOfVisualAcuityStrings][indexPath.row];
    cell.titleTextLabel.text = visualAcuity;
    
   
   
    //Determine Cross Size (this didn't work, I ended up just chaning the row size and have contraints in storyboard for redcrossimageview to get bigger as row gets bigger
   /*
     NSLog(@"Cross height: %f Cross width %f", cell.redCrossImageView.frame.size.height, cell.redCrossImageView.frame.size.width);
    
    UIImageView *redCross = cell.redCrossImageView;
    CGSize size = [[[EFTViewController crossStartSizesiPad] objectAtIndex:indexPath.row] CGSizeValue];
    
    CGRect newframe = CGRectMake(redCross.frame.origin.x, redCross.frame.origin.y, size.height, size.width);
   redCross.frame = newframe;
     
    redCross.autoresizingMask = UIViewAutoresizingNone;
    redCross.contentMode = UIViewContentModeScaleToFill;
    NSLog(@"Cross height: %f Cross width %f", cell.redCrossImageView.frame.size.height, cell.redCrossImageView.frame.size.width);
    */
    
    
    // Display image
    [cell.contentView addSubview:cell.redCrossImageView];
    
    
    // Display checkmark for cell that was previously selected
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
    
   
    return cell;
}

                      


@end
