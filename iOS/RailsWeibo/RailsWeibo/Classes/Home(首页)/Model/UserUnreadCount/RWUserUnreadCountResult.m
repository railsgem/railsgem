//
//  RWUserUnreadCountResult.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWUserUnreadCountResult.h"

@implementation RWUserUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}
@end
