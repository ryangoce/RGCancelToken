# RGCancelToken
Simple implementation of cancel tokens normally used for canceling asynchronous operations

The inspiration of this utility class is from the Cancellation Tokens implementation in .NET which can be found here.

https://msdn.microsoft.com/en-us/library/dd997289%28v=vs.110%29.aspx

Copying the description from the above link:

A CancellationToken enables cooperative cancellation between threads, thread pool work items, or Task objects. An object creates a cancellation token by using a CancellationTokenSource, and then passes the cancellation token to any number of threads or objects that should receive notice of cancellation. The token cannot be used to initiate cancellation. When the owning object calls Cancel on the CancellationTokenSource, the IsCancellationRequested property on every copy of the cancellation token is set to true. The objects that receive the notification can respond in whatever manner is appropriate.

Instantiation:
    //creates an instance of RGCancellationTokenSource and assign it to a property so we have a pointer to it.
    RGCancellationTokenSource *cancelTokenSource = [RGCancellationTokenSource new];
    self.cancelTokenSource = cancelTokenSource;


Canceling the task:
```
    [self.cancelTokenSource cancel];
```    
    


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
