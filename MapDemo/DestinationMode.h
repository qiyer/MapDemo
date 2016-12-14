//
//  DestinationMode.h
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationMode : NSObject

@property(nonatomic,copy) NSString * destinationName;
@property(nonatomic,copy) NSString * destinationDesc;
@property(nonatomic,copy) NSString * destinationLatitude;
@property(nonatomic,copy) NSString * destinationLongitude;

+(instancetype) initWithName:(NSString*) name desc:(NSString*) desc latitude:(NSString*)latitude longitude:(NSString*)longitude;

@end
