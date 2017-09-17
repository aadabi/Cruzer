
/**
 *  @file       DEMDrivingEngineDelegate.h
 *  @brief      This is delegate for Driving engine manager.Driving engine delivers its outputs through 
                this delegate class
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#import "DEMDrivingEngineManager.h"
#import "DEMEventInfo.h"
#import <Foundation/Foundation.h>


@class DEMTripInfo;
@class DEMError;

@protocol DEMDrivingEngineDelegate <NSObject>

@required


/**
 *	@brief  Engine starts trip recording.
 *
 *  @details
 *             Invoked when the engine detects the start of a trip and begins trip recording.
 *  @note      Implementation of this method is required.
 *  @param     drivingEngine- Instance of DEMDrivingEngineManager at the start of trip.
 *  @return    Should return a unique tripID with length= 40 characters, else SDK would internally generate a unique tripID
 */
- (NSString *)didStartTripRecording:(DEMDrivingEngineManager *)drivingEngine;


/**
 *	@brief      Stops ongoing trip recording.
 *
 *  @details
 *              Invoked when the engine detects the end of a trip and stops trip recording.
 *  @note       Implementation of this method is required.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager at the stop of trip
 */
- (void)didStopTripRecording:(DEMDrivingEngineManager *)drivingEngine;


/**
 *	@brief      Invoked every 5 miles during trip recording
 *
 *  @details
 *              Invoked every 5 miles during trip recording and at the end of a trip.
                App layer can check the 'driveCompletionFlag' for checking drive ended or not.
 *  @note       Implementation of this method is required.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @param      trip  - Trip information at this time
 *  @param      driveCompletionFlag – YES if the trip is completed else NO
 */


- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
didSaveTripInformation:(DEMTripInfo *)trip
          driveStatus:(BOOL)driveCompletionFlag;

/**
 *
 *  @brief       Callback method for invalid trip recorded.
 *  @details     Invoked when the engine detects the end of a invalid trip and stops trip recording.
 *  @note        Implementation of this method is required.
 *  @param       drivingEngine- Instance of DEMDrivingEngineManager
 */
- (void)didStopInvalidTripRecording:(DEMDrivingEngineManager *)drivingEngine;

@optional

/**
 *  @brief      Engine starts trip recording.
 *  @details    Invoked when the engine detects the start of a trip and begins trip recording.
 *  @note       Implementation of this method is optional.
 *  @param      tripInfo - Instance of DEMTripInfo at the start of trip.
 */
- (void)didStartTripRecordingWithTripInfo:(DEMTripInfo *)tripInfo;

/**
 *	@brief      Callback when engine detects braking.
 *  @details    This callback is invoked when engine records a  braking event detected during the trip.
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @param      brakingEvent – Information of the braking event
 *
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
     didDetectBraking:(DEMEventInfo*)brakingEvent;

/**
 *	@brief       Callback when engine detects incoming phone call
 *
 *  @details    The method gets a callback when user gets a phone call when in a trip
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine - Instance of DEMDrivingEngineManager
 *  @param      event - event information
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
    didDetectIncomingPhoneCall:(DEMEventInfo*)event;

/**
 *	@brief      Callback when engine detects disconnected phone call
 *  @details    The method gets a callback when the phone call is disconnected during the trip
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine - Instance of DEMDrivingEngineManager
 *  @param      event – event information
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
didDetectDisconnectedPhoneCall:(DEMEventInfo*)event;

/**
 *	@brief      Callback when engine detects acceleration.
 *  @details     This callback is invoked when engine records a acceleration event detected during the 
                trip.
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine - Instance of DEMDrivingEngineManager
 *  @param      accelerationEvent – Acceleration event info
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
     didDetectAcceleration:(DEMEventInfo*)accelerationEvent;

/**
 *	@brief    Callback when engine detects start of a speeding.
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @param    overSpeedingEvent – Event info at start of speeding.
 *
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
didDetectStartOfSpeeding:(DEMEventInfo *)overSpeedingEvent;

/**
 *	@brief      Callback when engine detects end of a speeding.
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @param      overSpeedingEvent – Event info at end of speeding.
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
didDetectEndOfSpeeding:(DEMEventInfo *)overSpeedingEvent;

/**
 *  @brief      Updates the change in Accuracy level of GPS signal
 *
 *  @details    The possible values are as follows  \n
                                                    DEMGpsAccuracyExcellent \n
                                                    DEMGpsAccuracyFair \n
                                                    DEMGpsAccuracyModerate \n
                                                    DEMGpsAccuracyPoor \n
                                                    DEMGpsAccuracyUnacceptable
 *  @note       Implementation of this method is optional.
 *  @param      level - Returns the GPS accuracy change
 *
 */
- (void)didDetectGpsAccuracyChange:(DEMGpsAccuracy)level;

/**
 *	@brief   Callback when engine detects any error.
 *  @note       Implementation of this method is optional.
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @param    errorInfo – Error related to DEMError object
 */
- (void)drivingEngine:(DEMDrivingEngineManager *)drivingEngine
      didErrorOccur:(DEMError *)errorInfo;

@end
