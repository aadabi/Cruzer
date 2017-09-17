
/**
 *  @file       DEMEngine.h
 *  @brief      This file holds all enums and other important info.
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#ifndef DEMEngine_h
#define DEMEngine_h

/**
 *  @memberof   DEMDrivingEngineManager
    @brief      List of event subscriptions supported by CoreEngine SDK.
 * 
 */
typedef NS_OPTIONS(NSUInteger, DEMEventCaptureMask) {
    /**
     *  @brief DEMEventCaptureRecordingStarted - Event subscription for Recording Started.
     */
    DEMEventCaptureRecordingStarted        =(1 << 0), //... 000000001
    /**
     *  @brief DEMEventCaptureRecordingStopped - Event subscription for Recording Stopped.
     */
    DEMEventCaptureRecordingStopped        =(1 << 1), //... 000000010
    /**
     *  @brief DEMEventCaptureTripInfoSaved - Event subscription for Trip Info Saved.
     */
    DEMEventCaptureTripInfoSaved           =(1 << 2),
    /**
     *  @brief DEMEventCaptureInvalidRecordingStopped - Event subscription for Invalid Recording 
                                                        Stopped.
     */
    DEMEventCaptureInvalidRecordingStopped =(1 << 3),
    /**
     *  @brief DEMEventCaptureBrakingDetected -Event subscription for braking detected.
     */
    DEMEventCaptureBrakingDetected         =(1 << 4),
    /**
     *  @brief DEMEventCaptureAccelerationDetected - Event subscription for Acceleration Detected.
     */
    DEMEventCaptureAccelerationDetected    =(1 << 5),
    /**
     *  @brief DEMEventCaptureStartOfSpeedingDetected - Event subscription for start of Speeding detected.
     */
    DEMEventCaptureStartOfSpeedingDetected =(1 << 6),
    /**
     *  @brief DEMEventCaptureEndOfSpeedingDetected - Event subscription for end of Speeding detected.
     */
    DEMEventCaptureEndOfSpeedingDetected   =(1 << 7),
    /**
     *  @brief DEMEventCapturePhoneCallIncoming - Event subscription for Incoming phone call.
     */
    DEMEventCapturePhoneCallIncoming       =(1 << 8),
    /**
     *  @brief DEMEventCapturePhoneCallDisconnected - Event subscription for Phone call disconnected.
     */
    DEMEventCapturePhoneCallDisconnected   =(1 << 9),
    /**
     *  @brief DEMEventCaptureGpsAccuracyChange - Event subscription for GPS Accuracy change.
     */
    DEMEventCaptureGpsAccuracyChange       =(1 << 10),
    /**
     *  @brief DEMEventCaptureRecordingStartedWithData - Event subscription for Recording Started with data.
     */
    DEMEventCaptureRecordingStartedWithData       =(1 << 11),
    /**
     *  @brief DEMEventCaptureAll- Subscription for all events.
     */
    DEMEventCaptureAll = DEMEventCaptureRecordingStarted | DEMEventCaptureRecordingStopped | DEMEventCaptureStartOfSpeedingDetected | DEMEventCaptureEndOfSpeedingDetected | DEMEventCaptureBrakingDetected | DEMEventCaptureAccelerationDetected | DEMEventCaptureInvalidRecordingStopped | DEMEventCaptureTripInfoSaved | DEMEventCapturePhoneCallIncoming | DEMEventCapturePhoneCallDisconnected | DEMEventCaptureGpsAccuracyChange | DEMEventCaptureRecordingStartedWithData
};

/*
 *  @memberof   DEMDrivingEngineManager
 *  @brief      Different categories of Termination Types
 *
 */
typedef NS_ENUM(NSInteger, DEMTripTerminationType ) {
    /**
     *  @brief DEMNotDeterminedStop - Not Deretmined Stop
     */
    DEMTripTerminationTypeUnknown = -1,
    
    /**
     *  @brief DEMBatteryLow - Battery Low.
     */
    DEMBatteryLow = 0,
    /**
     *  @brief DEMLocationServiceDisabled - Location Service Disabled.
     */
    DEMLocationServiceDisabled,
    /**
     *  @brief DEMApplicationQuit - Application Quit.
     */
    DEMApplicationQuit,
    /**
     *  @brief DEMAutomatic - Auto Interrupt.
     */
    DEMAutomatic,
    /**
     *  @brief DEMGPSLostForLongDistance - GPS Lost for long distance.
     */
    DEMGPSLostForLongDistance,
    /**
     *  @brief DEMSystemTimeInterrupted - System Time Interrupted
     */
    DEMSystemTimeInterrupted,
    /**
     *  @brief DEMLowMemory -Low storage memory.
     */
    DEMLowMemory,
    /**
     *  @brief  DEMGPSLostForLongTime -GPS Lost for long time.
     */
    DEMGPSLostForLongTime,
    /**
     *  @brief DEMSnoozed - App was in snooze mode
     */
    DEMSnoozed,
    /**
     *  @brief DEMBackgroundAppRefreshDisabled - background refresh is disabled for app.
     */
    DEMBackgroundAppRefreshDisabled,
    /**
     *  @brief DEMMaxTripCriteriaMet - Max trip allowed.
     */
    DEMMaxTripCriteriaMet,
    /**
     *  @brief  DEMEngineSleep - Engine is in Sleep mode
     */
    DEMEngineSleep,
    /**
     *  @brief DEMManualStop - Manual Stop
     */
    DEMManualStop,
    /**
     *  @brief DEMAirplaneInterupt - Airplane Interrupt.
     */
    DEMAirplaneInterupt
};

/**
 *  @memberof   DEMDrivingEngineManager
    @brief      Different categories for GPS Accuracy
 *
 */
typedef NS_ENUM(NSInteger, DEMGpsAccuracy) {
    /**
     *  @brief DEMGpsAccuracyExcellent - The accuracy of the GPS signal is Excellent
     */
    DEMGpsAccuracyExcellent,
    /**
     *  @brief DEMGpsAccuracyFair - The accuracy of the GPS signal is Fair
     */
    DEMGpsAccuracyFair,
    /**
     *  @brief DEMGpsAccuracyModerate - The accuracy of the GPS signal is Moderate
     */
    DEMGpsAccuracyModerate,
    /**
     *  @brief DEMGpsAccuracyPoor - The accuracy of the GPS signal is Poor
     */
    DEMGpsAccuracyPoor,
    /**
     *  @brief DEMGpsAccuracyUnacceptable - The accuracy of the GPS signal is Unacceptable
     */
    DEMGpsAccuracyUnacceptable
};

/**
 *  @memberof   DEMDrivingEngineManager
    @brief      DEMEngineMode - Different types engine mode
 *
 */
typedef NS_ENUM(NSInteger, DEMEngineMode ) {

    /**
     *  @brief DEMEngineModePark - Engine in Park mode
     *  *Deprecated - Please use DEMEngineModeIdle instead
     */
    DEMEngineModePark  DEPRECATED_ATTRIBUTE = 0,
    /**
     *  @brief DEMEngineModeIdle - Engine in Idle mode
     */
    DEMEngineModeIdle = 0,
    /**
     *  @brief DEMEngineModeDrive - Engine in drive mode
     */
    DEMEngineModeDrive,
    /**
     *  @brief DEMEngineModeDrive - Engine in suspend/snoozed mode
     */
    DEMEngineModeSuspended,
    /**
     *  @brief DEMEngineModeDrive - Engine in shutdown mode
     */
    DEMEngineModeShutdown
};

#endif /* DEMPublicHelper_h */
