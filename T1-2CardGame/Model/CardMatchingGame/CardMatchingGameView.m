//
//  CardMatchingGameView.m
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "CardMatchingGameView.h"
#import "Draw.h"

@interface CardMatchingGameView()
@property (nonatomic, readwrite) NSInteger score;
// readwrite is implicit, do this only when you declare in header as readonly, and want the setter to be accesed only in private

//call the score setter only in implementation, there is not a public setter for this



@property (nonatomic, strong) NSNumber *matched;

@property (nonatomic) int numberOfMatches;

@end

@implementation CardMatchingGameView


- (NSMutableArray *) cards{
    
    if(! _cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(DeckView *)deck{
    
    self = [super init]; // self is initialised from NSObject, return nil if failed, is just for verification
    
    if(self){
        for(int i = 0; i < count; i++){
            CardView *card = [deck drawRandomCard];
            
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (PlayingCardSetView *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)setNumberOfMatches:(int)number{
    _numberOfMatches = number;
}



- (NSNumber*)isMatch{
    if(! _matched){
        _matched = [[NSNumber alloc] init];
    }
    return _matched;
}

- (void)setMatch:(NSNumber*) nr{
    _matched = nr;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)adjustScore:(NSArray *) array{
    //CardView *card = [array firstObject];
    PlayingCardSetView *card = [array firstObject];
    int matchScore = [card match:array];
    
    if(matchScore){
        self.score += 2* (matchScore * MATCH_BONUS);
        
        for(CardView * eachCard in array){
            eachCard.matched = YES;
        }

    }
    else{
        self.score -= MISMATCH_PENALTY;
        for(CardView * eachCard in array){
            eachCard.chosen = NO;
        }
    }
}

-(void)chooseCard:(Draw *)card{
    NSUInteger index = [self.cards indexOfObject:card];
    
    [self chooseCardAtIndex:index];
}


- (void)chooseCardAtIndex:(NSUInteger)index{
    CardView *card = [self cardAtIndex:index];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:card];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{ //for3
            for(CardView *otherCard in self.cards){
                
                for(CardView *otherCard2 in self.cards){
                    if(otherCard.isChosen && !otherCard.isMatched && otherCard2.isChosen && !otherCard2.isMatched && ![otherCard isEqual:otherCard2]){
                        
                        [array addObject:otherCard];
                        [array addObject:otherCard2];
                        
                        [self adjustScore:array];
                        break;
                    }
                }
                
            }
            
            [array removeAllObjects];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    }
}

@end
