
/**
 *  @file       DEMSignificantLocation.h
 *  @brief      Model for Location objects in the trip summary gpsTrail.
 *
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */


#import <Foundation/Foundation.h>


@interface DEMSignificantLocation : NSObject    <NSCopying>

/**
 *  @brief  Latitude and longitude information of the GPS point in the format ”lat,long”
 */
@property (nonatomic, strong) NSString * location;

/**
 *  @brief       horizontal accuracy of the location in meters. Lower the value, higher the accuracy.
 *  @deprecated  accuracy
 *  @warning    Deprecated property: Please do not use this as it will be removed in later versions
 */
@property (nonatomic, strong) NSNumber * accuracy DEPRECATED_ATTRIBUTE;
/**
 *  @brief      Horizontal accuracy of the location in meters. Lower the value, higher the accuracy.
 *
 */
@property (nonatomic, strong) NSNumber * horizontalAccuracy ;
/**
 *
 *  @brief  location speed in Mph
*/
 @property (nonatomic, strong) NSNumber * speed;

/**
 *  @brief  Timestamp representing the time that the GPS point was collected.
 */
@property (nonatomic, strong) NSDate *timeStamp;

/**
 *  @brief      Index value for the location in the order in which it is received.
 *  @deprecated serialIndex
 *  @warning    Deprecated property: Please do not use this as it will be removed in later versions
 */
@property (nonatomic, assign) long long serialIndex DEPRECATED_ATTRIBUTE;

/**
 * @brief       Returns a string representation of the location.
 *
 *
 */

@property (nonatomic, strong) NSString * descriptions;
/**
 * @brief       Returns the course of the location in degrees. Negative if course is invalid.
 * @range       0.0 - 359.9 degrees
 *
 */

@property (nonatomic,strong)  NSNumber * course;
/**
 *@brief        Returns the vertical accuracy of the location. Negative if the altitude is invalid. 
 *
 */

@property (nonatomic,strong)  NSNumber * verticalAccuracy;
/**
 * @brief        Returns the altitude of the location. Can be positive or negative.
 *
 *
 */

@property (nonatomic,strong)  NSNumber * altitude;

@end
