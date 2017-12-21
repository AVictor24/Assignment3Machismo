//
//  PlayingCardSetViewDeck.m
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "PlayingCardSetViewDeck.h"
#import "PlayingCardSetView.h"
#import "Draw.h"

@implementation PlayingCardSetViewDeck

-(instancetype)init{
    
    self = [super init];

    
    if(self){
        for(NSString *shape in [PlayingCardSetView validShape]){
            for(NSUInteger rank =1; rank <= [PlayingCardSetView maxRank]; rank++){
                for(NSString *shade in [PlayingCardSetView validShades]){
                    for(NSString *color in [PlayingCardSetView validColors]){
                        Draw *card = [[Draw alloc] init];
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
