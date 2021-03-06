//
//  ViewController.h
//  gettingStarted
//
//  Created by Handpoint on 12/08/14.
//  Copyright (c) 2014 Handpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeftClient.h"
#import "HeftManager.h"
#import "HeftStatusReportPublic.h"

@interface ViewController : UIViewController <HeftDiscoveryDelegate, HeftStatusReportDelegate>{
    
    __weak IBOutlet UILabel *cardReaderSerial;
    __weak IBOutlet UILabel *transactionStatus;
}
@property(nonatomic, strong) id<HeftClient> heftClient;
@property(nonatomic, strong) HeftManager* manager;
@end
