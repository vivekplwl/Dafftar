//
//  SimpleTableCell.h
//  Dafftar
//
//  Created by apple on 04/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell
{
    
}

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *TimeLabel;
@property (nonatomic,weak) IBOutlet UILabel *typelbl;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

- (IBAction)button:(id)sender;



@end
