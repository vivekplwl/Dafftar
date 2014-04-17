//
//  TagViewController.h
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagViewController : UIViewController<UITextViewDelegate>
{
    CGFloat animatedDistance;
}
@property(nonatomic,retain) NSString *notedetail;
@property (weak, nonatomic) IBOutlet UITextField *tagText;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (nonatomic,retain) NSString *notetype;
@property (nonatomic,retain) NSString *ImagePath;
@property (weak, nonatomic) IBOutlet UIDatePicker *dPicker;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *reminderbtn;


@end
