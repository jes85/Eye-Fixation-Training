//
//  EFTNumberOfTapsTableViewCell.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 12/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTNumberOfTapsTableViewCell.h"
#import "EFTConstants.h"



@interface EFTNumberOfTapsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIStepper *numTapsStepper;
@property (weak, nonatomic) IBOutlet UILabel *numTapsTitle;


@end

@implementation EFTNumberOfTapsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.numTapsStepper.value = [[[NSUserDefaults standardUserDefaults] objectForKey:kNumberOfTapsSetting] doubleValue];
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)userTappedStepper:(id)sender {
    
    
    self.numberOfTapsUserSetting = self.numTapsStepper.value;
    self.numTapsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.numTapsStepper.value];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithInteger:self.numberOfTapsUserSetting] forKey:kNumberOfTapsSetting];
}

@end
