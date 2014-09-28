//
//  HomeTableViewCell.m
//  KanpetApp
//
//  Created by nichalos on 14/9/24.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 205);
        self.backgroundColor = [UIColor clearColor];
        self.backGround = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)-10)];
        _backGround.layer.cornerRadius = 5;
        _backGround.backgroundColor = [UIColor whiteColor];
        _backGround.layer.masksToBounds = YES;
        [self.contentView addSubview:_backGround];
        UIView *fangkuai = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        fangkuai.backgroundColor = [UIColor blueColor];
        [_backGround addSubview:fangkuai];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, CGRectGetWidth(self.frame)-40, 40)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = [UIColor blackColor];
        [_backGround addSubview:_name];
        
        self.VedioImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40)];
        _VedioImage.backgroundColor = [UIColor clearColor];
        
        self.myIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((CGRectGetWidth(_VedioImage.frame)-24)/2, (CGRectGetHeight(_VedioImage.frame)-24)/2, 24, 24)];
        _myIndicator.hidesWhenStopped =YES;
        _myIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_VedioImage addSubview:_myIndicator];
        [_myIndicator startAnimating];
        [_backGround addSubview:_VedioImage];
        
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
