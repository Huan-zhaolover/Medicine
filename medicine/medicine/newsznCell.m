//
//  newsznCell.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "newsznCell.h"
#import "newsznModel.h"
#import "UIImageView+WebCache.h"
@interface newsznCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *dateTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@end


@implementation newsznCell

-(void)setZnmodel:(newsznModel *)znmodel{
    if (_znmodel!=znmodel) {
        _znmodel=nil;
        _znmodel=znmodel;
        [self setContentView];
    }

}
-(void)setContentView{

    [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.znmodel.imgpath]];
    self.dateTimeLable.text=[self.znmodel.articleDate substringToIndex:11];
    self.titleLable.text=self.znmodel.title;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
