//
//  ViewController.m
//  RGCancelToken
//
//  Created by Ryan Goce on 8/27/15.
//  Copyright (c) 2015 Ryan Goce. All rights reserved.
//

#import "ViewController.h"
#import "RGCancellationTokenSource.h"

@interface ViewController ()

@property (nonatomic, strong) RGCancellationTokenSource *cancelTokenSource;

@end

@implementation ViewController

#pragma mark - IBOutlets
-(void)doAsyncTask:(id)sender {
    RGCancellationTokenSource *cancelTokenSource = [RGCancellationTokenSource new];
    self.cancelTokenSource = cancelTokenSource;
    
    [self doAsynchronousOperation:self.cancelTokenSource.token];
}

-(void)cancelAsyncTask:(id)sender {
    [self.cancelTokenSource cancel];
}

-(void)doAsynchronousOperation:(RGCancelToken *)cancelToken {
    [self.activityIndicatorView startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        cancelToken.cancellationRequestedBlock = ^() {
            
            //this block gets called when RGCancellationTokenSource's cancel method is called
            //react to a cancellation request here
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicatorView stopAnimating];
            });
        };
        
        //do your background code here...
        
        while (true) {
            //you can also check if there is a request to cancel using the isCanceled property.
            //below code only continues if there is still no request for cancellation.
            if (cancelToken.isCanceled) {
                break;
            }
            else {
                //continue if not yet canceled.
                //just sleep for a second for demo purposes
                sleep(1);
            }
        }
    });
}

@end
