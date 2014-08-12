//
//  ViewController.m
//  gettingStarted
//
//  Created by Jón Hilmar Gústafsson on 12/08/14.
//  Copyright (c) 2014 handpoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    HeftManager* manager = [HeftManager sharedManager];
    manager.delegate = self;
    [manager resetDevices]; // Clean out device list
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didConnect:(id<HeftClient>)client {
    NSLog(@"didConnect");
}

-(void)didFindAccessoryDevice:(HeftRemoteDevice *)newDevice{
    NSLog(@"didFindAccessoryDevice");
}
-(void)responseStatus:(id<ResponseInfo>)info{
    NSLog(@"responceStatus");
}

-(void)responseScannerEvent:(id<ScannerEventResponseInfo>)info{
    NSLog(@"responceScannerEvent");
}

-(void)responseEnableScanner:(id<EnableScannerResponseInfo>)info{
    NSLog(@"responceEnableScanner");
}

-(void)responseFinanceStatus:(id<FinanceResponseInfo>)info{
    NSLog(@"responcefinanceStatus");
}

@end
