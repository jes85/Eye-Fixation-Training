//
//  EFTSelectCrossSizeTableViewController.h
//  Eye Fixation Training app2
//
//  Created by Jeremy on 9/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTSelectCrossSizeTableViewController : UITableViewController
@property (nonatomic) NSArray *visualAcuityList;
@property (nonatomic) NSUInteger startOrEnd; //0 is start cell, 1 is end cell

@end
