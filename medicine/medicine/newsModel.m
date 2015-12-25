//
//  newsModel.m
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "newsModel.h"

@implementation newsModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        _n_description=value;
    }
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
