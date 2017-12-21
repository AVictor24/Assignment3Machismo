//
//  DeckView.m
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "DeckView.h"


@interface DeckView()
@property (strong, nonatomic) NSMutableArray *cardsView; // of Card
@end

@implementation DeckView

- (NSMutableArray *)cardsView{
    if(! _cardsView){
        _cardsView = [[NSMutableArray alloc] init];
    }
    return _cardsView;
}

- (void)addCard:(CardView *)card atTop:(BOOL)atTop{
    if(atTop == true){
        [self.cardsView insertObject:card atIndex:0];
    }
    else{
        [self.cardsView addObject:card];
    }
}

- (void)addCard:(CardView *)card{
    [self.cardsView addObject:card];
}

-(CardView *)drawRandomCard{
    CardView *randomCard = nil;
    
    if([self.cardsView count]){
        unsigned index = arc4random() % [self.cardsView count];
        randomCard = self.cardsView[index];
        [self.cardsView removeObjectAtIndex:index];
    }
    else {
        randomCard = nil;
    }
    
    return randomCard;
}

@end
