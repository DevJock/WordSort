//
//  InAppPurchaseViewController.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/11/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "AppDelegate.h"

@interface InAppPurchaseViewController : UIViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate,SKRequestDelegate,SKStoreProductViewControllerDelegate,UIAlertViewDelegate>
{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UITextView *productDescription;
@property (strong,nonatomic)SKProduct *theProduct;
@property (strong, nonatomic) IBOutlet UIButton *buyB;
@property (strong, nonatomic) IBOutlet UIButton *restoreB;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)buyButton:(id)sender;
- (IBAction)restoreButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
