//
//  SetGameViewController.m
//  T1-2CardGame
//
//  Created by User on 22/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardMatchingGame.h"
#import "PlayingCardSetDeck.h"
#import "PlayingCardSet.h"
#import "Content.h"
#import "HistoryViewController.h"

@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation SetGameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.game setNumberOfMatches:3];
}

-(Deck *)createDeck{
    return [[PlayingCardSetDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
     return [UIImage imageNamed:card.isChosen ? @"selectedFront" : @"cardFront3"];
}


- (NSAttributedString *)titleForCard:(PlayingCardSet *)card {
    
    return [Content titleForCardSet:card withBackSlash:@"\n"];
}


- (IBAction)touchRedealButton:(UIButton *)sender {
    
    [super touchRedealButton:sender];
    [self.game setNumberOfMatches:3];
   
}



@end
