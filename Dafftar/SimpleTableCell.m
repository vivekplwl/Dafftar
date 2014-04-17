//
//  SimpleTableCell.m
//  Dafftar
//
//  Created by apple on 04/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "SimpleTableCell.h"
#import "DBClass.h"

@implementation SimpleTableCell
@synthesize nameLabel = _nameLabel;
@synthesize TimeLabel = _TimeLabel;
@synthesize thumbnailImageView = _thumbnailImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [[self TimeLabel] setFont:[UIFont fontWithName:@"System" size:9]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
     [[self TimeLabel] setFont:[UIFont fontWithName:@"System" size:9]];

    // Configure the view for the selected state
}

- (IBAction)button:(id)sender {
    
    
  //  [sender setImage:[UIImage imageNamed:@"fill-star.png"] forState:UIControlStateNormal];
    
        
        [sender setBackgroundImage:[UIImage imageNamed:@"fill-star.png"] forState:UIControlStateNormal];
    /*
    
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"fill-star"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:[UIImage imageNamed:@"fill-star"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
    */
    
    DBClass  *dboj=[DBClass new];
    
    
        
    
    
    
    
    
}
@end
