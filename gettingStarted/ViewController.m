//
//  ViewController.m
//  gettingStarted
//
//  Created by Handpoint on 12/08/14.
//  Copyright (c) 2014 Handpoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize heftClient, manager;
//Set your unique shared secret here, provided by Handpoint with the dev kit 
NSString* sharedSecret = @"0102030405060708091011121314151617181920212223242526272829303132";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //getting the heftmanager
    manager = [HeftManager sharedManager];
    manager.delegate = self;
    [manager resetDevices]; // Clean out device list
    
    //Check if a device is conncected
    if (heftClient == nil) {
        [cardReaderSerial setText:@"None"];
    }
    else {
        [cardReaderSerial setText:[[heftClient mpedInfo] objectForKey:kSerialNumberInfoKey]];
    }
    [transactionStatus setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Additional functions



- (IBAction)startSale {
    // Do one sale
    [heftClient saleWithAmount:100 currency:@"GBP" cardholder:YES];
}

- (IBAction)startDiscovery {
    //Manually start discovery - iOS native BT discovery
    [manager resetDevices];
    [manager startDiscovery:NO];
}

//Creating a heftclient
-(void)createClient:(HeftRemoteDevice *)newDevice{
    
    heftClient = nil;
    [manager clientForDevice:newDevice sharedSecret:[self SharedSecretDataFromString:sharedSecret] delegate:self];
    
}

//Converts a shared secret string to NSDATA which is used by the SDK(Will be implemented in the SDK in the future)
-(NSData*)SharedSecretDataFromString:(NSString*)sharedSecretString;
{
    NSMutableData* data = [NSMutableData data];
    for (int i = 0 ; i < 32; i++) { NSRange range = NSMakeRange (i*2, 2); NSString *bytes = [sharedSecretString substringWithRange:range]; NSScanner* scanner = [NSScanner scannerWithString:bytes]; unsigned int intValue; [scanner scanHexInt:&intValue]; [data appendBytes:&intValue length:1]; }
    return data;
}

#pragma mark HeftLibrary implementation

-(void)didConnect:(id<HeftClient>)client {
    NSLog(@"didConnect");
    heftClient = client;
    NSLog(@"Connected to %@", [[heftClient mpedInfo] objectForKey:kSerialNumberInfoKey]);
    [cardReaderSerial setText:[[heftClient mpedInfo] objectForKey:kSerialNumberInfoKey]];
    
    //clear status message
    [transactionStatus setText:@""];

}

-(void)didFindAccessoryDevice:(HeftRemoteDevice *)newDevice{
    NSLog(@"didFindAccessoryDevice");
    [self createClient:newDevice];
}

-(void)responseStatus:(id<ResponseInfo>)info{
    NSLog(@"responseStatus:");
    NSLog(@"%@",info.status);
    NSLog(@"%@",info.xml.description);
    [transactionStatus setText:[info status]];
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
    
    [transactionStatus setText:[info status]];
}

-(void)responseError:(id<ResponseInfo>)info{
    NSLog(@"responceError");
    [transactionStatus setText:[info status]];
}

-(void)requestSignature:(NSString *)receipt{
    NSLog(@"requestSignature");
}

-(void)cancelSignature{
    NSLog(@"cancelSignature");
}

-(void)didDiscoverFinished{
    NSLog(@"didDiscoverFinished");
    if ([[manager devicesCopy] count] > 0 ){
        NSArray* devices = [manager devicesCopy];
        [self createClient:devices[0]];
    }
}

-(void)didDiscoverDevice:(HeftRemoteDevice *)newDevice{
    NSLog(@"didDiscoverDevice");
}

-(void)didLostAccessoryDevice:(HeftRemoteDevice *)oldDevice{
    NSLog(@"didLostAccessoryDevice");
    [cardReaderSerial setText:@"None"];
    heftClient = nil;
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
