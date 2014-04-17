//
//  FavouriteNoteViewController.m
//  Dafftar_App
//
//  Created by apple on 25/03/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "FavouriteNoteViewController.h"
#import "DBClass.h"
#import "DetailNoteViewControler.h"
#import "DetailViewControllerCamera.h"
#import "DetailViewControllerText.h"
#import "SimpleTableCell.h"


@interface FavouriteNoteViewController ()
{
    NSMutableArray *arr;
    
}
@end

@implementation FavouriteNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.textLabel.text=[[arr objectAtIndex:indexPath.row]  valueForKey:@"title"];
//    cell.detailTextLabel.text=[[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
//    
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
     cell.backgroundColor=[UIColor clearColor];
    cell.nameLabel.text =   [[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
    cell.TimeLabel.text = [[arr objectAtIndex:indexPath.row]  valueForKey:@"title"];
         cell.typelbl.text= [[arr objectAtIndex:indexPath.row]  valueForKey:@"notetype"];
    
    
    cell.thumbnailImageView.image =
    
    cell.thumbnailImageView.image = [UIImage imageNamed:@"blank-star"];
    
    cell.TimeLabel.font = [UIFont fontWithName:@"ArialMT" size:4];
    
    cell.TimeLabel.font = [UIFont systemFontOfSize:2.0];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCamera" bundle:Nil];
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
                dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerText" bundle:Nil];}
        }
        else
        {
            dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerText" bundle:Nil];
        }
        
        
        
        
        dc.notepath=[[arr objectAtIndex:indexPath.row] valueForKey:@"notepath" ];
        dc.noteTitle=[[arr objectAtIndex:indexPath.row] valueForKey:@"title" ];
        dc.noteTag=[[arr objectAtIndex:indexPath.row] valueForKey:@"tag" ];
        dc.noteLocation=[[arr objectAtIndex:indexPath.row] valueForKey:@"location" ];
        
        dc.noteDate=[[arr objectAtIndex:indexPath.row] valueForKey:@"date" ];
        dc.noteComment=[[arr objectAtIndex:indexPath.row] valueForKey:@"comment" ];
        dc.noteId =[[[arr objectAtIndex:indexPath.row] valueForKey:@"noteid" ] integerValue] ;
        
        [self.navigationController pushViewController:dc
                                             animated:YES];
        
    }
    
    
  //  DetailNoteViewControler *detailViewController = [[NoteDetailViewController alloc] //initWithNibName:@"NoteDetailViewController" bundle:nil];
    
//    detailViewController.detaildate=[[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
//    detailViewController.notetitle=[[arr objectAtIndex:indexPath.row]  valueForKey:@"title"];
//    detailViewController.tag=[[arr objectAtIndex:indexPath.row]  valueForKey:@"tag"];
//    detailViewController.Comment=[[arr objectAtIndex:indexPath.row]  valueForKey:@"comment"];
//    detailViewController.NoteId=[[[arr objectAtIndex:indexPath.row]  valueForKey:@"noteid"] integerValue];
//    detailViewController.isFavourite=YES;
    
    //  detailViewController.Location=[[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
    
//    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arr =[[NSMutableArray alloc]init];
    DBClass  *dboj=[DBClass new];
    
    arr= [dboj   getUserIdFev];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
