//
//  PlayingCardSetDeck.m
//  T1-2CardGame
//
//  Created by User on 23/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "PlayingCardSetDeck.h"
#import "PlayingCardSet.h"

@implementation PlayingCardSetDeck

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        for(NSString *shape in [PlayingCardSet validShape]){
            for(NSUInteger rank =1; rank <= [PlayingCardSet maxRank]; rank++){
                for(NSString *shade in [PlayingCardSet validShades]){
                    for(NSString *color in [PlayingCardSet validColors]){
                        PlayingCardSet *card = [[PlayingCardSet alloc] init];
                        card.rank = rank;
                        card.shape = shape;
                        card.color = color;
                        card.shading = shade;
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    
    
    return self;
}

@end
