//
//  HistoryViewController.m
//  T1-2CardGame
//
//  Created by User on 24/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
    NSMutableAttributedString *msg1 = [[NSMutableAttributedString alloc] initWithString:self.textView.text];

    NSAttributedString *bck = [[NSAttributedString alloc] initWithString:@"\n"];
    
    
    [msg1 appendAttributedString:bck];
    
    [msg1 appendAttributedString:self.textToAnalyze];
     */
    
    //[matchMesage2 appendAttributedString:eachCard.contents];
    self.textView.attributedText = self.textToAnalyze;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
