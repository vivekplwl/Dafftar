//
//  SignInViewController.m
//  Dafftar
//
//  Created by apple on 15/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "SignInViewController.h"
#import "HomeViewController.h"
#import "SignUpViewController.h"
#import "AllNoteViewController.h"
#import "SBJson.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
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
    
    [_UserNametxt resignFirstResponder];
    [_Passwordtxt  resignFirstResponder];
    
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



- (IBAction)SignUpTapped:(id)sender {
    
   [self.view endEditing:YES];
    
    SignUpViewController *test;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            test = [[SignUpViewController alloc]     initWithNibName:@"SignUpViewControllerSmall" bundle:nil];
            // iPhone Classic
        }
        if(result.height == 568)
        {
            test = [[SignUpViewController alloc]     initWithNibName:@"SignUpViewController" bundle:nil];
        }
    }
    else
    {
        test = [[SignUpViewController alloc]     initWithNibName:@"SignUpViewController" bundle:nil];
    }
    
        [self.navigationController pushViewController:test animated:YES];
    
}


- (IBAction)SignInTapped:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *post =[NSString stringWithFormat:@"Email=%@&Password=%@",_UserNametxt.text,_Passwordtxt.text];
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/Dafftar/ws-server-regis/login.php"];
    
    
    
    
    
    
    
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

  NSDictionary *myDictionary = [responseString JSONValue];
    
       NSUserDefaults *dflt=[NSUserDefaults standardUserDefaults];
         [dflt setValue:[myDictionary valueForKey:@"UserID"] forKey:@"duserid"];
    
    
    if ([[myDictionary valueForKey:@"status"] integerValue] ==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"wrong User" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:Nil, nil];
        
        
        [alertView show];
        
    }
    else{
    
    AllNoteViewController *test;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            test = [[AllNoteViewController alloc]     initWithNibName:@"AllNoteViewControllerSmall" bundle:nil];
            // iPhone Classic
        }
        if(result.height == 568)
        {
            test = [[AllNoteViewController alloc]     initWithNibName:@"AllNoteViewController" bundle:nil];
        }
    }
    else
    {
        test = [[AllNoteViewController alloc]     initWithNibName:@"AllNoteViewControllerSmall" bundle:nil];
    }
    
    [self.navigationController pushViewController:test animated:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
