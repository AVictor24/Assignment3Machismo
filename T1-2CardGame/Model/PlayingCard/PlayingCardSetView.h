//
//  PlayingCardSetView.h
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardView.h"
#import <QuartzCore/QuartzCore.h>

@interface PlayingCardSetView : CardView

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger rank;

+ (NSUInteger) maxRank;
+ (NSArray *)validShape;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

@end
