
//
//  CameraViewController.m
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "CameraViewController.h"
#import "TagViewController.h"
#import "DBClass.h"

@interface CameraViewController ()
{
    NSMutableArray *arr;
    NSString *mmm;
}
@end

@implementation CameraViewController

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
    
    
    
    NSFileManager *filemgr;
    NSString *currentPath;
    
    filemgr =[NSFileManager defaultManager];
    currentPath = [filemgr currentDirectoryPath];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Back_Clicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.ImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
 */


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage  *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData * imageData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *mstr=[@"savedImage" stringByAppendingString:[NSString stringWithFormat:@"%d",  [arr count] ]];
    mmm=[mstr stringByAppendingString:@".png"];
                    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:mmm];
    
    [imageData writeToFile:savedImagePath atomically:NO];
    
    UIImage *img = [UIImage imageWithContentsOfFile:savedImagePath];
    
    _ImageView.image=img;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    
    _ImageView.image=img;
    
    
    
    
    
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
    [dic  setValue:getImagePath forKey:@"imagepath"];
    
    
    [dic  setValue:dateString forKey:@"date"];
    [dic setValue:userId forKey:@"userid"];
    
    
    
    
    NSLog(@"%@",dic);
    
  //  [dboj   insertUserId:dic];

       Aobj.notetype=@"2";
    Aobj.ImagePath=getImagePath;
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
    
}



- (IBAction)Capture:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)Liberary:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
