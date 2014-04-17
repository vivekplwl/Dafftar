//
//  DetailNoteViewControler.m
//  PlainNote
//
//  Created by Vincent Koser on 1/28/10.
//  Copyright 2010 kosertech. All rights reserved.
//

#import "DetailNoteViewControler.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "instaPaperLib.h"
#import "DBClass.h"
#import "KxMenu.h"
#import "TagViewController.h"


@implementation DetailNoteViewControler 
@synthesize NoteDetail, Notedict, noteArray, mailButton, scrollView, toolBar;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
 
 
 //
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
	
    
     NSLog(@"%d",_noteId);
    
	NoteDetail.delegate = self;
	didEdit = NO;
	keyboardVisible = NO;
	scrollView.contentSize = self.view.frame.size;
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] ;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)] ;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
												 name: UIKeyboardDidHideNotification object:nil];
	
	if ([MFMailComposeViewController canSendMail])
		mailButton.enabled = YES;
	
	
}


- (IBAction)addFavourite:(id)sender {
    
    DBClass  *dboj=[DBClass new];
    
    
      [dboj   MakeFavourite:_noteId];
    
    

    
    
}




- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if(self.Notedict != nil){
		NoteDetail.text = [Notedict objectForKey:@"notedetail"];

	}
	
    
     [self.navigationController setNavigationBarHidden:NO];
    
}

-(void) viewWillDisappear:(BOOL)animated {
	//NSLog (@"Unregsitering for keyboard events");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	
	//if we edited lets save the note in case we're exiting for a text or incoming call
	if(didEdit){
		//[self savePlist];
		
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) keyboardDidShow: (NSNotification *)notif {
	if (keyboardVisible) {
		//NSLog(@"Keyboard is already visible. Ignoring notofication.");
		return;
	}
	
	//The keyboard wasn't visible before
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey]; 
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	//resize the scroll view
	CGRect viewFrame = self.view.frame; 
	viewFrame.size.height -= (keyboardSize.height);
	viewFrame.size.height -= [toolBar frame].size.height;
	scrollView.frame = viewFrame;
	
	//change the button to a done instead of save
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)] ;
	keyboardVisible = YES;
}

-(void) keyboardDidHide: (NSNotification *)notif {
	
	
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame; 
	viewFrame.size.height += keyboardSize.height;
	scrollView.frame = viewFrame;
	
	if (!keyboardVisible) {
		//NSLog(@"Keyboard is already hidden. Ignoring notification.");
		return;
	}
	
	keyboardVisible = NO;
	
}


// to handle in app mail
- (IBAction) mailButtonAction: (id) sender {
	// pop the popup action sheet to show the available options
	[self popupActionSheet];
}

-(void)popupActionSheet {
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"Mail Note",@"Instapaper",nil];
	
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	//[popupQuery release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		// mail note
		
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self;
		
		[picker setSubject:@"A Note from PlainNote!"];
		
		
		// Set up recipients	
		// Fill out the email body text
		NSString *emailBody = self.NoteDetail.text;
		[picker setMessageBody:emailBody isHTML:NO];
		
		[self presentModalViewController:picker animated:YES];
	//	[picker release];
		
		
	} else if (buttonIndex == 1) {
		// instapaper
				
		// read prefs for user/pass
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString *username = [defaults stringForKey:@"username_preference"];
		NSString *password = [defaults stringForKey:@"password_preference"];
		
		instaPaperLib *IPLib = [[instaPaperLib alloc] init];
		BOOL response = [IPLib postToInstapaperWithUserName:username 
												andPassword:password 
													andBody:NoteDetail.text 
													 andURL:@"plainnote.kosertech.com" 
												   andTitle:@"Note from PlainNote"];
		
		
		if(response){
			//NSLog(@"Good status");
			
		}
		else{
			//NSLog(@"Bad Status");
			
			UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network error" message: @"Error sending your info to the server" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
			[someError show];
		//	[someError release];
			
		}		
		
		//[IPLib release];
		
	}
}

/*
- (IBAction) upButtonAction: (id) sender { 
	
	
}

- (IBAction) dnButtonAction: (id) send { 
}
*/

- (IBAction) save: (id) sender { 
	
//	if(keyboardVisible){
//		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
//		[NoteDetail resignFirstResponder];
//		keyboardVisible=NO;
//		return;
//		
//	}
	
	//[self savePlist];
	
//	NSLog(@"Save pressed!");
	//[self dismissModalViewControllerAnimated:YES];
    
    TagViewController *tag =[[TagViewController alloc]initWithNibName:@"TagViewControllerSmall" bundle:Nil];
    
    tag.notedetail=NoteDetail.text;
    tag.notetype=@"1";
    
    
    
    [self.navigationController pushViewController:tag animated:YES];
    
    
   // [self.navigationController popViewControllerAnimated:YES];
}

-(void)savePlist
{
    
    NSMutableDictionary* newNote = [[NSMutableDictionary alloc] init]; 
    
    DBClass  *dboj=[DBClass new];
    
    NSString *tag=@"Tag"; //    _tagtext.text;
    NSString *title=@"Title" ; // _titleText.text;
    
    NSString *Comment=NoteDetail.text ; //_noteDetail;
    
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init]  ;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId =[defaults valueForKey:@"userid"];
    
    
    [dic setValue:@"1" forKey:@"notetype"];
    [dic setValue:tag forKey:@"tag"];
    [dic setValue:title forKey:@"title"];
    [dic setValue:Comment forKey:@"comment"];
    [dic  setValue:dateString forKey:@"date"];
    [dic setValue:userId forKey:@"userid"];
    
    
    
    
    NSLog(@"%@",dic);
    
    [dboj   insertUserId:dic];
    
}
/*

- (void) savePlist{
	
	// Create a new  dictionary for the new values 
	NSMutableDictionary* newNote = [[NSMutableDictionary alloc] init]; 
	
	[newNote setValue:NoteDetail.text forKey:@"Text"]; 	
	[newNote setObject:[NSDate date] forKey:@"CDate"]; 
	
	
	if(self.Notedict != nil){
		// We're working with an exisitng note, so let's remove
		// it from the array to get ready for a new one
		[noteArray removeObject:Notedict];
		self.Notedict = nil; //This will release our reference too
		
	}
	
	// Add it to the master  array and release our reference 
	[noteArray addObject:newNote]; 
	
	//important, without this it double creates your saved note on exit due to saving on viewWillDissapear
	didEdit = NO;
	
//	[newNote release];
	
	// Sort the array since we just aded a new drink
	NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"CDate" ascending:NO selector:@selector(compare:)];
	[noteArray sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
//	[nameSorter release];
	
	
	
}

 */


- (IBAction) cancel: (id) sender {
    
        [self.navigationController popViewControllerAnimated:YES];
    
//	NSLog(@"Cancel pressed!"); 
	// handle popup warning of unsaved changes
	/*
	if(!didEdit)
	{
		//[self dismissModalViewControllerAnimated:YES];
	    [self.navigationController popViewControllerAnimated:YES];
    
    }
	else
	{	
		// open a alert with an OK and cancel button
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes!" message:@"Close without saving?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		[alert show];
		//[alert release];
		
	}
		
	*/

/*

        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"ACTION MENU 1234456"
                         image:nil
                        target:nil
                        action:NULL],
          
          [KxMenuItem menuItem:@"Share this"
                         image:[UIImage imageNamed:@"action_icon"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"Check this menu"
                         image:nil
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"Reload page"
                         image:[UIImage imageNamed:@"reload"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"Search"
                         image:[UIImage imageNamed:@"search_icon"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"Go home"
                         image:[UIImage imageNamed:@"home_icon"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        KxMenuItem *first = menuItems[0];
        first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        first.alignment = NSTextAlignmentCenter;
        
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(5, 5, 100, 50)
                 menuItems:menuItems];

 
 */
}


    - (void) pushMenuItem:(id)sender
    {
        NSLog(@"%@", sender);
    }

	

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		//NSLog(@"cancel")
		
	}
	else
	{
          [self.navigationController popViewControllerAnimated:YES];
		[self dismissModalViewControllerAnimated:YES];
		//NSLog(@"ok");
	}
}

- (void)textViewDidChange:(UITextView *)NoteDetail{
	
	//text field has started edit session show warning on cancel without save
	didEdit = YES;
	//NSLog(@"didEdit=YES");
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
//	NSLog(@"viewDidUnload");
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
//	[noteArray release];
//	[Notedict release];
//	[NoteDetail release];
	//[scrollView release];
  //  [super dealloc];
}


@end
