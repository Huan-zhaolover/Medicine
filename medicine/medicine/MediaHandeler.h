//
//  MediaHandeler.h
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MovieModel;

@interface MediaHandeler : NSObject

@property (nonatomic,copy)void (^shuaxinBlock)();

@property (nonatomic,assign)NSInteger movieListCount;
@property (nonatomic,assign)NSInteger voiveListCount;


+(instancetype)shareMovieData;

-(MovieModel *)getMovieModelAtIndexPath:(NSIndexPath *)indexpath;
-(MovieModel *)getMovieModelAtIndex :(NSInteger )index ;

-(MovieModel *)getVoiceModelAtIndexPath:(NSIndexPath *)indexpath;
-(MovieModel *)getVoiceModelAtIndex :(NSInteger )index ;


-(void)shuxinMovie;
-(void)shuxinVoice;

@end
