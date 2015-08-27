//
//  ViewController.h
//  RGCancelToken
//
//  Created by Ryan Goce on 8/27/15.
//  Copyright (c) 2015 Ryan Goce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(IBAction)doAsyncTask:(id)sender;

-(IBAction)cancelAsyncTask:(id)sender;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end

