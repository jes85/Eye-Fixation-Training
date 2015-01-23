//
//  EFTConstants.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 10/14/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTConstants.h"

@implementation EFTConstants
+(NSArray *)arrayOfVisualAcuityStrings
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[kVisualAcuity0, kVisualAcuity1, kVisualAcuity2, kVisualAcuity3, kVisualAcuity4, kVisualAcuity5, kVisualAcuity6, kVisualAcuity7, kVisualAcuity8];
    });
  
    return array;
}
+(NSArray *)arrayOfCrossStartHeights
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[[NSNumber numberWithFloat:kStartHeight0], [NSNumber numberWithFloat:kStartHeight1], [NSNumber numberWithFloat:kStartHeight2], [NSNumber numberWithFloat:kStartHeight3], [NSNumber numberWithFloat:kStartHeight4], [NSNumber numberWithFloat:kStartHeight5], [NSNumber numberWithFloat:kStartHeight6], [NSNumber numberWithFloat:kStartHeight7], [NSNumber numberWithFloat:kStartHeight8]];
    });
    
    return array;
}
@end
