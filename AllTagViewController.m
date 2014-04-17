//
//  AllTagViewController.m
//  Dafftar
//
//  Created by apple on 11/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "AllTagViewController.h"
#import "DBClass.h"
#import "SimpleTableCell.h"
#import "DetailViewControllerCamera.h"
#import "DetailNoteViewControler.h"
#import "DetailViewControllerText.h"



@interface AllTagViewController ()
{
    NSMutableArray *arr;
}
@end

@implementation AllTagViewController

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
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    cell.nameLabel.text = [[arr objectAtIndex:indexPath.row]  valueForKey:@"date"];
    cell.TimeLabel.text =[[arr objectAtIndex:indexPath.row]  valueForKey:@"tag"];
    cell.typelbl.text= [[arr objectAtIndex:indexPath.row]  valueForKey:@"notetype"];
    
    
    
    cell.thumbnailImageView.image =
    
    cell.thumbnailImageView.image = [UIImage imageNamed:@"blank-star"];
    
    cell.TimeLabel.font = [UIFont fontWithName:@"ArialMT" size:4];
    
    cell.TimeLabel.font = [UIFont systemFontOfSize:2.0];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    NSLog(@"%d",[[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ] integerValue]);
  /*
    NSInteger myint=[[[arr objectAtIndex:indexPath.row] valueForKey:@"notetype" ] integerValue];
    
    if (myint == 2) {
        
        DetailViewControllerCamera *dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCamera" bundle:Nil];
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
            dc=[[DetailViewControllerCamera alloc]initWithNibName:@"DetailViewControllerCamera" bundle:Nil];
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
                dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerTextSmall" bundle:Nil];}
        }
        else
        {
            dc=[[DetailViewControllerText alloc]initWithNibName:@"DetailViewControllerTextSmall" bundle:Nil];
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

    
    
    
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
