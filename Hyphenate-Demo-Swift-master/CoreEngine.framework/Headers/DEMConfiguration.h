
/**
 *  @file       DEMConfiguration.h
 *  @brief      Model for setting configuration values for the engine.
 *
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */


#import <Foundation/Foundation.h>


extern NSString *const  DEMMaximumPermittedSpeedKey;
extern NSString *const  DEMAirPlaneModeDurationKey;
extern NSString *const  DEMAutoStopDurationKey;
extern NSString *const  DEMMinSpeedToBeginTripKey;
extern NSString *const  DEMSpeedLimitKey;
extern NSString *const  DEMMinBatteryLevelWhileChargingKey;
extern NSString *const  DEMMinBatteryLevelWhileUnPluggedKey;
extern NSString *const  DEMMinTripRecordTimeKey;
extern NSString *const  DEMMinTripRecordDistanceKey;
extern NSString *const  DEMDistanceForSavingTripKey;
extern NSString *const  DEMMaxTripRecordingTimeKey;
extern NSString *const  DEMMaxTripRecordingDistanceKey;
extern NSString *const  DEMAutoStopSpeedKey;
extern NSString *const  DEMEnableRawDataCollectionKey;
extern NSString *const  DEMGenerateEngineActivityLogKey;
extern NSString *const  DEMEnableWebServicesKey;
extern NSString *const  DEMCaptureFineLocationKey;
extern NSString *const  DEMBrakingThresholdKey;
extern NSString *const  DEMAccelerationThresholdKey;
extern NSString *const  DEMEnable24HrTimeSlotKey;
extern NSString *const  DEMEnableDeveloperModeKey;
extern NSString *const  DEMEnableBreakingEventSuppressionKey DEPRECATED_ATTRIBUTE;
extern NSString *const  DEMEnableBrakingEventSuppressionKey;
extern NSString *const  DEMEnableAccelerationEventSuppressionKey;
extern NSString *const  DEMSavedDEMConfigurationObjectKey;
extern NSString *const  DEMGpsWarningThresholdKey;

//Default configuration values
extern const double DEMMaxPermittedSpeedDefault;
extern const double DEMAirplaneModeDurationDefault;
extern const double DEMAutoStopDurationDefault;
extern const double DEMMinSpeedToBeginTriDefault;
extern const double DEMMinSpeedDefault;
extern const double DEMSpeedLimitDefault;
extern const double DEMMinBatteryLevelWhileChargingDefault;
extern const double DEMMinBatteryLevelWhileUnPluggedDefault;
extern const double DEMStandardSnoozeDurationDefault;
extern const double DEMMinTripRecordTimeDefault;
extern const double DEMMinTripRecordDistanceDefault;
extern const double DEMMaxAllowedDistanceBetweenLocationUpdateDefault;
extern const double DEMDistanceForSavingLocationDataDefault;
extern const double DEMDistanceForSavingTripDefault;
extern const double DEMMaxTripRecordTimeDefault;
extern const double DEMMaxTripRecordDistanceDefault;
extern const double DEMAutoStopSpeedDefault;
extern const double DEMBrakingThresholdDefault;
extern const double DEMAccelerationThresholdDefault;
extern const int    DEMGpsWarningThresholdDefault;

@interface DEMConfiguration : NSObject

/**
 *  @brief  Max.Speed supported by the engine above which engine will consider ongoing trip as invalid
            trip.
 *
 *  @note
 *          Default value: 200 Mph  \n
 *          Unit: Mph   \n
 *          Condition: maximumPermittedSpeed > speedLimit   \n
 */
@property (nonatomic, assign) double maximumPermittedSpeed;

/**
 *  @brief   Speed value below which engine will trigger automatic trip stop procedure.
 *  @details When the vehicle speed comes below this speed, SDK will trigger the auto stop process and  
             if the speed did not go above this speed continuously for the  “auto stop duration”, trip will be ended.
    
 *  @note
 *          Default value: 20 Mph   \n
            Unit: Mph   \n
            Condition:  0 < autoStopSpeed <= minSpeedToBeginTrip.   \n
 *
 */
@property (nonatomic, assign) double autoStopSpeed;

/**
 *  @brief Speed limit above which engine will detect speeding violation.
 *
 *  @note   Default value: 80 Mph   \n
            Unit: Mph   \n
            Condition: speedLimit > minSpeedToBeginTrip \n
 */
@property (nonatomic, assign) double speedLimit;

/**
 *  @brief  Speed value above which engine will start trip recording.
    @note
            Default value: 20 Mph   \n
            Unit: Mph   \n
            Condition: minSpeedToBeginTrip >= 5Mph  \n
 */
@property (nonatomic, assign) double minSpeedToBeginTrip;

/**
 *  @brief    Duration for which engine speed should be < autoStopSpeed for automatic trip end.
 *  @details  When the vehicle speed is below the “Idle time for triggering trip auto stop” for this    
              duration, then trip will be ended.
              Impact: Increasing this duration may create delay in stopping the trip even when the user
              stopped his car.
              Decreasing this value can cause the trip ending even when the user gets caught up in traffic block for few minutes. So single trip may get split into 2 or more.
 *  @note
            Default value: 1200 Seconds \n
            Unit: Seconds   \n
            Condition: autoStopDuration >= 300 Sec  \n

 */
@property (nonatomic, assign) double autoStopDuration;

/**
 *  @brief  Max. duration for a particular trip above which ongoing trip will be stopped and new trip will start.
 *  @note
            Default value: 43200 Seconds    \n
            Unit: Seconds   \n
            Condition: maxTripRecordingTime > minTripRecordTime \n
 */
@property (nonatomic, assign) double maxTripRecordingTime;

/**
 *  @brief   Min. device battery level required (while charging) by the engine for recording trip.
 *  @details When the mobile is in charging state, battery level should be at least this level for 
             recording the trip. If the battery level is below this value, any ongoing trip recording 
              will be stopped and new trip recording will not be triggered unless the battery level
             reaches this value.
 *  @note
            Default value: 5 %  \n
            Unit: Percentage    \n
            Condition: 0 < minBatteryLevelWhileCharging <= 100  \n
 */

@property (nonatomic, assign) double minBatteryLevelWhileCharging;

/**
 *  @brief    Min. device battery level required (unplugged) by the engine for recording trip.
 *  @details  When the mobile is unplugged from charging state, battery level should be at least this 
              level for recording the trip. If the battery level is below this value, any ongoing trip 
             recording will be stopped and new trip recording will not be triggered unless the battery level
             reaches this value
 *   @note
            Default value: 25 % \n
            Unit: Percentage    \n
            Condition: 0 < minBatteryLevelWhileUnPlugged <= 100 \n
 */
@property (nonatomic, assign) double minBatteryLevelWhileUnPlugged;


/**
 *  @brief  Threshold distance for intermediate trip summary saving.
 *
 *   @note
 *           Default value: 5 Miles \n
 *           Unit: Miles    \n
 *           Condition: 2 <= distanceForSavingTrip <= 10    \n
 */
@property (nonatomic, assign) double distanceForSavingTrip;

/**

 *  @brief    Max. distance for a particular trip above which ongoing trip will be stopped and new trip
              will start.
 *  @details  The maximum trip distance each trip can record. If the user reaches this miles, the 
              current trip will get saved and new trip recording will be started.
 *   @note
 *           Default value: 1000 Miles  \n
 *           Unit: Miles    \n
 *           Condition: maxTripRecordingDistance > minTripRecordDistance    \n
 */

@property (nonatomic, assign) double maxTripRecordingDistance;

/**
 *  @brief  Threshold speed change above which engine detects braking events.
 *
 *   @note
 *           Default value: 3.17398 m/s^2 \n
 *           Unit: m/s^2    \n
 *           Condition: 1 <= brakingThreshold <= 5  \n
 */
@property (nonatomic, assign) double brakingThreshold;

/**
 *  @brief  Threshold speed change above which engine detects acceleration events.
 *
 *  @note
 *           Default value: 3.17398 m/s^2 \n
 *           Unit: m/s^2    \n
 *           Condition: 1 <= accelerationThreshold <= 5  \n
 */
@property (nonatomic, assign) double accelerationThreshold;

/**
 *  @brief     If set to YES, engine will submit the trip summary to ASIX server.
 *  @details   Enables/disables web services.  When disabled, no trip information is cached and no 
               attempt is made to upload to server.
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 */
@property (nonatomic, assign) BOOL enableWebServices;

/**
 *  @brief    If set to YES, engine will generate raw data.
 *  @details  When set to ‘true’ the driving engine will collect raw data and will upload the data in 
              the form of a zip file to the specified ftp server.
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 */
@property (nonatomic, assign) BOOL enableRawDataCollection;

/**
 *  @brief      Represents whether fine location captured is enabled.
 *  @details   if set YES, trip summary gpsTrail will have all the GPS locations without applying any filters (walking points removal, Duration GPS filter).
 *
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 *           info: If set to YES, client app has to process the gpsTrail for plotting the route of the trip.    \n
                   This switch is meant only for testing purpose and not for client usage.\n
 */
@property (nonatomic, assign) BOOL captureFineLocation;

/**
 *  @brief      Represents whether the 24 hr time slot is enabled or diabled.
 *  @details    If set to YES, distance histogram in the trip summary will have distance values in 24 
               time slot. Else, distance values will be added into 5 time slots.
 *
 *   @note
 *           Default value: YES \n
 *           Unit: Boolean  \n
 *  @deprecated  enable24HrTimeSlot
 *  @warning    Deprecated property: This property is deprecated, and will be removed in future release, only 24hr time slot will be supported.

 */
@property (nonatomic, assign) BOOL enable24HrTimeSlot DEPRECATED_ATTRIBUTE;

/**
 * @brief   Used for setting the webservice end point to production or development.
 * @details  When set to ‘true’ (default) the driving engine will upload trip summary information to a 
            non-production backend and persisted data on the device will be stored both in encrypted and 
            unencrypted forms.  This flag must be set to ‘false’ for app store submission.
 *   @note
 *           Default value: YES \n
 *           Unit: Boolean  \n
 */
@property (nonatomic, assign) BOOL enableDeveloperMode;

/**
 *  @brief    Represents whether log files should be generated or not.
 *  @details  if set to YES, EngineLogs will be generated.
 *
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 *   @warning Works only if enableDeveloperMode = YES  \n
 */
@property (nonatomic, assign) BOOL generateEngineActivityLog;

/**
 *  @brief  Max. duration for a airplane trip above which ongoing trip will be stopped and discarded.
 *
 *  @note
 *          Default value: 300 Seconds  \n
 *          Unit: Seconds   \n
 *          Condition: 180 <= airPlaneModeDuration <= 600   \n
 */
@property (nonatomic, assign) double airPlaneModeDuration;

/**
 *  @brief  Threshold trip distance value which determines trip is a valid trip or not.
 *
 *  @note
 *          Default value: 0.186411 (300 meter)  \n
 *          Unit: Miles   \n
 *          Condition: 0.186411 <= minTripRecordDistance < maxTripRecordingDistance   \n
 */
@property (nonatomic, assign) double minTripRecordDistance;

/**
 *  @brief  Threshold trip duration value which determines trip is a valid trip or not.
 *
 *  @note
 *          Default value: 180 Seconds  \n
 *          Unit: Seconds   \n
 *          Condition: 180 <= minTripRecordTime < maxTripRecordingTime   \n
 */
@property (nonatomic, assign) double minTripRecordTime;

/**
 *  @brief  if set to YES, engine will check 10 sec window to filter the breaking event.
 *
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 
 *  @deprecated  enableBreakingEventSuppression
 *  @warning    Deprecated property: Instead use "enableBrakingEventSuppression" property
 
 */
@property (nonatomic, assign) BOOL enableBreakingEventSuppression DEPRECATED_ATTRIBUTE;

/**
 *  @brief  if set to YES, engine will check 10 sec window to filter the braking event.
 *
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 */
@property (nonatomic, assign) BOOL enableBrakingEventSuppression;

/**
 *  @brief  if set to YES, engine will check 10 sec window to filter the acceleration event.
 *
 *   @note
 *           Default value: NO  \n
 *           Unit: Boolean  \n
 */
@property (nonatomic, assign) BOOL enableAccelerationEventSuppression;

/**
 *  @brief  GPS threshold value which engine send warning when GPS signal is not available for the configured time.
 *
 *  @note
 *          Default value: 30 Seconds  \n
 *          Unit: Seconds   \n
 *          Condition: 10 <= gpsWarningThresholdValue <= 60   \n
 */
@property (nonatomic, assign) int gpsWarningThresholdValue;


/**
 *  @brief       To obtain the singleton instance
 *
 *  @details     DEMConfiguration instance should be created just once and it contains default or saved configuration.
 *
 *  @return      Returns an instance of DEMConfiguration class
 */
+ (instancetype)sharedManager;

/**
 *  Reset Configuration to defaults
 *
 *  @brief  Reset all values / configurations for current DEMConfiguration instance.
 */
- (void) resetConfiguration;

@end
