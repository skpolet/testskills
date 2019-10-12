//
//  GetCounts+NSArray.m
//  testskills
//
//  Created by Sergey Mikhailov on 12.10.2019.
//  Copyright © 2019 Mikhailov. All rights reserved.
//

#import "GetCounts+NSArray.h"

@implementation NSMutableArray(GetCounts)

-(BOOL)isEqualToConstForDownload{
    if((self.count %20) == 0){
        return true;
    }else{
        return false;
    }
}

@end

