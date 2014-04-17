//
//  DetailViewControllerCamera.h
//  Dafftar
//
//  Created by apple on 09/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewControllerCamera : UIViewController
{
    
}
@property (nonatomic, assign) BOOL isFavourite;
@property (weak, nonatomic) IBOutlet UIButton *StarBtn;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic,retain) NSString *notepath;
@property (nonatomic,retain) NSString *noteTitle;
@property (nonatomic,retain) NSString *noteLocation;
@property (nonatomic,retain) NSString *noteTag;
@property (nonatomic,retain) NSString *noteDate;
@property (nonatomic,retain) NSString *noteComment;
@property (nonatomic,retain) NSString *notetype;
@property (nonatomic, assign) NSInteger noteId;


@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *Tag;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;




@end
