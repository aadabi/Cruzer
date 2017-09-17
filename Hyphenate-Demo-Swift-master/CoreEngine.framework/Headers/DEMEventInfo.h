
/**
 *  @file       DEMEventInfo.h
 *  @brief      Model class for an event.
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>


/**
 *  @memberof   DEMEventInfo
 *  @brief      Different types of Events supported.
 */
typedef NS_ENUM(int, EventType ) {
    /**
     *  EventBraking      - The event type is Braking
     */
    EventBraking  = 1,
    /**
     *  EventAcceleration - The event type is Acceleration
     */
    EventAcceleration,
    /**
     *  EventSpeeding     -  The event type is Speeding
     */
    EventSpeeding
};

@interface DEMEventInfo : NSObject  <NSCopying>

/**
 *
 *  @brief    An integer that identifies what sensor was responsible for the data that was generated during the event. The only valid value at this time is 0 referring to the GPS sensor on the device.
 *
 */
@property (nonatomic,assign) int sensorType;
/**
 *
 *  @brief    A string that contains the unique identifier of a trip for which the event has occurred.
 */
@property (nonatomic,strong) NSString* tripID;

/**
 *
 *  @brief   Represents the strength of the GPS when the event occurred.
 */
@property (nonatomic,assign) int gpsStrength;

/**
 *
 *  @brief   Reflects the speed of the vehicle at the time of the event. Unit is miles per hour.
 */
@property (nonatomic,assign) float sampleSpeed;

/**
 *
 *  @brief   The sensor reading at the start of a collection of data points that resulted in an
                  event.
 *  @note         For example, a braking event is the result of a rapid reduction of speed.  This
                  property  would represent the starting value that was used to detect this drop in
                  speed.
 */
@property (nonatomic,assign) double sensorStartReading;

/**
 *
 *  @brief        The sensor reading at the end of a collection of data points that resulted in an
                   event.
 *
 *  @note         For example, a braking event is the result of a rapid reduction of speed.  This
                  property would represent the ending value that was used to detect this drop in speed.
 *
 */
@property (nonatomic,assign) double sensorEndReading;
/**
 *
 *  @brief        The delta between ‘sensorStartReading’ and ‘sensorEndReading’ in the case of a speed
                  oriented event such as braking or acceleration.  Unit is miles per hour.
 */
@property (nonatomic,assign) double speedChange;
/**
 *
 *  @brief      The miles driven on a trip that this event occurred on.
 */
@property (nonatomic,assign) double milesDriven;
/**
 *
 *  @brief        An NSDate object that represents the date and time of the end of a collection of data
                  points that resulted in an event.
 */
@property (nonatomic,strong) NSDate* eventEndTime;
/**
 *
 *  @brief        An NSDate object that represents the date and time of the start of a collection of  
                  datapoints that resulted in an event.
 */
@property (nonatomic,strong) NSDate* eventStartTime;
/**
 *
 *  @brief       String contains the GPS co-ordinate of the location start data point of an event.
 */
@property (nonatomic,strong) NSString* eventStartLocation;
/**
 *
 *  @brief       String contains the GPS co-ordinate of the location end data point of an event.
 */
@property (nonatomic,strong) NSString* eventEndLocation;
/**
 *
 *  @brief       An NSTimeInterval object that contains the time interval between start and end data 
                points that were used to generate an event. Unit is seconds.
 */
@property (nonatomic,assign) NSTimeInterval eventDuration;
/**
 *  @brief       Identifies the type of an event
 *  @details     The type of events the coreEngine returns are as follows\n
                 EventBraking  \n
                 EventAcceleration \n
                 EventSpeeding
 *
 */
@property (nonatomic,assign) EventType eventType;


@end
