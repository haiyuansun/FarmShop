//
//  NSString+Extension.m
//  loveFreshPeak
//
//  Created by ArJun on 16/7/30.
//  Copyright © 2016年 阿俊. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)cleanDecimalPointZear {
    
    NSInteger offset = self.length - 1;
    
    while (offset > 0) {
        NSString *s = [self substringWithRange:NSMakeRange(offset, 1)];
        
        
        if ([s isEqualToString:@"0"] || [s isEqualToString:@"."] ) {
            offset--;
        }else{
            break;
        }
    }
    return [self substringToIndex:offset + 1];
}
-(NSString *)stringToDoubleDecimal{

    NSUInteger loc = [self rangeOfString:@"."].location + 1;

    NSString *string;
    if (self.length > loc + 2) {
        string = [self substringToIndex: loc + 2];
    }else{
        string = self;
    }
    return string;
}
@end
