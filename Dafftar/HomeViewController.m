//
//  HomeViewController.m
//  Dafftar
//
//  Created by apple on 01/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "HomeViewController.h"
//#import "DBClass.h"
#import "KxMenu.h"
#import "AllNoteViewController.h"
#import "DetailNoteViewControler.h"
#import "CameraViewController.h"
#import "VideoViewController.h"
#import "SearchViewController.h"
#import "SettingViewController.h"
#import "AllTagViewController.h"
#import "MapViewController.h"

#import "AudioViewController.h"
#import "FavouriteNoteViewController.h"

@interface HomeViewController ()
{
    CLLocationManager *locationManager;
   
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
  //  [locationManager startUpdatingLocation];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      locationManager = [[CLLocationManager alloc] init];
       geocoder = [[CLGeocoder alloc] init];
    
    
   
    
   [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    NSString  *lati;
    NSString  *longi;

    
    if (currentLocation != nil) {
        longi = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        lati = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
     NSLog(@"%@",longi);
         NSLog(@"%@",lati);
    
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
     NSString   *    address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
                NSLog(@"%@", placemark.country);
            
            NSUserDefaults *dflts=[NSUserDefaults standardUserDefaults];
            
            [dflts setValue:placemark.country forKey:@"Country"];
            
            
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];

}

- (IBAction)AllNotesClicked:(id)sender {
    
    
    AllNoteViewController *Aobj;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            Aobj=[[AllNoteViewController alloc]initWithNibName:@"AllNoteViewControllerSmall" bundle:Nil];

            // iPhone Classic
        }
        if(result.height == 568)
        {
            Aobj=[[AllNoteViewController alloc]initWithNibName:@"AllNoteViewController" bundle:Nil];
        }
    }
    else
    {
        Aobj=[[AllNoteViewController alloc]initWithNibName:@"AllNoteViewController" bundle:Nil];
 }
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
    
    
}
- (IBAction)settingTapped:(id)sender {
    
    
    SettingViewController *Aobj=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:Nil];
    
    [self.navigationController pushViewController:Aobj animated:YES];
}

- (IBAction)fevTapped:(id)sender {
}

- (IBAction)searchTapped:(id)sender {
    
    
    SearchViewController *Aobj=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:Nil];
    
    [self.navigationController pushViewController:Aobj animated:NO];
    
}

- (IBAction)allTagTapped:(id)sender {
    AllTagViewController *Aobj=[[AllTagViewController alloc]initWithNibName:@"AllTagViewControllerSmall" bundle:Nil];
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
    
}



- (IBAction)NewNoteClicked:(id)sender {
    
    NSArray *menuItems =
    @[
      
//      [KxMenuItem menuItem:@"ACTION MENU 1234456"
//                     image:nil
//                    target:nil
//                    action:NULL],
      
     
      
      [KxMenuItem menuItem:@"Text"
                     image:[UIImage imageNamed:@"text_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Camera"
                     image:[UIImage imageNamed:@"camera_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItemCamera:)],

      [KxMenuItem menuItem:@"Qr Scanner"
                     image:[UIImage imageNamed:@"scanning_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"voice record"
                     image:[UIImage imageNamed:@"voice_recording_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItemAudio:)],
      
      [KxMenuItem menuItem:@"Video"
                     image:[UIImage imageNamed:@"video_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItemVideo:)],
      
      [KxMenuItem menuItem:@"Task"
                     image:[UIImage imageNamed:@"task_dropdown_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      ];
    
  //  KxMenuItem *first = menuItems[0];
   // first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //first.alignment = NSTextAlignmentCenter;
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(225, 55, 100, 50)
                 menuItems:menuItems];
    
}


- (void) pushMenuItem:(id)sender
{
    DetailNoteViewControler *Aobj=[[DetailNoteViewControler alloc]initWithNibName:@"DetailNoteViewControler" bundle:Nil];
    
    NSLog(@"%@",sender);
    
    [self.navigationController pushViewController:Aobj animated:YES];
}


- (void) pushMenuItemAudio:(id)sender
{
    AudioViewController *Aobj=[[AudioViewController alloc]initWithNibName:@"AudioViewControllerSmall" bundle:Nil];
    
    NSLog(@"%@",sender);
    
    [self.navigationController pushViewController:Aobj animated:YES];
}



- (void) pushMenuItemCamera:(id)sender
{
    
    CameraViewController *Aobj;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            Aobj=[[CameraViewController alloc]initWithNibName:@"CameraViewControllerSmall" bundle:Nil];
            // iPhone Classic
        }
        if(result.height == 568)
        {
       Aobj=[[CameraViewController alloc]initWithNibName:@"CameraViewControllerSmall" bundle:Nil]; }
    }
    else
    {
   Aobj=[[CameraViewController alloc]initWithNibName:@"CameraViewControlleriPad" bundle:Nil];
    
    }
    
    

    
    NSLog(@"%@",sender);
    
    [self.navigationController pushViewController:Aobj animated:YES];
}
- (void) pushMenuItemVideo:(id)sender
{
    VideoViewController *Aobj=[[VideoViewController alloc]initWithNibName:@"VideoViewControllerSmall" bundle:Nil];
    
    NSLog(@"%@",sender);
    
    [self.navigationController pushViewController:Aobj animated:YES];
}

-(void)signUpInBackGround
{
  //  NSString *genderString = @"male";
  
//    
//    NSString *post = [NSString stringWithFormat:@"username=%@&pwd=%@&city=%@",
//					  @"vivek", @"Pwd", @"Noida"];
//    
//    
//    NSString *urlStr = [NSString stringWithFormat:@"http://qa.zibrasoft.com/dafftar/write.php?username=%@&pwd=%@&city=%@",@"vive",@"zzzz",@"sss"];
//    
//
//    NSLog(@"URL=%@",urlStr);
//    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSString *post =[NSString stringWithFormat:@"UserName=%@&Password=%@&Email=%@&Country=%@&Company=%@&Gender=%@&DOB=%@&CreatedOn=%@",@"email",@"email",@"email",@"email",@"email",@"email",@"email",@"email"];
    
    NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/Dafftar/ws-server-regis/signup.php"];
    
    
//    NSURL *url=[NSURL URLWithString:@"http://qa.zibrasoft.com/dafftar/write.php?username=%@&pwd=%@&city=%@",@"vive"];
    
    
    
    
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
    [self performSelectorOnMainThread:@selector(registrationResponse:) withObject:responseString waitUntilDone:YES];
}
- (IBAction)mapTapped:(id)sender {
    
    
    
    MapViewController *Aobj;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            Aobj=[[MapViewController alloc]initWithNibName:@"MapViewControllerSmall" bundle:Nil];
            
            // iPhone Classic
        }
        if(result.height == 568)
        {
            Aobj=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:Nil];
        }
    }
    else
    {
        Aobj=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:Nil];
    }
    
    
    [self.navigationController pushViewController:Aobj animated:YES];

    
    
}




-(void)GetData
{
    
    NSString *post = [NSString stringWithFormat:@"username=%@&pwd=%@&city=%@",
					  @"vivek", @"Pwd", @"Noida"];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://qa.zibrasoft.com/dafftar/read.php"];
    
    
    NSLog(@"URL=%@",urlStr);
    NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/dafftar/read.php"];
    
    
    //    NSURL *url=[NSURL URLWithString:@"http://qa.zibrasoft.com/dafftar/write.php?username=%@&pwd=%@&city=%@",@"vive"];
    
    
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //  [request setHTTPBody:postData];
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *data =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self performSelectorOnMainThread:@selector(registrationResponse:) withObject:responseString waitUntilDone:YES];

    
    
    
}



-(void)registrationResponse:(NSString *)string
{
    
    if([string isEqualToString:@"0"])
    {
        // success
    
        
        
    }
    else if([string isEqualToString:@"1"])
    {
        // fail
  
        
    }
    else
    {
        
        
    }
    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Ways",@"") message:AMLocalizedString(@"Receive_sms",@"") delegate:self cancelButtonTitle:AM
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favouriteTapped:(id)sender {
    
    FavouriteNoteViewController *Aobj;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            Aobj=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewControllerSmall" bundle:Nil];
            
            // iPhone Classic
        }
        if(result.height == 568)
        {
           Aobj=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewController" bundle:Nil]; }
    }
    else
    {
        Aobj=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewController" bundle:Nil];}
    

    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
}
@end
