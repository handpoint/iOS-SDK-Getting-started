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
@synthesize heftClient;

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
    heftClient = client;
    
    // Do one sale
    [heftClient saleWithAmount:100 currency:@"GBP" cardholder:YES];
}

-(void)didFindAccessoryDevice:(HeftRemoteDevice *)newDevice{
    NSLog(@"didFindAccessoryDevice");
    
    // Declare the shared secret in hex numbers.
    uint8_t ss[32] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x30, 0x31, 0x32};
    
    heftClient = nil;
    [[HeftManager sharedManager] clientForDevice:newDevice sharedSecret:[[NSData alloc] initWithBytes:ss length:sizeof(ss)] delegate:self];
}
-(void)responseStatus:(id<ResponseInfo>)info{
    NSLog(@"responseStatus:");
    NSLog(@"%@",info.status);
    NSLog(@"%@",info.xml.description);
}

-(void)responseScannerEvent:(id<ScannerEventResponseInfo>)info{
    NSLog(@"responceScannerEvent");
}

-(void)responseEnableScanner:(id<EnableScannerResponseInfo>)info{
    NSLog(@"responceEnableScanner");
}

-(void)responseFinanceStatus:(id<FinanceResponseInfo>)info{
    NSLog(@"responseFinanceStatus:");
    NSLog(@"%@",info.status);
    NSLog(@"%@",info.customerReceipt);
    NSLog(@"%@",info.xml.description);
}

-(void)responseError:(id<ResponseInfo>)info{
    NSLog(@"responceError");
}

-(void)cancelSignature{
    NSLog(@"cancelSignature");
}

-(void)requestSignature:(NSString *)receipt{
    NSLog(@"requestSignature");
}

-(void)didDiscoverFinished{
    NSLog(@"didDiscoverFinished");
}

-(void)didDiscoverDevice:(HeftRemoteDevice *)newDevice{
    NSLog(@"didDiscoverDevice");
}

-(void)didLostAccessoryDevice:(HeftRemoteDevice *)oldDevice{
    NSLog(@"didLostAccessoryDevice");
}

-(void)hasSources{
    NSLog(@"hasSources");
}

-(void)noSources{
    NSLog(@"noSources");
}

-(void)responseLogInfo:(id<LogInfo>)info{
    NSLog(@"responceLogInfo");
}


@end
