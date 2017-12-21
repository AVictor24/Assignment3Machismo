//
//  ViewController.m
//  T1-2CardGame
//
//  Created by User on 02/11/2017.
//  Copyright © 2017 User. All rights reserved.
//


#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
@interface ViewController ()





@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;




@end


@implementation ViewController

/*
 @synthesize numberOfMatches;
 - (BOOL)textFieldShouldReturn:(UITextField *)textField{
 return YES;
 }
 */

-(void)createViews{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.numberOfMatches.delegate = self;
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    //self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count] usingDeck:[self createDeck]];
    
    self.historyText = [[NSMutableAttributedString alloc]initWithString:@""];
    
    [self updateUI];
}

- (Deck *)createDeck{ //abstract
    //return [[PlayingCardDeck alloc] init];
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)touchSegmentButton:(UISegmentedControl *)sender {
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [self.game setNumberOfMatches:2];
            break;
        case 1:
            [self.game setNumberOfMatches:3];
            break;
        case 2:
            [self.game setNumberOfMatches:4];
            break;
            
        default:
            break;
    }
}
- (IBAction)touchRedealButton:(UIButton *)sender {
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    //self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count] usingDeck:[self createDeck]];
    [self updateUI];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.enabled = true;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    self.segmentControl.enabled = false;
    [self updateUI];
}

/*  ^^
 //add gestures
 - (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
 
 self.playingCardView.faceUp = !self.playingCardView.faceUp;
 }
 */

- (void)updateUI{
    
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        cardButton.titleLabel.numberOfLines = 0;
        cardButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        //self.infoLabel.text = [self.game getDisplay];
        self.infoLabel.attributedText = [self.game getDisplay];

       
    }
    
    /*
    for(UIView *cardView in self.cardViews){
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        //[cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        //[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        //cardView.enabled = !card.faceUp;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.infoLabel.attributedText = [self.game getDisplay];
    }
     */
    
    
}

- (NSAttributedString *)titleForCard:(Card *)card{
    NSAttributedString *content = [[NSAttributedString alloc] initWithAttributedString:card.contents];
    
    if(card.isChosen){
        return content;
    }
    
    return [[NSAttributedString alloc] initWithString:@""];
    
  // return [[NSAttributedString alloc] initWithAttributedString:card.isChosen ? card.contents :@""];  // return content otherwise reuturn ""
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"selectedFront" : @"lights"];
}

@end









