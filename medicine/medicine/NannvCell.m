//
//  NannvCell.m
//  medicine
//
//  Created by Yutao on 15/11/25.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "NannvCell.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
@interface NannvCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *summaryLable;

@end

@implementation NannvCell

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
    self.summaryLable.text=self.model.summary;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
