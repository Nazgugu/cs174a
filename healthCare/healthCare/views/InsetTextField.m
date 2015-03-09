//
//  InsetTextField.m
//  healthCare
//
//  Created by Liu Zhe on 3/9/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "InsetTextField.h"

@implementation InsetTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 15, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 15, 0);
}


@end
