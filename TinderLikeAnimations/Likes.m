//
//  Likes.m
//  Resumatch
//
//  Created by Mariah Flaim on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import "Likes.h"

@implementation Likes
+ (Likes *)sharedLikes
{
    static dispatch_once_t once;
    static id sharedLikes;
    dispatch_once(&once, ^{
        sharedLikes = [[self alloc] init];
    });
    return sharedLikes;
}

@end
