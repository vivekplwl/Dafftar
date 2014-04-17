//
//  DetailViewControllerText.m
//  Dafftar
//
//  Created by apple on 14/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "DetailViewControllerText.h"
#import "DBClass.h"
#import <MessageUI/MessageUI.h>
#import "FavouriteNoteViewController.h"
@interface DetailViewControllerText ()<MFMailComposeViewControllerDelegate>


@property (nonatomic, strong) NSArray *files;
@end
@implementation DetailViewControllerText

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backtapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFavourite:(id)sender {
    DBClass  *dboj=[DBClass new];
    
    
    [dboj   MakeFavourite:_noteId];
    
    
    
    
    if (_isFavourite == NO) {
        
        [dboj MakeFavourite:_noteId];
        [_StarBtn  setImage:[UIImage imageNamed:@"fill-star.png"] forState:UIControlStateNormal];
    }
    else
    {
        [dboj MakeUnFavourite:_noteId];
        
        [_StarBtn  setImage:[UIImage imageNamed:@"blank-star.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    
    
    
}

- (IBAction)fevClicked:(id)sender {
    
    
    FavouriteNoteViewController *fev=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewController" bundle:Nil];
    
    [self.navigationController pushViewController:fev animated:YES];
    
    
}







- (IBAction)sendEmail:(id)sender {
   /*
    
    NSString *emailTitle = @"Great Photo and Doc";
    NSString *messageBody = @"Hey, check this out!";
    NSArray *toRecipents = [NSArray arrayWithObject:@"vivekplwl@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    NSString *selectedFile = [_files objectAtIndex:0];
    
    // Determine the file name and extension
    NSArray *filepart = [selectedFile componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    
    UIImage *myImage = [UIImage imageNamed:@"capture_btn"];
    NSData *imageData = UIImagePNGRepresentation(myImage);
    [mc addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
    
    // Add attachment
  //  [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    */
 
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            mailer.mailComposeDelegate = self;
            
            [mailer setSubject:_noteTitle];
            
            
            NSArray *toRecipients = [NSArray arrayWithObjects:@"vivekplwl@gmail.com", @"secondMail@example.com", nil];
            [mailer setToRecipients:toRecipients];
            UIImage *myImage = [UIImage imageNamed:@"capture_btn.png"];
           // UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
            NSData *imageData = UIImagePNGRepresentation(myImage);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
            
            NSString *emailBody = @"Read my note:";
            [mailer setMessageBody:emailBody isHTML:NO];
            
            [self presentModalViewController:mailer animated:YES];
           
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                            message:@"Your device doesn't support the composer sheet"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
          
        }
        
    }

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titlelbl.text=_noteTitle;
    _locationlbl.text=_noteLocation;
    _taglbl.text=_noteTag;
    _datelbl.text=_noteDate;
    _commentview.text=_noteComment;
    _detailTextView.text=_notedetail;
    
     NSLog(@"%@",_notepath);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
