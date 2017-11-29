//
//  CardGameViewController.m
//  T1-2CardGame
//
//  Created by User on 22/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController



-(Deck *)createDeck{
    
  
   
    /*
    UITextView *symbol = [self setShapeAndColor:@"▲" color:[UIColor purpleColor]];
    [symbol setFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:symbol];
     */
    
    
    
    return [[PlayingCardDeck alloc] init];
    
}

@end
