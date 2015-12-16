//
//  ViewController.h
//  Shopping With Miles
//
//  Created by James McKee on 7/5/15.
//  Copyright (c) 2015 James McKee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OfferViewController.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>

-(void)offerDismissed;

@end

