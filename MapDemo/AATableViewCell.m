//
//  AATableViewCell.m
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//

#import "AATableViewCell.h"

@implementation AATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 350, 50)];
    label.text = @"xxxxx";
    [self addSubview:label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
