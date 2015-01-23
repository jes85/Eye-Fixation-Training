//
//  EFTViewController.h
//  Eye Fixation Training app2
//
//  Created by Jeremy on 9/12/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTViewController : UIViewController

-(IBAction)playAgain:(UIStoryboardSegue *)segue;

//I don't think I end up using the iPad ones, I just use the iPad scale factor from EFTConstants
//Also, if I choose I can probably get read of these and just use arrayOfCrossStartHeights, since all the sizes are square
+(NSArray *)crossStartSizesiPhone;
+(NSArray *)crossEndSizesiPhone;
+(NSArray *)crossStartSizesiPad;
+(NSArray *)crossEndSizesiPad;
@end
