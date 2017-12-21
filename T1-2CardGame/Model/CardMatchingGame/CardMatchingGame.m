//
//  CardMatchingGame.m
//  T1-2CardGame
//
//  Created by User on 08/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
// readwrite is implicit, do this only when you declare in header as readonly, and want the setter to be accesed only in private

//call the score setter only in implementation, there is not a public setter for this

@property (nonatomic, strong) NSMutableArray *cards; // of Card

@property (nonatomic, strong) NSAttributedString *display;
@property (nonatomic, strong) NSNumber *matched;

@property (nonatomic) int numberOfMatches;

@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
    
    if(! _cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init]; // self is initialised from NSObject, return nil if failed, is just for verification
    
    if(self){
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            
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

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil; 
}

- (void)setNumberOfMatches:(int)number{
    _numberOfMatches = number;
}


- (NSAttributedString *)getDisplay{
    
    if(! _display){
        _display = [[NSAttributedString alloc] init];
    }
    return _display;
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
    Card *card = [array firstObject];
    int matchScore = [card match:array];
    NSAttributedString *s = [[NSAttributedString alloc] initWithString:@""];
    self.display = s;
    
    self.matched = @0;
    
    if(matchScore){
        self.score +=matchScore * MATCH_BONUS;
        NSMutableAttributedString *matchMesage2 = [[NSMutableAttributedString alloc] initWithString:@"Matched"]; 
        for(Card * eachCard in array){
            eachCard.matched = YES;
            [matchMesage2 appendAttributedString:eachCard.contents];
            [matchMesage2 appendAttributedString: [[NSMutableAttributedString alloc] initWithString:@" "]];

        }
        NSAttributedString *format = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.", matchScore * MATCH_BONUS]];
        
        [matchMesage2 appendAttributedString:format];
        self.display = matchMesage2;
    self.matched = @1;

    }
    else{
        self.score -= MISMATCH_PENALTY;
        for(Card * eachCard in array){
            eachCard.chosen = NO;
        }
        //self.display = [NSString stringWithFormat:@"Cards doesn't match, penalty %d points",MISMATCH_PENALTY];
        self.display = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Cards doesn't match, penalty %d points",MISMATCH_PENALTY]];
        
    }
    
    
    
}
- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:card];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            for(Card *otherCard in self.cards){
                
                if(self.numberOfMatches == 3){
                    for(Card *otherCard2 in self.cards){
                        if(otherCard.isChosen && !otherCard.isMatched && otherCard2.isChosen && !otherCard2.isMatched && ![otherCard isEqual:otherCard2]){
                            
                            [array addObject:otherCard];
                            [array addObject:otherCard2];
                            
                            [self adjustScore:array];
                            break;
                        }
                    }
                }
                else if(self.numberOfMatches == 4){
                    for(Card *otherCard2 in self.cards){
                        for(Card *otherCard3 in self.cards){
                            if(otherCard.isChosen && !otherCard.isMatched && otherCard2.isChosen && !otherCard2.isMatched && otherCard3.isChosen && !otherCard3.isMatched && ![otherCard isEqual:otherCard2] && ![otherCard isEqual:otherCard3] && ![otherCard2 isEqual:otherCard3]){
                                
                                [array addObject:otherCard];
                                [array addObject:otherCard2];
                                [array addObject:otherCard3];
                                
                                [self adjustScore:array];
                                break;
                            }
                        }
                    }
                }
                else{
                    if(otherCard.isChosen && !otherCard.isMatched){
                        [array addObject:otherCard];
                        
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
