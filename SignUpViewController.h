//
//  SignUpViewController.h
//  Dafftar
//
//  Created by apple on 15/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
{
     CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *companyText;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassTxt;
@property (weak, nonatomic) IBOutlet UITextField *countryTxt;
@property (weak, nonatomic) IBOutlet UITextField *dobTxt;

- (IBAction)submitTapped:(id)sender;
- (IBAction)femaleClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *maleTapped;
- (IBAction)maleTapped:(id)sender;
- (IBAction)conditionTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgMale;

@property (weak, nonatomic) IBOutlet UIImageView *imgFmale;



@end
