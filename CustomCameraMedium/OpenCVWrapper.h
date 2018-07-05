//
//  OpenCVWrapper.h
//  ibl360
//
//  Created by Daniel Harkness on 30/11/2015.
//  Copyright © 2015 Daniel Harkness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+ (UIImage*) processHDRWithImageArray:(NSArray*)imageArray timeArray:(NSArray*)timeArray;

@end
