//
//  DetailViewControllerText.h
//  Dafftar
//
//  Created by apple on 14/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewControllerText : UIViewController
{
    
}
@property (nonatomic, assign) BOOL isFavourite;
@property (weak, nonatomic) IBOutlet UIButton *StarBtn;
@property (nonatomic,retain) NSString *notepath;
@property (nonatomic,retain) NSString *noteTitle;
@property (nonatomic,retain) NSString *noteLocation;
@property (nonatomic,retain) NSString *noteTag;
@property (nonatomic,retain) NSString *noteDate;
@property (nonatomic,retain) NSString *noteComment;
@property (nonatomic,retain) NSString *notedetail;
@property (nonatomic, assign) NSInteger noteId;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UILabel *locationlbl;

@property (weak, nonatomic) IBOutlet UILabel *datelbl;
@property (weak, nonatomic) IBOutlet UILabel *taglbl;
@property (weak, nonatomic) IBOutlet UITextView *commentview;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

- (IBAction)backtapped:(id)sender;


@end
