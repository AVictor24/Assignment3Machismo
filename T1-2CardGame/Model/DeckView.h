//
//  DeckView.h
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardView.h"

@interface DeckView : NSObject

- (void)addCard: (CardView *)card atTop:(BOOL)atTop;
- (void)addCard: (CardView *)card;

- (CardView *)drawRandomCard;

@end
