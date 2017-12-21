//
//  ViewController.h
//  T1-2CardGame
//
//  Created by User on 02/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberOfMatches;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViews;
@property (nonatomic,strong) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableAttributedString *historyText; 


//protected
//for subclasses
- (Deck *)createDeck; //abstract
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSAttributedString *)titleForCard:(Card *)card;
- (IBAction)touchRedealButton:(UIButton *)sender;
@end

