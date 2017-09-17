
/**
 *  @file       DEMTripInfo.h
 *  @brief      Trip summary model class information.
 *
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights
 *reserved.
 */
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface DEMTripInfo : NSObject <NSCopying>

/**
 *  @brief  Unique identifier of the trip
 *  @note   The trip ID which gets generated will be unique to the particular trip and it is created only once during a trip
 */
@property(nonatomic, strong) NSString *tripID;

/**
 *  @brief  The battery level at which engine start the trip. The value will be ranging between 0 to 1
 */
@property(nonatomic, assign) float startBatteryLevel;
/**
 *  @brief The battery level at which engine stop the trip. The value will be ranging between 0 to 1
 */
@property(nonatomic, assign) float endBatteryLevel;

/**
 *  @brief  Comma seperated location lattitude and longitude string where the
 * trip started.
 */
@property(nonatomic, strong) NSString *startLocation;

/**
 *  @brief      Comma seperated location lattitude and longitude string where the
                trip ended.
 */
@property(nonatomic, strong) NSString *endLocation;

/**
 *  @brief     The time at which the trip  started.
 */
@property(nonatomic, strong) NSDate *startTime;

/**
 *  @brief      The time at which the trip  ended.
 */
@property(nonatomic, strong) NSDate *endTime;

/**
 *  @brief      The time at which engine ignored the ongoing trip.

 *  @details    Contain value only if ignoreCurrentTrip API method of Engine is
                called while trip is recording.
 */
@property(nonatomic, strong) NSDate *tripIgnoreTime;

/**
 *  @brief     Total distance covered during the trip in Miles
 */
@property(nonatomic, assign) float distanceCovered;

/**
 *  @brief      Total duration of the trip in Seconds
 */
@property(nonatomic, assign) NSTimeInterval duration;

/**
 *  @brief      Average speed of the trip in Mph
 */
@property(nonatomic, assign) float averageSpeed;

/**
 *  @brief      Maximum speed attained during the trip in Mph
 */
@property(nonatomic, assign) float maximumSpeed;

/**
 *  @brief       Array of DEMEventInfo objects.
 *  @details     Each eventInfo object represents a
                 particular event\n speeding,\n braking,\n acceleration
 */
@property(nonatomic, strong) NSMutableArray *eventList;

/**
 *  @brief     Represents trip stop identifier
*   @details   Possible termination IDs\n auto = 0\n system = 1 \n manual = 2
 */
@property(nonatomic, assign) int terminationId;

/**
 *  @brief  Count of speeding events commited during the trip
 */
@property(nonatomic, assign) NSInteger speedingCount;

/**
 *  @brief  Count of braking events commited during the trip
 */
@property(nonatomic, assign) NSInteger brakingCount;

/**
 *  @brief  Count of acceleration events commited during the trip
 */
@property(nonatomic, assign) NSInteger accelerationCount;

/**
 *  @brief Detailed reason for trip end
 
    @details Actual reason for termination of the trip with following possible reasons
 *           Battery low,\n
 *           Location service disabled,\n
 *           User quit application,\n
 *           Automatic trip end,\n
 *           GPS signal lost for 25 Miles,\n
 *           System time interrupted,\n
 *           Application low memory,\n
 *           GPS signal lost for 20 minutes,\n
 *           Engine is suspended,\n
 *           Application background app refresh is OFF,\n
 *           Max. trip criteria reached (12 hrs/1000 Miles),\n
 *           Engine in sleep mode (Not used currently),\n
 *           Manaul trip stop,\n
 *           Airplane trip
 */
@property(nonatomic, assign) int terminationType;

/**
 *  @brief       Duration for which vehicle is in idle state during trip recording.
 *  @details     Speed < 5 MPH is considered as idle state.  Unit is in seconds.
 */
@property(nonatomic, assign) NSTimeInterval idleTime;

/**
 *  @brief        Array of GPS trails with location details in fixed intervals from a trip.
 *
 *  @details      Use this for plotting the route of the trip
 *
 */
@property(nonatomic, strong) NSMutableArray *gpsTrailArray;

/**
 *  @brief      Distance travelled while speeding. Unit is in meters.
 */
@property(nonatomic, assign) float mileageWhileSpeeding;

/**
 *  @brief          Array of distance values travelled for different time slots.
 *
 *  @note       If enable24HrFormat is set to YES for the engine configuration,
                   it will have 24 distance values, else 5 time slot values will be present.
 *
 *
 */
@property(nonatomic, strong) NSArray *timeSlots;

/**
 *  @brief        Trip Rejection Reason , represents whether the trip is ignored or not.
 *  @details      Trip Rejection reasons could be as follows\n 0 = Normal trip \n
                                                             1 = Trip is ignored
 */
@property(nonatomic, strong) NSString *tripRejectionReason;

/**
 *  @brief       Array of duration value in seconds. Each value represents the
                time duration travellled within a particular speed range.
 *
 *  @note       There are 15 speed range values in Mph :    \n
                0 - 10, 10 - 20, 20 - 30, 30 - 40, 40 - 50, 50 - 55, 55 - 60, 60 - 65, 65 - 70,
                70 - 75, 75 - 80, 80 - 85, 85 - 90, 90 - 120, > 120
 *
 */
@property(nonatomic, strong) NSArray *speedHistogram;

/**
 *  @brief          Array of duration value in seconds. Each value represents the
                  time duration of braking for a particular decceleration change.
 *  @note     There are 11 decceleration range values in Mph :    \n
                    0.1 - 1, 1 - 2, 2 - 3, 3 - 4, 4 - 5, 5 - 6, 6 - 7, 7 - 8, 8 - 9, 9 - 10, >= 10
 */
@property(nonatomic, strong) NSArray *brakeHistogram;

/**
 *  @brief          Array of braking count.Each value represents the count of
                   braking for a particular decceleration change.
 *
 *  @details      There are 6 decceleration range values in Mph : \n
                    6 - 7, 7 - 8, 8 - 9, 9 - 10, 10 - 17, >= 17
 *
 */
@property(nonatomic, strong) NSArray *brakeEventsHistogram;

/**
 *  @brief              Array of duration value in seconds. Each value represents
                     the time duration of acceleration events for a particular acceleration change.
 *  @note         There are 11 acceleration range values in Mph : \n
                        0.1 - 1, 1 - 2, 2 - 3, 3 - 4, 4 - 5, 5 - 6, 6 - 7, 7 -
                       8, 8 - 9, 9 - 10, >= 10
 */
@property(nonatomic, strong) NSArray *accelerationHistogram;

/**
 *  @brief          Array of acceleration count. Each value represents the count
                    of acceleration events for a particular acceleration change.
 *
 *  @note     There are 6 acceleration range values in Mph :  \n
                    6 - 7, 7 - 8, 8 - 9, 9 - 10, 10 - 17, >= 17
 *
 */
@property(nonatomic, strong) NSArray *accelerationEventsHistogram;

/**
 *  @brief          Extra (Optional) data about the trip which can be added as part of trip Summary json.
 *  @note           The maximum length of the metadata string should be within 4096 characters.
 */
@property(nonatomic, strong) NSString *metaData;
/**
 * @brief           Any reference data related to the trip.
 * @note            This can be used by upstream applications to correlate with trip data.
 *
*/
@property (nonatomic, strong,readonly) NSString *referenceData;

@end
