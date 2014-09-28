//
//  SettingTableViewCell.m
//  KanpetApp
//
//  Created by Junfeng Bai on 14/9/26.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
        self.backgroundColor = [UIColor clearColor];
        self.ImageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
       
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
