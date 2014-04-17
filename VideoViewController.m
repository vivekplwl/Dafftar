//
//  VideoViewController.m
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "VideoViewController.h"
#import "DBClass.h"
#import "TagViewController.h"
// #import " MediaPlayer/MediaPlayer.h "

@interface VideoViewController ()
{
    NSMutableArray *arr;
}

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    arr =[[NSMutableArray alloc]init];
    DBClass  *dboj=[DBClass new];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    
    arr= [dboj   getUserId:[[defaults valueForKey:@"userid"] integerValue]];
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated
{
   
}
 
/*
- (void)viewDidAppear:(BOOL)animated {
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    [self.movieController setContentURL:self.movieURL];
    [self.movieController.view setFrame:CGRectMake (0, 0, 320, 476)];
    [self.view addSubview:self.movieController.view];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [self.movieController play];
    
}
 
 */
- (IBAction)back_clicked:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.movieURL = info[UIImagePickerControllerMediaURL];
    
     NSLog(@"%@",self.movieURL);
    
    
    
    
    
    
    
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *tempPath = [documentsDirectory stringByAppendingFormat:@"/vid1.mp4"];
    
    UISaveVideoAtPathToSavedPhotosAlbum([videoURL path], nil, nil, nil);
    
    
    
    [videoData writeToFile:tempPath atomically:NO];
    
    NSData * movieData = [NSData dataWithContentsOfURL:videoURL];
    
  //  NSString *mstr=@"savedImage.png";
    
  //  NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:mstr];
  
  //  [movieData writeToFile:savedImagePath atomically:NO];
    
    
    
    
    //////////
    
    
    NSString *mstr=[@"savedvideo" stringByAppendingString:[NSString stringWithFormat:@"%d",  [arr count] ]];
       mmm=[mstr stringByAppendingString:@".mp4"];
    
    savedVideoPath = [documentsDirectory stringByAppendingPathComponent:mmm];
    
    [videoData writeToFile:savedVideoPath atomically:NO];
    
   
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL: videoURL];
    
    UIImage *thumbnail = [player thumbnailImageAtTime:0.1 timeOption:MPMovieTimeOptionExact];
    _imageView.image=thumbnail;
    
    
    
}

- (IBAction)doneTapped:(id)sender {
    
    TagViewController *Aobj;
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
            Aobj  =[[TagViewController alloc]initWithNibName:@"TagViewControllerSmall" bundle:Nil];
            // iPhone Classic
        }
        if(result.height == 568)
        {
            Aobj  =[[TagViewController alloc]initWithNibName:@"TagViewControllerSmall" bundle:Nil];
        }
    }
    else
    {
        Aobj  =[[TagViewController alloc]initWithNibName:@"TagViewControlleriPad" bundle:Nil];
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:mmm];
 
    
    
    
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init]  ;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId =[defaults valueForKey:@"userid"];
    
    
    [dic setValue:@"2" forKey:@"notetype"];
    [dic setValue:@"tag" forKey:@"tag"];
    [dic setValue:@"title" forKey:@"title"];
    [dic setValue:@"Comment" forKey:@"comment"];
    [dic  setValue:savedVideoPath forKey:@"imagepath"];
    
    
    [dic  setValue:dateString forKey:@"date"];
    [dic setValue:userId forKey:@"userid"];
    
    
    
    
    NSLog(@"%@",dic);
    
    //  [dboj   insertUserId:dic];
    
    Aobj.notetype=@"3";
    Aobj.ImagePath=savedVideoPath;
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
    
}



- (IBAction)playVideo:(id)sender {
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    
    
    NSURL *url = [NSURL fileURLWithPath:savedVideoPath isDirectory:NO]; //THIS IS THE KEY TO GET THIS RUN :)
//    [introPlayer setContentURL:url];
    
 
    
 //   [self.movieController setContentURL: [defaults valueForKey:@"userid"] ];
    
     [self.movieController setContentURL: url];
    [self.movieController.view setFrame:CGRectMake (20, 110, 270, 316)];
    [self.view addSubview:self.movieController.view];
    
    [self.movieController play];
}





- (IBAction)TakeVideo:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}
@end
