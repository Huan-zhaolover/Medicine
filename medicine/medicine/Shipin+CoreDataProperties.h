//
//  Shipin+CoreDataProperties.h
//  medicine
//
//  Created by Yutao on 15/11/26.
//  Copyright © 2015年 yutao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Shipin.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shipin (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
