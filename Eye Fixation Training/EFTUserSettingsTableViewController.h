//
//  EFTUserSettingsTableViewController.h
//  Eye Fixation Training app2
//
//  Created by Jeremy on 12/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTUserSettingsTableViewController : UITableViewController

-(IBAction)sizeChanged:(UIStoryboardSegue *) segue;
-(IBAction)sizeChangeCancelled:(UIStoryboardSegue *) segue;

@end
