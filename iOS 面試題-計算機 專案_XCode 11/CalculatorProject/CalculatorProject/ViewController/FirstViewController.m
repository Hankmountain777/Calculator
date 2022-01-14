//
//  FirstViewController.m
//  CalculatorProject
//
//  Created by Richard on 2020/7/14.
//  Copyright © 2020 CalculatorProject. All rights reserved.
//

#import "FirstViewController.h"
#import "CalculatorViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)toCalculator:(id)sender {
    
    
    
    Class vcClass = CalculatorViewController.class;
    CalculatorViewController *vc = [[vcClass alloc] init];

    [vc setModalPresentationStyle:UIModalPresentationFullScreen];

    [self presentViewController:vc animated:YES completion:nil];
    
    
    
    
}

@end
