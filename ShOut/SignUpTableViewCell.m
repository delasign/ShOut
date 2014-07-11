//
//  SignUpTableViewCell.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 03/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "SignUpTableViewCell.h"

@implementation SignUpTableViewCell

@synthesize termsAndConditions;
@synthesize SignUp;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
