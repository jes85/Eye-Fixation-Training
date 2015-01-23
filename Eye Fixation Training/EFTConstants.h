//
//  EFTConstants.h
//  Eye Fixation Training app2
//
//  Created by Jeremy on 10/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kVisualAcuity0          @"20/40"
#define kVisualAcuity1          @"20/60"
#define kVisualAcuity2          @"20/80"
#define kVisualAcuity3          @"20/100"
#define kVisualAcuity4          @"20/200"
#define kVisualAcuity5          @"2'/200"
#define kVisualAcuity6          @"4'/200"
#define kVisualAcuity7          @"6'/200"
#define kVisualAcuity8          @"8'/200"

#define kStartHeight0             100.0
#define kStartHeight1             125.0
#define kStartHeight2             150.0
#define kStartHeight3             175.0
#define kStartHeight4             200.0
#define kStartHeight5             225.0
#define kStartHeight6             250.0
#define kStartHeight7             275.0
#define kStartHeight8             300.0

#define kEndSizeFactor              1/3
#define kShrinkFactor               0.8 // maybe change this to be user setting
#define kiPadSizeFactor               2
#define kiPadRowHeightExtraSpace     10

#define kStartSizeSetting                   @"Start Size Setting"
#define kStartSizeTitle                     @"Select Start Size"
#define kStartSizeCellReuseIdentifier       @"Start Size Cell"
#define kStartSizeCellSegue                 @"Start Size Cell Segue"

#define kEndSizeSetting                     @"End Size Setting"
#define kEndSizeTitle                       @"Select End Size"
#define kEndSizeCellReuseIdentifier         @"End Size Cell"
#define kEndSizeCellSegue                   @"End Size Cell Segue"


#define kNumberOfTapsCellReuseIdentifier    @"Number of Taps Cell"
#define kNumberOfTapsSetting                @"Number of Taps Setting"
#define kNumberOfTapsDefault                3

//TODO: change these
#define kVisualAcuitySetting                @"Visual Acuity Setting"
#define kVisualAcuityCellReuseIdentifier    @"Visual Acuity Cell"
#define kSettingsTitle                      @"Cross Sizes Based on Visual Acuity"


@interface EFTConstants : NSObject


+(NSArray *)arrayOfVisualAcuityStrings;
+(NSArray *)arrayOfCrossStartHeights;
@end
