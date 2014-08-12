//
//  ViewController.h
//  gettingStarted
//
//  Created by Jón Hilmar Gústafsson on 12/08/14.
//  Copyright (c) 2014 handpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeftClient.h"
#import "HeftManager.h"
#import "HeftStatusReportPublic.h"

@interface ViewController : UIViewController <HeftDiscoveryDelegate, HeftStatusReportDelegate>

@end
