//
//  ViewController.m
//  Shopping With Miles
//
//  Created by James McKee on 7/5/15.
//  Copyright (c) 2015 James McKee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) NSMutableDictionary * offersSeen;
@property (nonatomic, strong) OfferViewController * currentOffer;
@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self resetBeacons];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self resetBeacons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetBeacons {
    // Initialize the location manager.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Request permission.
    [self.locationManager requestAlwaysAuthorization];
    
    // Clear the offers seen.
    self.offersSeen = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    // Create a region.
    NSUUID * regionId = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-0002-D0F5A71096E0"];
    
    CLBeaconRegion * beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:regionId identifier:@"MikeyShopping"];
    
    // Start monitoring and ranging beacons.
    [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
   }

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
}
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    for (CLBeacon * beacon in beacons) {
        if (self.currentOffer) return;
        
        NSString * majorMinorValue = [NSString stringWithFormat:@"%@|%@", beacon.major, beacon.minor];
    
        // Stop presenting offer if seen previously in session. Comment out if you want to repeat offers all the time
        if ([self.offersSeen objectForKey:majorMinorValue]) continue;
        
        [self.offersSeen setObject:[NSNumber numberWithBool:YES] forKey:majorMinorValue];
        OfferViewController * offerVc = [[OfferViewController alloc] init];
        offerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UIColor * backgroundColor;
        NSString * labelValue;
        UIImage * productImage;
        UIImage * logoImage;
        
        // Set Major Beacon Value
        if (([beacon.major intValue] == 0)) {
            
            // Set background colour to white.
            backgroundColor = [UIColor colorWithRed:255.0/255.0
                                              green:255.0/255.0
                                               blue:255.0/255.0
                                              alpha:1.0];
            
            // Set Minor Beacon Value per Offer
            if ([beacon.minor intValue] == 1) {
                labelValue = @"25% off Meraki MR Access Points.";
                productImage = [UIImage imageNamed:@"mr-hangout.png"];
                logoImage = [UIImage imageNamed:@"cisco-meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;

            
            } else if ([beacon.minor intValue] == 3)  {
                labelValue = @"Buy one Meraki MS Switch, get one free.";
                productImage = [UIImage imageNamed:@"ms-hangout.png"];
                logoImage = [UIImage imageNamed:@"cisco-meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;

                
            } else if ([beacon.minor intValue] == 2)  {
                labelValue = @"50% off all Meraki MX Security Appliances.";
                productImage = [UIImage imageNamed:@"mx-hangout.png"];
                logoImage = [UIImage imageNamed:@"cisco-meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;

                
            } else if ([beacon.minor intValue] == 4)  {
                labelValue = @"100 SME Users Free!";
                productImage = [UIImage imageNamed:@"sm-hangout.png"];
                logoImage = [UIImage imageNamed:@"cisco-meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;

            }
        }
        
    }
    
    
    
}

-(void)offerDismissed {
    self.currentOffer = nil;
}



@end
