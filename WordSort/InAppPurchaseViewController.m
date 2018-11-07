//
//  InAppPurchaseViewController.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/11/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "InAppPurchaseViewController.h"



@interface InAppPurchaseViewController ()

@end

@implementation InAppPurchaseViewController
{
    SKProductsRequest *request;
}

NSString *description;

@synthesize productDescription,productName,theProduct,buyB,restoreB,activityIndicator;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    activityIndicator.hidesWhenStopped = true;
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    productName.text = @"Unlock Word Sort Plus";
    buyB.enabled = false;
    restoreB.enabled = false;
    if([appDelegate.appUnlocked isEqualToString:@"Unlocked"])
    {
        if([activityIndicator isAnimating])
            [activityIndicator stopAnimating];
        productDescription.text = @"Word Sort Plus has Been Unlocked";
    }
    else
    {
        if([SKPaymentQueue canMakePayments])
            {
                [activityIndicator startAnimating];
                productDescription.text = @"Fetching Data ...";
                NSLog(@"Fetching Data");
                request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:appDelegate.inAppPurchaseID]];
                request.delegate = self;
                [request start];
            }
        else
            {
                productDescription.text = @"Please Enable In App Puchases in Settings.";
                if([activityIndicator isAnimating])
                    [activityIndicator stopAnimating];
                NSLog(@"In App Pucrhases Disabled !");
            }
    }// Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
   
    [request cancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unlockApp
{
   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   [prefs setObject:@"Unlocked" forKey:@"AppUnlockStatus"];
    
}


#pragma mark
#pragma mark SKProductsRequestDeleagate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    int count = (int)[response.products count];
    if(count > 0)
    {
        validProduct = [response.products objectAtIndex:0];
        productName.text = validProduct.localizedTitle;
        productDescription.text = validProduct.localizedDescription;
        description = productDescription.text;
        theProduct = validProduct;
        if([activityIndicator isAnimating])
           [activityIndicator stopAnimating];
        buyB.enabled = true;
        restoreB.enabled = true;
        NSLog(@"Products Available!");
    }
    else if(!validProduct)
    {
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}


- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %i",(int) queue.transactions.count );
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        if(SKPaymentTransactionStateRestored){
            NSLog(@"Transaction state -> Restored");
            //called when the user successfully restores a purchase
            [self unlockApp];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
        
    }
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStateDeferred:NSLog(@"Deffered");
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self unlockApp]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                buyB.enabled = false;
                restoreB.enabled = false;
                if([activityIndicator isAnimating])
                   [activityIndicator stopAnimating];
                productDescription.text = @"Word Sort Plus has Been Unlocked";
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                if([activityIndicator isAnimating])
                    [activityIndicator stopAnimating];
                buyB.enabled = false;
                restoreB.enabled = false;
                productDescription.text = @"Word Sort Plus has Been Unlocked";
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
            {
                //called when the transaction does not finnish
                if(transaction.error.code == SKErrorStoreProductNotAvailable)
                {
                    NSLog(@"Transaction state -> Change Of Store Needed");
                    if([activityIndicator isAnimating])
                        [activityIndicator stopAnimating];
                    buyB.enabled = true;
                    restoreB.enabled = true;
                    productDescription.text = description;
                }
                else
                {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could Not Process Payment. Please Try again Later" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                    NSLog(@"Transaction state -> Cancelled");
                    if([activityIndicator isAnimating])
                        [activityIndicator stopAnimating];
                    buyB.enabled = true;
                    restoreB.enabled = true;
                    productDescription.text = description;
                [alert show];
                    //the user cancelled the payment ;(
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
               }
            }
                break;
        }
    }
}

- (IBAction)buyButton:(id)sender
{
    NSLog(@"User requests to unlock App");
    if([SKPaymentQueue canMakePayments])
    {
        buyB.enabled = false;
        restoreB.enabled = false;
        productDescription.text = @"Processing";
        [activityIndicator startAnimating];
        SKPayment *payment = [SKPayment paymentWithProduct:theProduct];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        buyB.enabled = false;
        restoreB.enabled = false;
        productDescription.text = @"Cannot Make Purchases";
        if([activityIndicator isAnimating])
        [activityIndicator stopAnimating];
        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}

- (IBAction)restoreButton:(id)sender
{
    buyB.enabled = false;
    restoreB.enabled = false;
    productDescription.text = @"Processing";
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
