//
//  DestinationMode.m
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//

#import "DestinationMode.h"

@implementation DestinationMode

+(instancetype) initWithName:(NSString*) name desc:(NSString*) desc latitude:(NSString*)latitude longitude:(NSString*)longitude
{
    DestinationMode * mode = [DestinationMode new];
    mode.destinationName = name;
    mode.destinationDesc = desc;
    mode.destinationLatitude = latitude;
    mode.destinationLongitude = longitude;
    
    return mode;
}

@end
