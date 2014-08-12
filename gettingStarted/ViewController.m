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
@synthesize heftClient, manager;

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
    
    // Declare the shared secret in hex numbers.
    uint8_t ss[32] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x30, 0x31, 0x32};
    
    heftClient = nil;
    [manager clientForDevice:newDevice sharedSecret:[[NSData alloc] initWithBytes:ss length:sizeof(ss)] delegate:self];
    
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
