//
//  LoginTableViewCell.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 02/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

@synthesize cellImage;
@synthesize cellTextField;

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
