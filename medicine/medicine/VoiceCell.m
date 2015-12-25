//
//  VoiceCell.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "VoiceCell.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
@interface VoiceCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *summarLable;

@end

@implementation VoiceCell


-(void)setModel:(MovieModel *)model{
    if (_model!=model) {
        _model=nil;
        _model=model;
        [self setView];
    }
    
}
-(void)setView{
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.model.icon_url]];
    self.titleLable.text=self.model.title;
    self.summarLable.text=  [self.model.summary substringToIndex:15]  ;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
