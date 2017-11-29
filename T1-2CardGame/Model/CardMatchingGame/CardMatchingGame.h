//
//  CardMatchingGame.h
//  T1-2CardGame
//
//  Created by User on 08/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)setNumberOfMatches:(int) number;
- (NSAttributedString*)getDisplay;
- (NSNumber*)isMatch;
- (void)setMatch:(NSNumber*) nr;
@property (nonatomic, readonly) NSInteger score;

@end
