//
//  DetailViewControllerCamera.m
//  Dafftar
//
//  Created by apple on 09/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "DetailViewControllerCamera.h"
#import "DBClass.h"
#import "FavouriteNoteViewController.h"
#import <MessageUI/MessageUI.h>
#import <MediaPlayer/MediaPlayer.h>

@interface DetailViewControllerCamera ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSArray *files;

@end

@implementation DetailViewControllerCamera

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
    
    
    FavouriteNoteViewController *fev=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewControllerSmall" bundle:Nil];
    
    [self.navigationController pushViewController:fev animated:YES];
    
    
}




- (IBAction)sendEmail:(id)sender {
  /*
    
    NSString *emailTitle = @"Great Photo and Doc";
    NSString *messageBody = @"Hey, check this out!";
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
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
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
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
        
        if ([_notetype isEqualToString:@"3"]) {
        NSData *videoData=[[NSData alloc] initWithContentsOfFile:_notepath ];
        
        [mailer addAttachmentData:videoData mimeType:@"video/MOV" fileName:@"Video.MOV"];
  
        }
        else
        {       UIImage *myImage = [UIImage imageWithContentsOfFile:_notepath];
            NSData *imageData = UIImagePNGRepresentation(myImage);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"DafftarImage"];
        }
        
      
 
        // UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
       
        
        NSString *emailBody = _noteComment;
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

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_notetype isEqualToString:@"3"]) {
        
    
    
        NSURL *url = [NSURL fileURLWithPath:_notepath isDirectory:NO];
   
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL: url];
    
    UIImage *thumbnail = [player thumbnailImageAtTime:0.1 timeOption:MPMovieTimeOptionExact];
      _image.image=thumbnail;
    }
    else
    {
        
        
        UIImage *img = [UIImage imageWithContentsOfFile:_notepath];
         _image.image=img;
    }
    
    
    
    _Title.text=_noteTitle;
    _Location.text=_noteLocation;
    _Tag.text=_noteTag;
    _date.text=_noteDate;
    _textView.text=_noteComment;
    
     NSLog(@"%@",_notepath);
    
     _files = @[_notepath];
    
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
