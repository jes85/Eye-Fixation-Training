//
//  EFTNumberOfTapsTableViewCell.h
//  Eye Fixation Training app2
//
//  Created by Jeremy on 12/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTNumberOfTapsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numTapsLabel;
@property (nonatomic) NSUInteger numberOfTapsUserSetting;
@end
