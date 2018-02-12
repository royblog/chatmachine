//
//  TextSelfTableViewCell.m
//  XiaoAiChat
//
//  Created by wangyaoguo on 2018/2/12.
//  Copyright © 2018年 lianluo.com. All rights reserved.
//

#import "TextSelfTableViewCell.h"

@implementation TextSelfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textBg.layer.cornerRadius = 6;
    _textBg.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
