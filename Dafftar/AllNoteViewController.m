//
//  AllNoteViewController.m
//  Dafftar
//
//  Created by apple on 01/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "AllNoteViewController.h"
#import "DetailNoteViewControler.h"
#import "DBClass.h"
#import "DetailViewControllerCamera.h"
#import "DetailViewControllerText.h"
#import "KxMenu.h"
#import "SBJson.h"
#import "SimpleTableCell.h"
#import "FavouriteNoteViewController.h"
#import "HomeViewController.h"
#import "AudioViewController.h"
#import "CameraViewController.h"
#import "VideoViewController.h"
#import "SettingViewController.h"




@interface AllNoteViewController ()
{
        NSMutableArray *arr;
}
@end

@implementation AllNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(225, 55, 100, 50)
                 menuItems:menuItems];
    
}

- (void) pushMenuItem:(id)sender
{
    DetailNoteViewControler *Aobj=[[DetailNoteViewControler alloc]initWithNibName:@"DetailNoteViewControler" bundle:Nil];
    
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






- (IBAction)Back_Clicked:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    
    arr =[[NSMutableArray alloc]init];
    DBClass  *dboj=[DBClass new];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    
    arr= [dboj   getUserId:[[defaults valueForKey:@"userid"] integerValue]];
    
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO selector:@selector(compare:)];
	[arr sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
    
    
    [self getUserData];
    
    
    [_tblview reloadData];
}


-(void)getUserData
{
   
    NSUserDefaults *dflts=[NSUserDefaults standardUserDefaults];
    
    
    
    NSString *post =[NSString stringWithFormat:@"UserID=%@",[dflts valueForKey:@"duserid"]];
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://qa.zibrasoft.com/Dafftar/Notes/useridrecieve.php"];
    
    
    
    
    
    
    
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

    
    
}
   
- (IBAction)homeTapped:(id)sender {
    
  HomeViewController *obj=
    
    [[HomeViewController alloc]initWithNibName:@"HomeViewControllerSmall" bundle:Nil];
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];

    
   
	
     NSLog(@"%@",arr);
    
    
    // Do any additional setup after loading the view from its nib.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [arr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    
     cell.TimeLabel.text =       [[arr objectAtIndex:indexPath.row]  valueForKey:@"title"];
    
     cell.nameLabel.text = [[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
     cell.typelbl.text= [[arr objectAtIndex:indexPath.row]  valueForKey:@"notetype"];
    
    
    
  //   cell.TimeLabel.font = [UIFont fontWithName:@"ArialMT" size:4];
    
    
    cell.thumbnailImageView.image =
    
    cell.thumbnailImageView.image = [UIImage imageNamed:@"blank-star"];
    
  //  cell.TimeLabel.font = [UIFont fontWithName:@"ArialMT" size:4];
    
   //  cell.TimeLabel.font = [UIFont systemFontOfSize:2.0];

    /*
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text=[[arr objectAtIndex:indexPath.row] valueForKey:@"title"];
    */
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    NSLog(@"%d",[[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ] integerValue]);
    
    NSInteger myint=[[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ] integerValue];
    
    if (myint == 2) {
        
        
        DetailViewControllerCamera *dc;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                
               dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCameraSmall" bundle:Nil];
                // iPhone Classic
            }
            if(result.height == 568)
            {
            dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCamera" bundle:Nil];}
        }
        else
        {
       dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCameraIpad" bundle:Nil];
        }
        
        
        
   
        dc.notepath=[[arr objectAtIndex:indexPath.row] valueForKey:@"notepath" ];
        dc.noteTitle=[[arr objectAtIndex:indexPath.row] valueForKey:@"title" ];
                dc.noteTag=[[arr objectAtIndex:indexPath.row] valueForKey:@"tag" ];
                dc.noteLocation=[[arr objectAtIndex:indexPath.row] valueForKey:@"location" ];
              dc.notetype=[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ];
                dc.noteDate=[[arr objectAtIndex:indexPath.row] valueForKey:@"date" ];
                dc.noteComment=[[arr objectAtIndex:indexPath.row] valueForKey:@"comment" ];
        dc.noteId =[[[arr objectAtIndex:indexPath.row] valueForKey:@"noteid" ] integerValue] ;
        
        
        [self.navigationController pushViewController:dc
                                             animated:YES];
    
    }
    else if (myint ==3)
    {
        DetailViewControllerCamera *dc;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                
                dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCameraSmall" bundle:Nil];
                // iPhone Classic
            }
            if(result.height == 568)
            {
                dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCamera" bundle:Nil];}
        }
        else
        {
            dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCameraIpad" bundle:Nil];
        }
        
        
        
        
        dc.notepath=[[arr objectAtIndex:indexPath.row] valueForKey:@"notepath" ];
        dc.noteTitle=[[arr objectAtIndex:indexPath.row] valueForKey:@"title" ];
        dc.noteTag=[[arr objectAtIndex:indexPath.row] valueForKey:@"tag" ];
        dc.noteLocation=[[arr objectAtIndex:indexPath.row] valueForKey:@"location" ];
        dc.notetype=[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ];
        
        dc.noteDate=[[arr objectAtIndex:indexPath.row] valueForKey:@"date" ];
        dc.noteComment=[[arr objectAtIndex:indexPath.row] valueForKey:@"comment" ];
        dc.noteId =[[[arr objectAtIndex:indexPath.row] valueForKey:@"noteid" ] integerValue] ;
        
        
        [self.navigationController pushViewController:dc
                                             animated:YES];
    }
    else
    {
        
        
        DetailViewControllerText *dc;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                
                dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerTextSmall" bundle:Nil];
                // iPhone Classic
            }
            if(result.height == 568)
            {
                dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerTextSmall" bundle:Nil];}
        }
        else
        {
            dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerTextIpad" bundle:Nil];
        }
        
        
        
        
        dc.notepath=[[arr objectAtIndex:indexPath.row] valueForKey:@"notepath" ];
        dc.noteTitle=[[arr objectAtIndex:indexPath.row] valueForKey:@"title" ];
        dc.noteTag=[[arr objectAtIndex:indexPath.row] valueForKey:@"tag" ];
        dc.noteLocation=[[arr objectAtIndex:indexPath.row] valueForKey:@"location" ];
        
        dc.noteDate=[[arr objectAtIndex:indexPath.row] valueForKey:@"date" ];
        dc.noteComment=[[arr objectAtIndex:indexPath.row] valueForKey:@"comment" ];
        dc.noteId =[[[arr objectAtIndex:indexPath.row] valueForKey:@"noteid" ] integerValue] ;
        dc.notedetail=[[arr objectAtIndex:indexPath.row] valueForKey:@"notedetail" ];
        [self.navigationController pushViewController:dc
                                             animated:YES];
        
    }
    /*
    else
    {
    
    DetailNoteViewControler *Aobj=[[DetailNoteViewControler alloc]initWithNibName:@"DetailNoteViewControler" bundle:Nil];
    
           Aobj.Notedict = [arr objectAtIndex:indexPath.row];
     	Aobj.noteArray = arr;
    
     Aobj.noteId =[[[arr objectAtIndex:indexPath.row] valueForKey:@"noteid" ] integerValue] ;
    
     Aobj.notepath =[[arr objectAtIndex:indexPath.row] valueForKey:@"notepath" ];
    
        [self.navigationController pushViewController:Aobj
                                             animated:YES];
    
    
    
    }
     */
}

- (IBAction)settingTapped:(id)sender {
    
    SettingViewController *Aobj=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:Nil];
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
}


- (IBAction)fevClicked:(id)sender {
     FavouriteNoteViewController *Aobj=[[FavouriteNoteViewController alloc]initWithNibName:@"FavouriteNoteViewControllerSmall" bundle:Nil];
    
    
    [self.navigationController pushViewController:Aobj animated:YES];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
