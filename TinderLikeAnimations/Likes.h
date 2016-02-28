//
//  Likes.h
//  Resumatch
//
//  Created by Mariah Flaim on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Likes : NSObject
@property (nonatomic) NSMutableArray *likes;
+ (Likes *)sharedLikes;
@end
