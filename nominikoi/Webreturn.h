//
//  Webreturn.h
//  nominikoi
//
//  Created by ビザンコムマック０７ on 2014/10/10.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Webreturn : NSObject
+(NSArray*)JSONArrayData:(NSString*)url;
+(NSData*)webdata:(NSString*)url;
+(NSDictionary*)JSONDictinaryData:(NSString*)url;
+(NSData*)ServerData:(NSString*)url;
+(UIImage*)WebImage:(NSString*)url;
@end
