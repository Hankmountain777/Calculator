//
//  Stack.h
//  CalculatorProject
//
//  Created by GSK on 2022/1/11.
//  Copyright © 2022 CalculatorProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property(nonatomic, readonly) NSString *Top;
@property(nonatomic) NSUInteger Stacksize;
@property(nonatomic, readonly) NSMutableArray *stackArray;
@property(nonatomic, readonly) NSString *popElement;

-(instancetype)initWithStacksize:(NSUInteger)Stacksize;//designated initializer

-(BOOL)push:(NSString *)element stack:(Stack *)stack;

-(NSString *)pop:(Stack *)stack;

-(NSString *)getTop:(Stack *)stack;



@end
