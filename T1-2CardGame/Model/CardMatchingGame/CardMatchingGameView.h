//
//  CardMatchingGameView.h
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeckView.h"
#import "PlayingCardSetView.h"
#import "Draw.h"

@interface CardMatchingGameView : NSObject\


//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(DeckView *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (PlayingCardSetView *)cardAtIndex:(NSUInteger)index;
- (void)setNumberOfMatches:(int) number;
- (NSNumber*)isMatch;
- (void)setMatch:(NSNumber*) nr;
-(void)chooseCard:(Draw *)card;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end
