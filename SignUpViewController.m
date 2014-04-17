//
//  SignUpViewController.m
//  Dafftar
//
//  Created by apple on 15/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    
    if(heightFraction < 0.0){
        
        heightFraction = 0.0;
        
    }else if(heightFraction > 1.0){
        
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
        
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        
    }else{
        
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
   
  
    
    [_passwordTxt  resignFirstResponder];
    [_confirmPassTxt resignFirstResponder];
    [_countryTxt resignFirstResponder];
    [_dobTxt resignFirstResponder];
    [_emailText resignFirstResponder];
    [_companyText  resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitTapped:(id)sender {
    
    
    NSString *post =[NSString stringWithFormat:@"UserName=%@&Password=%@&Email=%@&Country=%@&Company=%@&Gender=%@&DOB=%@",_emailText.text,_passwordTxt.text,_emailText.text,_countryTxt.text,_companyText.text,@"male",_dobTxt.text];
    
    NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/Dafftar/ws-server-regis/signup.php"];
    
    

    
    
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *data =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    [self performSelectorOnMainThread:@selector(registrationResponse:) withObject:responseString waitUntilDone:YES];
    
    
    
    
    
    
}

- (IBAction)femaleClicked:(id)sender {
    
    
      _imgFmale.image=[UIImage imageNamed:@"checked_checkbox.png"];
    
    _imgMale.image=[UIImage imageNamed:@"checkbox.png"];
    
}
- (IBAction)maleTapped:(id)sender {
    
        _imgFmale.image=[UIImage imageNamed:@"checkbox.png"];
    
    _imgMale.image=[UIImage imageNamed:@"checked_checkbox.png"];
}

- (IBAction)conditionTapped:(id)sender {
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
}
@end
