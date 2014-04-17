//
//  HomeViewController.h
//  Dafftar
//
//  Created by apple on 01/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate>
{
    
}


- (IBAction)favouriteTapped:(id)sender;

@end
