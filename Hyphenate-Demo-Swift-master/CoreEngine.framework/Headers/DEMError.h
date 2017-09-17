
/**
 *  @file       DEMError.h
 *  @brief      This file holds all information related to errors in SDK.
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>


/**
 *  @memberof   DEMDrivingEngineManger
    @brief      Different error types SDK supports
 *
 *   */
typedef NS_ENUM(NSInteger, DEMErrorType) {
    /**
     *  DEMErrorTypeBatteryLow
     */
    DEMErrorTypeBatteryLow = 10001,
    /**
     *  DEMErrorTypeLocationService
     */
    DEMErrorTypeLocationService = 10002,
    /**
     *  DEMErrorTypeMemoryLow
     *  @deprecated  DEMErrorTypeMemoryLow
     *  @warning    Deprecated Type: Please do not use this as it will be removed in later versions
     */
    DEMErrorTypeMemoryLow DEPRECATED_ATTRIBUTE = 10003,
    /**
     *  DEMErrorTypeDeviceStorageLow
     */
    DEMErrorTypeDeviceStorageLow = 90001,
    /**
     *  DEMErrorTypeEngineInShutdownMode
     */
    DEMErrorTypeEngineInShutdownMode = 10004,
    /**
     *  DEMErrorTypeEngineInSuspensionMode
     */
    DEMErrorTypeEngineInSuspensionMode = 10005,
    /**
     *  DEMErrorTypeBackgroundApplicationRefreshOff
     */
    DEMErrorTypeBackgroundApplicationRefreshOff = 10006,
    /**
     *  DEMErrorTypeFileNotFound
     */
    DEMErrorTypeFileNotFound = 20001,
    /**
     *  DEMErrorTypeFileNotAccessible
     */
    DEMErrorTypeFileNotAccessible = 20002,
    /**
     *  DEMErrorTypeFileDataError
     */
    DEMErrorTypeFileDataError = 20003,
    /**
     *  DEMErrorTypeFileDataFormatError
     */
    DEMErrorTypeFileDataFormatError = 20004,
    /**
     *  DEMErrorTypeEmptyGPSArray
     */
    DEMErrorTypeEmptyGPSArray = 20005,
    /**
     *  DEMErrorTypeConfigurationInvalid
     */
    DEMErrorTypeConfigurationInvalid = 30001,
    /**
     *  DEMErrorTypeConfigurationCouldNotbeModifiedNow
     */
    DEMErrorTypeConfigurationCouldNotbeModifiedNow = 30002,
    /**
     *  DEMErrorTypeConfigurationInvalidJSON
     */
    DEMErrorTypeConfigurationInvalidJSON = 30003,
    /**
     *  DEMErrorTypeNoInternetConnection
     */
    DEMErrorTypeNoInternetConnection = 40001,
    /**
     *  DEMErrorTypeServerError
     */
    DEMErrorTypeServerError = 40002,
    /**
     *  DEMErrorTypeWrongApplicationfilepath
     */
    DEMErrorTypeWrongApplicationfilepath = 50001,
    /**
     *  DEMErrorTypeRawDataGenerationFailed
     */
    DEMErrorTypeRawDataGenerationFailed = 50002,
    /**
     *  DEMErrorTypeLogFileGenerationFailed
     */
    DEMErrorTypeLogFileGenerationFailed = 50003,
    /**
     *  DEMErrorTypeEmptyServiceParameters
     */
    DEMErrorTypeEmptyServiceParameters = 60001,
    /**
     *  DEMErrorTypeGPSDelay
     */
    DEMErrorTypeGPSDelay = 11001,
};

// Error category
#define DEMErrorCategoryGPSDelay @"DEMErrorGPSDelay"
#define DEMErrorCategoryTripStart @"DEMErrorTripStart"
#define DEMErrorCategoryTripMock @"DEMErrorTripMock"
#define DEMErrorCategoryEngineConfiguration @"DEMErrorEngineConfiguration"
#define DEMErrorCategoryNetworkOperation @"DEMErrorNetworkOperation"
#define DEMErrorCategoryFileOperation @"DEMErrorFileOperation"
#define DEMErrorCategoryStorageNotAvailable @"DEMErrorStorageNotAvailable"
#define DEMErrorCategoryLowMemoryWarning @"DEMErrorLowMemoryWarning"

#define DEMErrorCategoryServiceInfo @"DEMErrorServiceInfo"

#define DEMMockDataFileFormat @"Timestamp,altitude,course,horizontalAccuracy,latitude,longitude,rawSpeed"

// Error Additional Info Keys
#define DEM_KEY_TRIP_MOCK_REQUIRED_FILE_FORMAT @"RequiredFileFormat"
#define DEM_TRIP_MOCK_FILE_PATH @"FilePath"
#define DEM_ENGINE_SERVER_ERROR_CODE @"ServerErrorCode"
#define DEM_ENGINE_SERVER_DESCRIPTION @"ServerErrorDescription"
#define DEM_CONFIGURATION_INVALID_ITEM @"ConfigurationInvalidItem"
#define DEM_KEY_LOCALIZED_DESCRIPTION @"LocalizedDescription"
#define DEM_KEY_BATTERY_LEVEL_REQUIRED @"BatteryLevelRequired"
#define DEM_KEY_BATTERY_CURRENT_LEVEL @"CurrentBatteryLevel"
#define DEM_KEY_ENGINE_SUSPENSION_DURATION @"EngineAutoResumeTime"

// Error description
#define DEMErrorDescriptionBatteryLow @"If battery level of the phone is low, trip recording will not happen even if the call to “StartTripRecording” is made"
#define DEMErrorDescriptionLocationService @"Location service of the phone is disabled"
#define DEMErrorDescriptionDeviceStorageLow @"Device is running low on storage"
#define DEMErrorDescriptionMemoryLow @"Phone is running out of memory"
#define DEMErrorDescriptionEngineInShutdownMode @"Engine is in shutdown mode."
#define DEMErrorDescriptionEngineInSuspensionMode @"Can't start the trip, Engine is in suspension mode"
static NSString *const kSuspendedModeMessage = @"Engine is suspended for";
#define DEMErrorDescriptionBackgroundApplicationRefreshOff @"iOS Background Application Refresh setting disabled by the user"
#define DEMErrorDescriptionFileNotFound @"Mock file does not exists"
#define DEMErrorDescriptionFileNotAccessible @"Mock file is not accessible"
#define DEMErrorDescriptionFileDataError @"Data type of the mock data is wrong"
#define DEMErrorDescriptionFileDataFormatError @"Data format of the mock data file is wrong"
#define DEMErrorDescriptionEmptyGPSArray @"GPS data does not have sufficient locations for trip mocking."

#define DEMErrorDescriptionConfigurationInvalid @"Configuration values are un realistic or contradictory."
#define DEMErrorDescriptionConfigurationCouldNotbeModifiedNow @"Configuration can not be changed while trip recording is in progress"
#define DEMErrorDescriptionNoInternetConnection @"No working internet connection"
#define DEMErrorDescriptionServerError @"Service fails and server is throwing some error"
#define DEMErrorDescriptionWrongApplicationfilepath @"invalid file path set as application file path"
#define DEMErrorDescriptionRawDataGenerationFailed @"Raw data file writing fails"
#define DEMErrorDescriptionLogFileGenerationFailed @"Log file writing fails"
#define DEMConfigurationErrorDescriptionForMaximumPermittedSpeed @"Maximum permitted speed should be above speed limit"
#define DEMConfigurationErrorDescriptionForSpeedLimit @"Speed limit should be above minimum speed to begin trip"
#define DEMConfigurationErrorDescriptionForAutoStopSpeed @"Auto stop speed should be above zero and less than or equal to minimum speed to begin trip"
#define DEMConfigurationErrorDescriptionForAutoStopDuration @"Auto stop duration should be greater than or equal to 5 minutes"
#define DEMConfigurationErrorDescriptionForMaxTripRecordingTime @"Maximum trip recording time should be greater than minTripRecording"
#define DEMConfigurationErrorDescriptionForMinSpeedToBeginTrip @"Minimum Speed to begin trip should be greater than or equal to 5 miles per hour"
#define DEMConfigurationErrorDescriptionForMinBatteryLevelWhileCharging @"Minimum battery level while charging should be between 1 and 100"
#define DEMConfigurationErrorDescriptionForMinBatteryLevelWhileUnPlugged @"Minimum battery level while unplugged should be between 1 and 100"
#define DEMConfigurationErrorDescriptionForDistanceForSavingTrip @"Distance for saving trip data should be between 2 to 10 miles"
#define DEMConfigurationErrorDescriptionForMaxTripRecordingDistance @"Maximum trip recording distance should be greater than minimum trip record time."
#define DEMConfigurationErrorDescriptionForBrakingThreshold @"Braking threshold should be between 1 and 5"
#define DEMConfigurationErrorDescriptionForAccelerationThreshold @"Acceleration threshold should be between 1 and 5"
#define DEMConfigurationErrorDescriptionForMinimumTripRecordTime @"Minimum trip record time should be between 180 and 43200 seconds"
#define DEMConfigurationErrorDescriptionForMinimumTripRecordDistance @"Minimum trip record distance should be between 0.184611 miles and 1000 miles"
#define DEMConfigurationErrorDescriptionForAirplaneModeDuration @"Airplane Mode Duration should be between 180 and 600 seconds"
#define DEMErrorDescriptionInvalidServiceParameters @"GroupID, SensorID or LST Token is empty."
#define DEMConfigurationErrorDescriptionForGPSWarningThresholdValue @"GPS Warning Threshold Value should be between 10 and 60 seconds"
#define DEMErrorDescriptionTypeGPSDelayMessage @"WARNING: GPS update delayed for %d seconds."

extern NSString *const  DEMConfigurationErrorDescriptionInvalidJSON;



@interface DEMError : NSObject
/**
 *  @brief      The category of Error
 *  @note       The following category of error are as in the DEMError.h
 
 */
@property (nonatomic, strong) NSString *category;
/**
 *  @brief      Specific error Codes
 *  @note       The following errorCode of error are as in the DEMError.h
 */
@property (nonatomic, assign) NSInteger errorCode;
/**
 *  @brief      Additional info regarding the error
 *  @details    A collection of additional information about the error including a verbose message.
                Dictionary contains values against key: LocalizedDescription  which
                will contain error description.
 *
 */
@property (nonatomic, strong) NSMutableDictionary *additionalInfo;

@end
