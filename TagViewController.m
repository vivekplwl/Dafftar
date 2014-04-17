//
//  TagViewController.m
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "TagViewController.h"
#import "DBClass.h"
#import "AllNoteViewController.h"

@interface TagViewController ()<UITextViewDelegate>
{
    
}
@end

@implementation TagViewController

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

/*
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView: YES];
}
 
 */

-(void)setreminder
{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // Get the current date
    NSDate *pickerDate = [_dPicker date];
    
    // Break the date up into components
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[_dPicker date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    NSLog(@"%@",dateString);
    
    _timeLabel.text=dateString;
    
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )   fromDate:pickerDate];
    
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )   fromDate:pickerDate];
    
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
	// Notification details
    localNotif.alertBody = @"test";
	// Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}


- (IBAction)setreminderTapped:(id)sender {
    
    [_dPicker setHidden:YES];
    
    [_reminderbtn setHidden:YES];
    
   
    
    // Break the date up into components
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[_dPicker date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    NSLog(@"%@",dateString);
    
    _timeLabel.text=dateString;
    
    
    
    
}

- (IBAction)reminderTapped:(id)sender {
    
    [_dPicker setHidden:NO];
    [sender setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
}


-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
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

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
/*

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:NO];
}
 */

- (void) animateTextView:(BOOL) up
{
    const int movementDistance =60; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement= movement = (up ? -movementDistance : movementDistance);
    NSLog(@"%d",movement);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.inputView.frame, 0, movement);
    [UIView commitAnimations];
}


- (IBAction)saveTapped:(id)sender {
    
     [_dPicker setHidden:NO];
    NSString *tag=_tagText.text; //    _tagtext.text;
    NSString *title= _titleText.text;
    
    NSString *Comment=_commentText.text ;
    
         NSLog(@"%@",tag);
         NSLog(@"%@",title);
         NSLog(@"%@",Comment);
    
    if  (title == (id)[NSNull null] || title.length == 0 )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Name Can not be Blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        
        [alertView show];
    }
    else if  (tag == (id)[NSNull null] || tag.length == 0 )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Tag Can not be Blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        
        [alertView show];
    }
    else if  (Comment == (id)[NSNull null] || Comment.length == 0 )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Comment Can not be Blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        
        [alertView show];
    }
    
    else
    {
  
    NSMutableDictionary* newNote = [[NSMutableDictionary alloc] init];
    
    DBClass  *dboj=[DBClass new];
    
    NSString *tag=_tagText.text; //    _tagtext.text;
    NSString *title= _titleText.text;
    
    NSString *Comment=_commentText.text ; //_noteDetail;
    
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init]  ;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId =[defaults valueForKey:@"userid"];
        NSString *contry=[defaults valueForKey:@"Country"];
    
        
        [dic setValue:_notetype forKey:@"notetype"];
    [dic setValue:tag forKey:@"tag"];
    [dic setValue:title forKey:@"title"];
        [dic setValue:_notedetail forKey:@"notedetail"];
    [dic setValue:Comment forKey:@"comment"];
        [dic setValue:contry forKey:@"Country"];
    [dic  setValue:dateString forKey:@"date"];
    [dic setValue:userId forKey:@"userid"];
        [dic  setValue:_ImagePath forKey:@"imagepath"];
    
    
    
    NSLog(@"%@",dic);
        
        NSUserDefaults *dflt=[NSUserDefaults standardUserDefaults];
        
        
        NSString *post =[NSString stringWithFormat:@"NoteTypeID=%@&UserID=%@&NoteTitle=%@&NotePath=%@&Tag=%@&Comments=%@&Location=%@&IsFavourites=%d",_notetype,[dflt valueForKey:@"duserid"],title,_ImagePath,tag,Comment,@"India",1];
        
        
        NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/Dafftar/Notes/notesend.php"];
        
        
        
        
        
        
        
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

        
        
        
    
    [dboj   insertUserId:dic];
        
        
        NSArray *array = [self.navigationController viewControllers];
        
        [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
        
        
        
    }
    
    
    [self setreminder];
    
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
    
    [_tagText resignFirstResponder];
    [_titleText  resignFirstResponder];
    
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



- (IBAction)BackTapped:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_dPicker setHidden:YES];
    
    
    
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
