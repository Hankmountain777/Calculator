//
//  CalculatorViewController.m
//  CalculatorProject
//
//  Created by Richard on 2020/7/14.
//  Copyright © 2020 CalculatorProject. All rights reserved.
//

#import "CalculatorViewController.h"
#import "advancedCalculator.h"

@interface CalculatorViewController ()

@property (strong, nonatomic) advancedCalculator *calculate;

@property (weak, nonatomic) IBOutlet UITextField *inputResult;

@property int flag;

@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calculate=[[advancedCalculator alloc]init];
    
}



-(advancedCalculator *)calculator{
    if(!_calculate){
        _calculate=[[advancedCalculator alloc]init];
    }
    return _calculate;
}


/** 基本输入数字和操作符在同一个事件进行处理*/
- (IBAction)touchViewExpression:(UIButton *)sender {
    
    if([self.inputResult.text length]!=0&&_flag==1){
        NSString *ch=[[sender titleLabel] text];
        if([ch isEqualToString:@"("]||[ch isEqualToString:@"×"]
           ||[ch isEqualToString:@"÷"]
           ||[ch isEqualToString:@"+"]
           ||[ch isEqualToString:@"-"]
           ||[ch isEqualToString:@")"]){
            self.inputResult.text=@"暫不支持連續運算";
            self.calculator.input=nil;
            _flag=1;
            return;
        }else{
            self.inputResult.text=nil;
            self.calculator.input=nil;
            _flag=0;
        }
    }
    
    
    //这种处理的原因是对x ÷进行实际运算的替换* /，但显示仍然是x +
    if([[[sender titleLabel] text] isEqualToString:@"×"]){
        [self.calculator.input appendString:@"*"];
    }else if([[[sender titleLabel] text] isEqualToString:@"÷"]){
        [self.calculator.input appendString:@"/"];
    }else{
        [self.calculator.input appendString:[[sender titleLabel] text]];
    }
    NSMutableString *originalString=[NSMutableString stringWithString:self.inputResult.text];
    [originalString appendString:[[sender titleLabel] text]];
    self.inputResult.text=originalString;
    self.calculator.screen=originalString;
}

/** 清空输出框数据以及存储的数据*/
- (IBAction)clearInputExpression:(UIButton *)sender {
    self.inputResult.text=nil;
    [self.calculator clearAll];
    _flag=0;
}


/** 删除输入数字的最后一个字符*/
- (IBAction)deleteExpressionLastNumber:(UIButton *)sender {
    NSInteger length=[self.calculator.input length];
    if(length>0){
        [self.calculator.input deleteCharactersInRange:NSMakeRange(length-1, 1)];
        //一定也要对输入框中的表达式进行处理，因为input里面的× ÷和显示的* /不同
        NSMutableString *delResultString=[NSMutableString stringWithString:self.inputResult.text];
        [delResultString deleteCharactersInRange:NSMakeRange(length-1, 1)];
        NSLog(@"deleteResult=%@",self.calculator.input);
        self.calculator.screen=delResultString;
        self.inputResult.text=delResultString;
    }
}



- (IBAction)x:(id)sender {
    
        self.inputResult.text=[self.calculator cos:self.calculator.input];
        NSMutableString *str=[NSMutableString stringWithString:self.inputResult.text];
        self.calculator.input=str;
        self.calculator.screen=str;
        
    
    
}



/** 核心操作 计算结果*/
- (IBAction)calculateExpression:(UIButton *)sender {
    //标志为1，表明已经按了=键，计算了结果，下次再输入其他表达式会先清空数据
    _flag=1;
    if([self.inputResult.text length]==0){
        self.inputResult.text=@"Error input!";
        return;
    }
    
    NSMutableString *calculateResult=[NSMutableString stringWithString:self.calculator.input];
    [calculateResult appendString:[[sender titleLabel] text]];
    self.inputResult.text=[self.calculator ExpressionCalculate:calculateResult];
    NSMutableString *tempStr=[NSMutableString stringWithString:self.inputResult.text];;
    self.calculator.screen = tempStr;//每次计算之后，将结果也保存在screen中
}



- (IBAction)goback:(id)sender {
    
    NSLog(@"backAction");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)onClickAC:(id)sender
{
    // Reset to Default
    // ...
    self.inputResult.text = @"";
}


-(void)viewWillAppear:(BOOL)animated{
    //将视图刚要显示的时候，将传递过来的内容在屏幕中显示
    self.inputResult.text=self.calculator.screen;
}

@end
