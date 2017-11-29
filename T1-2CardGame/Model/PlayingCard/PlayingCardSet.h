//
//  PlayingCardSet.h
//  T1-2CardGame
//
//  Created by User on 23/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "Card.h"


@interface PlayingCardSet : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger rank;

+ (NSUInteger) maxRank;
+ (NSArray *)validShape;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
@end
