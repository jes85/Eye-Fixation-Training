//
//  EFTViewController.m
//  Eye Fixation Training app2
//
//  Created by Jeremy on 9/12/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "EFTViewController.h"
#import "EFTConstants.h"




@interface EFTViewController ()
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBar;
@property (nonatomic) CGRect visibleFrame;
@property (nonatomic) CGFloat directionsButtonYLocation;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel4;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;
@property (weak, nonatomic) IBOutlet UIButton *redCross;


@property (nonatomic) CGSize redCrossStartSize;
@property (nonatomic) CGSize redCrossEndSize;
@property (nonatomic) NSUInteger redCrossPressedCount;
@property (nonatomic) NSUInteger numberOfTapsUntilNextSize;


@property (weak, nonatomic) IBOutlet UIButton *fakeButton; //for congratulations segue


@end

@implementation EFTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.visibleFrame = [self getVisibleFrame];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self determineStartAndEndCrossSizes];
    [self determineNumTapsSetting];
    [self displayLabels];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self displayLabels];
}
-(void)determineStartAndEndCrossSizes
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults valueForKey:kStartSizeSetting]){
        [userDefaults setObject:[NSNumber numberWithInteger:0] forKey:kStartSizeSetting];
    }
    if(![userDefaults valueForKey:kEndSizeSetting]){
        [userDefaults setObject:[NSNumber numberWithInteger:0] forKey:kEndSizeSetting];
    }
    NSInteger startSizeSetting = [[userDefaults valueForKey:kStartSizeSetting] integerValue];
    NSInteger endSizeSetting = [[userDefaults valueForKey:kEndSizeSetting] integerValue];
    
    CGSize startSize = [[EFTViewController crossStartSizesiPhone][startSizeSetting] CGSizeValue];
    CGSize endSize = [[EFTViewController crossEndSizesiPhone][endSizeSetting]CGSizeValue];
    
    
    [self saveStartSize:startSize];
    [self saveEndSize:endSize];

}
-(void)determineNumTapsSetting
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults valueForKey:kNumberOfTapsSetting]){
        [userDefaults setObject:[NSNumber numberWithInteger:kNumberOfTapsDefault] forKey:kNumberOfTapsSetting];
    }
    NSUInteger taps = [[userDefaults objectForKey:kNumberOfTapsSetting] integerValue];
    self.numberOfTapsUntilNextSize = taps;
    
}

- (CGRect)getVisibleFrame {
   
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat directionsButtonBottomYCoord = self.directionsButton.frame.origin.y + self.directionsButton.frame.size.height;
    CGFloat tabBarTopYCoord = self.tabBarController.tabBar.frame.origin.y;
    CGFloat visibleHeight = tabBarTopYCoord - directionsButtonBottomYCoord;
    
    
    CGRect visibleFrame = CGRectMake([[UIScreen mainScreen] bounds].origin.x, directionsButtonBottomYCoord, screenSize.width, visibleHeight );
    
    
    return visibleFrame;
}


+(NSArray *)crossStartSizesiPhone
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempStartArray = [[NSMutableArray alloc] init];
        for(NSNumber *heightNumber in [EFTConstants arrayOfCrossStartHeights]){
            float height = [heightNumber floatValue];
            [tempStartArray addObject:[NSValue valueWithCGSize: CGSizeMake(height, height)]];
        }

        array = tempStartArray;
    });
    
    return array;
}

+(NSArray *)crossEndSizesiPhone
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempEndArray = [[NSMutableArray alloc] init];
        for(NSNumber *heightNumber in [EFTConstants arrayOfCrossStartHeights]){
            float height = [heightNumber floatValue]*kEndSizeFactor;
            [tempEndArray addObject:[NSValue valueWithCGSize: CGSizeMake(height, height)]];
        }
        
        array = tempEndArray;
    });
    
    return array;
}

+(NSArray *)crossStartSizesiPad
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempStartArray = [[NSMutableArray alloc] init];
        for(NSNumber *heightNumber in [EFTConstants arrayOfCrossStartHeights]){
            float height = [heightNumber floatValue]*kiPadSizeFactor;
            [tempStartArray addObject:[NSValue valueWithCGSize: CGSizeMake(height, height)]];
        }
        
        array = tempStartArray;
    });
    
    return array;
}

+(NSArray *)crossEndSizesiPad
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tempEndArray = [[NSMutableArray alloc] init];
        for(NSNumber *heightNumber in [EFTConstants arrayOfCrossStartHeights]){
            float height = [heightNumber floatValue]*kiPadSizeFactor*kEndSizeFactor;
            [tempEndArray addObject:[NSValue valueWithCGSize: CGSizeMake(height, height)]];
        }
        
        array = tempEndArray;
    });
    
    return array;
}

-(void)saveStartSize:(CGSize) size
{
    self.redCrossStartSize = size;
}
-(void)saveEndSize:(CGSize) size
{
    self.redCrossEndSize = size;
}
- (void)hideLabels
{
    //Hide
    self.titleLabel.hidden=YES;
    self.instructionLabel1.hidden=YES;
    self.instructionLabel2.hidden=YES;
    self.instructionLabel3.hidden=YES;
    self.instructionLabel4.hidden=YES;
    self.startButton.hidden=YES;
    
    //Show
    self.redCross.hidden=NO;
    self.directionsButton.hidden = NO;

}
-(void)displayLabels
{
    //Show
    self.titleLabel.hidden=NO;
    self.instructionLabel1.hidden=NO;
    self.instructionLabel2.hidden=NO;
    self.instructionLabel3.hidden=NO;
    self.instructionLabel4.hidden=NO;
    self.startButton.hidden=NO;
    
    //Hide
    self.directionsButton.hidden = YES;
    self.redCross.hidden=YES;
    
    //Reset
    self.redCrossPressedCount = 0;
    self.redCross.bounds = CGRectMake(0, 0, self.redCrossStartSize.width, self.redCrossStartSize.height);
    

}
-(void)switchRedCrossToRandomLocation
{
    
    // If possible, make sure next cross location does not overlap with previous
    // If that's impossible, move cross to farthest bound possible (unfortunately, this results in less random movement. Maybe change back to just just settling for any random location if overlap is unavoidable
    
    // Generate x-coord
    int xFirstRegionLeftBound = self.visibleFrame.origin.x;
    int xFirstRegionRightBound = self.redCross.frame.origin.x - self.redCross.frame.size.width;
    int xSecondRegionLeftBound = self.redCross.frame.origin.x + self.redCross.frame.size.width;
    int xSecondRegionRightBound = self.visibleFrame.origin.x + self.visibleFrame.size.width - self.redCross.frame.size.width;
    
    int xFirstRegionSize = xFirstRegionRightBound - xFirstRegionLeftBound;
    int xSecondRegionSize = xSecondRegionRightBound - xSecondRegionLeftBound;
    int xRegionSize = xSecondRegionRightBound - xFirstRegionLeftBound;
    
    
    // set coordinate to be negative if there's not enough space to have the origin at that x-coord without overlapping
    int xFirstRegionCoord = (xFirstRegionSize > 1) ? (arc4random() % xFirstRegionRightBound): -1;
    int xSecondRegionCoord = xSecondRegionSize > 1 ? ((arc4random() % xSecondRegionSize) + xSecondRegionLeftBound) : -1;
    
    
    int xcoordInAnyVisibleRegion = (arc4random() % xRegionSize) + xFirstRegionLeftBound;
    int xcoordInNonOverLappingRegion;
    BOOL xNonOverlapPossible = true;
    
    if (xFirstRegionCoord != -1 && xSecondRegionCoord !=-1) xcoordInNonOverLappingRegion =(arc4random() % 2 == 0) ? xFirstRegionCoord : xSecondRegionCoord;
    else if (xFirstRegionCoord != -1) xcoordInNonOverLappingRegion = xFirstRegionCoord;
    else if (xSecondRegionCoord != -1) xcoordInNonOverLappingRegion = xSecondRegionCoord;
    else{
        int leftBound = self.visibleFrame.origin.x;
        int rightBound = self.visibleFrame.origin.x + self.visibleFrame.size.width - self.redCross.frame.size.width;
        int leftBoundDifference = self.redCross.frame.origin.x - leftBound;
        int rightBoundDifference = rightBound - self.redCross.frame.origin.x;
        xcoordInNonOverLappingRegion = (leftBoundDifference > rightBoundDifference) ? leftBound : rightBound;
        xNonOverlapPossible = false;
    }// // set coordinate to be farthest possible if there's not enough space to have the origin at that x-coord without overlapping
    
    
   
    

    
    // Generate y-coord
    int yFirstRegionTopBound = self.visibleFrame.origin.y;
    int yFirstRegionBottomBound = self.redCross.frame.origin.y - self.redCross.frame.size.height;
    int ySecondRegionTopBound = self.redCross.frame.origin.y + self.redCross.frame.size.height;
    int ySecondRegionBottomBound = self.visibleFrame.origin.y + self.visibleFrame.size.height - self.redCross.frame.size.height;
    
    int yFirstRegionSize = yFirstRegionBottomBound - yFirstRegionTopBound;
    int ySecondRegionSize = ySecondRegionBottomBound - ySecondRegionTopBound;
    int yRegionSize = ySecondRegionBottomBound - yFirstRegionTopBound;
    
    
    int yFirstRegionCoord = (yFirstRegionSize > 1) ? (arc4random() % yFirstRegionSize) + yFirstRegionTopBound : -1;
    int ySecondRegionCoord = (ySecondRegionSize > 1) ? ((arc4random() % ySecondRegionSize) + ySecondRegionTopBound) : -1;
    
   
    int ycoordInNonOverlappingRegion = -1;
    BOOL yNonOverlapPossible = true;
    if (yFirstRegionCoord != -1 && ySecondRegionCoord !=-1) ycoordInNonOverlappingRegion =(arc4random() % 2 == 0) ? yFirstRegionCoord : ySecondRegionCoord;
    else if (yFirstRegionCoord != -1) ycoordInNonOverlappingRegion = yFirstRegionCoord;
    else if (ySecondRegionCoord != -1) ycoordInNonOverlappingRegion = ySecondRegionCoord;
    else{
        int topBound = self.visibleFrame.origin.y;
        int bottomBound = self.visibleFrame.origin.y + self.visibleFrame.size.height - self.redCross.frame.size.height;
        int topBoundDifference = self.redCross.frame.origin.y - topBound;
        int bottomBoundDifference = bottomBound - self.redCross.frame.origin.y;
        ycoordInNonOverlappingRegion = (topBoundDifference > bottomBoundDifference) ? topBound : bottomBound;
        yNonOverlapPossible = false;
    }// set coordinate to be farthest possible if there's not enough space to have the origin at that y-coord without overlapping
    
    
    int ycoordInAnyVisibleRegion = (arc4random() % yRegionSize) + yFirstRegionTopBound;
    
    //Pick between xNonOverLap + yAny, xAny + yNonOverlap, or farthest possible if overlapping is unavoidable
   
    NSMutableArray *arrayOfPossibleCGPoints = [[NSMutableArray alloc]init];
    
    //xNonOverLap + yAny
    if(xNonOverlapPossible == true){
        CGPoint point = CGPointMake(xcoordInNonOverLappingRegion, ycoordInAnyVisibleRegion);
        [arrayOfPossibleCGPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    //xAny + yNonOverlap
    if(yNonOverlapPossible == true){
        CGPoint point = CGPointMake(xcoordInAnyVisibleRegion, ycoordInNonOverlappingRegion);
        [arrayOfPossibleCGPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    
    
    CGPoint redCrossOrigin;
    NSUInteger count = arrayOfPossibleCGPoints.count;
    if(count == 0){ //overlapping is unavoidable
        //Pick farthest possible
       // redCrossOrigin = CGPointMake(xcoordInNonOverLappingRegion, ycoordInNonOverlappingRegion);
        //or Pick random
        redCrossOrigin = CGPointMake(xcoordInAnyVisibleRegion, ycoordInAnyVisibleRegion);
        //other option: just include "nonOverlap" unavoidable in array
    }else if (count == 1){
        redCrossOrigin = [arrayOfPossibleCGPoints[0] CGPointValue];
    }else{
        int randomIndex = arc4random() % 2;
        redCrossOrigin = [arrayOfPossibleCGPoints[randomIndex] CGPointValue];
        
    }
    
    
    
    
    
    //frame: coordinates with respect to superview
    //bounds: coordinates in own reference frame
    //frame.size = bounds.size
    //frame.origin != bounds.origin
    
    //change frame coordinates to new origin (x, y)
   
    CGRect newFrame = self.redCross.frame;
    newFrame.origin = redCrossOrigin;
    self.redCross.frame = newFrame;
    
}
-(void)shrinkRedCross
{
    
    self.redCross.bounds = CGRectMake(0,0,self.redCross.bounds.size.width*kShrinkFactor, self.redCross.bounds.size.height*kShrinkFactor);
    
}

- (IBAction)redCrossTouched:(id)sender {
    self.redCrossPressedCount++;
    //shrink red cross every x # of presses, where x is chosen by user settings (default = 3)
    if(self.redCrossPressedCount % self.numberOfTapsUntilNextSize ==0){
        [self shrinkRedCross];
    }
    
    //check to see if they won
    if(self.redCross.bounds.size.height < self.redCrossEndSize.height && self.redCross.bounds.size.width < self.redCrossEndSize.width){
        [self displayCongratulations];
        return;
    }
    
    
    //if not, keep playing
    [self switchRedCrossToRandomLocation];
}
- (IBAction)startButtonPressed:(id)sender {
    [self hideLabels];
    [self switchRedCrossToRandomLocation];
    
}
- (IBAction)directionsButtonTouched:(id)sender {
    [self displayLabels];
   
}

-(IBAction)playAgain:(UIStoryboardSegue *)segue
{
    
}

-(void)displayCongratulations
{
   
    [self performSegueWithIdentifier:@"Congratulations" sender:self.fakeButton];
    
}



@end
