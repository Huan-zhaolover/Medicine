//
//  newsCell.m
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "newsCell.h"
#import "UIImageView+WebCache.h"
#import "newsModel.h"
@interface newsCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *updataTimelable;

@end

@implementation newsCell

-(void)setNewsmodel:(newsModel *)newsmodel{
    if (_newsmodel!=newsmodel) {
        _newsmodel=nil;
        _newsmodel=newsmodel;
        [self setContenView];
    }
   
}


-(void)setContenView{

    [self.thumImage sd_setImageWithURL:[NSURL URLWithString:self.newsmodel.thumb]];
    
    self.titleLable.text=self.newsmodel.title;
    self.decriptionLable.text=self.newsmodel.n_description;
    NSInteger year=1970+ [self.newsmodel.updatetime integerValue]/(3600*24*365);
    NSInteger month= [self.newsmodel.updatetime integerValue] %(3600*24*365)/(30*3600*24);
    NSInteger day= [self.newsmodel.updatetime integerValue] %(30*3600*24)/(3600*24);
    self.updataTimelable.text=[NSString stringWithFormat:@"%ld-%ld-%ld",year, month,day];

}

//-(void)dealloc{
//    _newsmodel.thumb=nil;
//    _newsmodel.n_description=nil;
//    _newsmodel.updatetime=0;
//    _newsmodel.title=nil;
//
//}
- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
