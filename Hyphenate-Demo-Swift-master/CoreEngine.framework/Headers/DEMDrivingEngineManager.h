
/**
 *  @file       DrivingEngineManager.h
 *
 *  @brief      Act as plugin to the Engine. Handle Input and output activities of the engine
 *
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#import "DEMEngine.h"


@class DEMConfiguration;
@class DEMEventInfo;
@protocol DEMDrivingEngineDelegate;
@protocol DEMDrivingEngineDataSource;

@interface DEMDrivingEngineManager : NSObject

/**
*  @brief       To obtain the singleton instance
*
*  @details     DEMDrivingEngineManager instance should be created just once or SDK will throw an 
                exception if it is created more than once
*
*  @return      Returns an instance of DEMDrivingEngineManager class
*/
+ (id)sharedManager;

/**
 *  @brief      To obtain a string containing build info
 
 *  @details    String contains GitVersionTag, GitBuildNumber, GitNumModified, GitDate, GitBranch, GitHash
 
 *  @return     Returns a build information as a String
 */
-(NSString*)buildInfo;


/**
 *  @brief         Starts the driving engine.
 *
 *  @details        The engine will start trip detection and collects driving data
 *
 */
- (void)startEngine;

/**
 *  @brief          Shutdowns the engine
 *
 *  @details        No trips will be recorded further until startEngine is called
 *
 *
 */
- (void)shutDownEngine;

/**
 *  @brief        Passes a previously obtained Oauth token to the engine to be used for trip upload.
 *  @note          If enableWebservices set to 'YES' this becomes mandatory.
 *  @param         lstToken - LST Token as string format
 *
 */
-(void)setUploadToken:(NSString *)lstToken;

/**
 *   @brief       Passes a string containing reference data that can be used by upstream applications to
                   correlate with trip data
 *   @param        referenceData - Reference data as a string
 *  @note          If enableWebservices set to 'YES' this becomes mandatory.
 *   @return       Returns Boolean on success / failure
 *
 */
-(BOOL)setReferenceData:(NSString *)referenceData;

/**
 *
 *  @brief         Passes a previously obtained A6 groupID  to the engine to be used for trip upload
 *  @note          If enableWebservices set to 'YES' this becomes mandatory.
*   @param         groupId - Group id as  string
 */
-(void)setGroupId:(NSString*)groupId;

/**
 *
 *  @brief          Passes a previously obtained A6 sensorID  to the engine to be used for trip upload
 *  @note          If enableWebservices set to 'YES' this becomes mandatory.
 *  @param          sensorId - Sensor id as string .
 */
-(void)setSensorId:(NSString*)sensorId;

/**
 *  @brief           Sets tunable configuration parameters within the engine as per the Configuration
                       object passed.
 *  @details        Sets the SDK engine parameters as per the configuration
 *
 *  @param          engineConfiguration - DEMConfiguration object for trip
 *  @return         Returns Boolean on success / failure, Would return 'False' if there is a trip in 
                    progress when an attempt is made to set the configuration.
 */
- (BOOL)setConfiguration:(DEMConfiguration *)engineConfiguration;

/**
 *  @brief   Configuration from JSON - NSData
 
 *  @details   JSON has to follow below keys & type of values expected\n
 *    "maximumPermittedSpeed";            // Double value\n
 *    "airPlaneModeDuration";             // Double value\n
 *    "autoStopDuration";                 // Double value\n
 *    "minSpeedToBeginTrip";              // Double value\n
 *    "speedLimit";                       // Double value\n
 *    "minBatteryLevelWhileCharging";     // Double value\n
 *    "minBatteryLevelWhileUnPlugged";    // Double value\n
 *    "minTripRecordTime";                // Double value\n
 *    "minTripRecordDistance";            // Double value\n
 *    "distanceForSavingTrip";            // Double value\n
 *    "maxTripRecordingTime";             // Double value\n
 *    "maxTripRecordingDistance";         // Double value\n
 *    "autoStopSpeed";                    // Double value\n
 *    "enableRawDataCollection";          // bool value\n
 *    "generateEngineActivityLog";        // bool value\n
 *    "enableWebServices";                // bool value\n
 *    "captureFineLocation";              // bool value\n
 *    "brakingThreshold";                 // Double value\n
 *    "accelerationThreshold";            // Double value\n
 *    "enable24HrTimeSlot";               // bool value\n
 *    "enableDeveloperMode";              // bool value\n
 *    "enableBrakingEventSuppression"     // bool value\n
 *    "enableAccelerationEventSuppression" // bool value\n
 *    "gpsWarningThresholdValue"            // int value\n
 *
 *
 *  @param data NSData, JSON data with keys & values
 *
 *  @return DEMConfiguration instance with values from JSON
 *  @note    For example\n
 *            //JSON data string\n
 *           NSString *jsonString = @"{\"maxPermittedSpeed\":547,\"enableWebServices\":YES}";\n
 *           NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];\n
 *           DEMConfiguration *testConfig = [[DEMDrivingEngineManager sharedManager]
 *                                            setConfigurationUsingJSON:data];\n
 *
 */
- (DEMConfiguration *)setConfigurationUsingJSON:(NSData *)data;

/**
 *  @brief          Set the Application path for logging of data
 *
 *  @details        Sets the applications desired path for log file collection.
                    Overrides the default location
 *
 *  @param          path - FilePath for saving files generated by CoreEngine
 */
- (void)setApplicationPath:(NSString *)path;

/**
 *  @brief          Trip Recording starts when function called
 *
 *  @details
 *                  To start the mock trip recording.
 *                  The method to be invoked after the simulation mode is enabled
 *
 *  @deprecated     startTripRecording
 *
 *  @warning        Deprecated method: Use "startMockTripUsingLocation: activity: fastMock: cadence:"
 */
- (void)startTripRecording DEPRECATED_ATTRIBUTE;

/**
 *
 *  @brief          To stop the trip recording manually
 *  @details        Stops the ongoing trip manually and does not record any trip data once this method
                    is invoked
 *
 */
- (void)stopTripRecording;


/**
 *
 *  @brief     Registers the app to the  engine for the purpose of recieving driving events
 *  @details   Once the app registers for events it starts capturing one particular event or captures
               all events based on the need
 *  @param     captureMask - It has the List of event subscriptions supported by CoreEngine SDK
 */
- (void)registerForEventCapture:(DEMEventCaptureMask)captureMask;

/**
 *
 *  @brief     Call this function to stop for event notification callbacks
 *  @details   No events will be notified once the method is called
 */
- (void)unregisterForEventCapture;


/**
 *  @brief          Suspends trip recording for the specified time period
 *  @details        Trip recording suspended for specified time period
                    The engine continues to run and collect data but will not notify the app of events
 *  @param          durationInSeconds - suspension period is in seconds
 *
 *
 */
- (void)suspendForPeriod:(NSTimeInterval)durationInSeconds;

/**
 *
 *  @brief     Terminates a suspension and resume trip recording
 *  @details    The trip recording which was suspended for the duration called by the method
                suspendForPeriod will resume the recording of the trip
 *
 */
- (void)cancelSuspension;


/**
 *	@brief      Specifies the current engine mode as Idle, Drive, Suspended or Shutdown (Idle Mode = 0, Drive Mode = 1, Suspended Mode = 2, Shutdown Mode = 3)
 *  @return     Returns enum values depending on the mode
 */
- (DEMEngineMode)engineMode;


/**
 *	@brief  Provides a method to simulate drive
 *
 *  @details
 *           Mock data in the form of a CSV file needs to be passed (format : timestamp,latitude,longitude,rawSpeed,course,horizontalAccuracy,altitude).
 *          ‘cadence’ value in the form of milliseconds is passed to provide a time interval between
             processing of data points.
 *          info: Calling this method disables the real time data collection. Realtime data collection 
             will resume when the method ‘cancelMockData’ is called
 * @param   path - Is the mock data file path
 * @param   cadence - Time interval between processing of data points in milliseconds
 * @deprecated     setMockDataPath
 *
 * @warning  Deprecated method: Use "startMockTripUsingLocation: activity: fastMock: cadence:"
 *
 */
-(BOOL)setMockDataPath:(NSString*)path cadence:(long)milliseconds DEPRECATED_ATTRIBUTE;


/**
 *	@brief  Provides mock data in the form of an array of location. Location objects to be used to exercise the sdk without having to drive.
 *
 *  @details
 *           Provides mock data in the form of an array of CLLocation objects to be used to exercise the
              SDK without having to drive.  A ‘cadence’ value in the form of milliseconds is passed to
              provide a time interval between processing of data points.  The result is a simulated
              drive. The use of this method automatically disables real time data collection.  Real time 
              data collection will resume when the method ‘cancelMockData’ is called.
 * @param     data - The mock data that is passed to excercise the SDK without having a actual drive.
 * @param    cadence - Time interval between processing of data points in milliseconds
 * @deprecated  setMockData
 *
 * @warning  Deprecated method: Use "startMockTripUsingLocation: activity: fastMock: cadence:"
 *
 */
-(void)setMockData:(NSArray*)data cadence:(long)milliseconds DEPRECATED_ATTRIBUTE;


/**
 *	@brief    To cancel the ongoing simulation 
 *  @details  Cancels a previous call to ‘setMockDataPath’ or ‘setMockData’ stops the processing of any mock data and re-enables real-time data collection
 *  @deprecated  cancelMockData
 *
 *  @warning  Deprecated method: Use "stopTripRecording" instead to stop mock trips
 */

-(void)cancelMockData DEPRECATED_ATTRIBUTE;

/**
 *	@brief          Called when engine detects the incoming phone call when trip in progress.
 *
 *  @param          eventInfo – event information of incoming phone call
 *
 */
-(void)didDetectIncomingPhoneCall:(DEMEventInfo*)eventInfo;

/**
 *
 *  @brief         Called when engine detects that a phone call is disconnected when trip in progress.
 *  @param         eventInfo – event information of disconnected phone call
 *
 */
-(void)didDetectDisconnectedPhoneCall:(DEMEventInfo*)eventInfo;

/**
 *	@brief          To ignore the current trip.
 *
 *  @details        tripRejectReason flag will be set, informing that the current trip is ignored in the trip summary
                    json
 *
 */

- (void)ignoreCurrentTrip;

/**
 *  @brief          The DEMDrivingEngineDelegate protocol defines the methods used for trip related 
                    processing from a DEMDrivingEngineManager object
 *
 *  @details        Driving engine delivers its outputs through this delegate class. One can implement 
                    the required and optional methods to receive the engine outputs

 */
@property (assign, nonatomic) id<DEMDrivingEngineDelegate>delegate;

/**
 *
 *  @brief         Classes should set this datasource so that engine can ask for data from client apps
 *  @param        datasource - The object that acts as the data source of the DEMDrivingEngineManager
 */

@property (weak, nonatomic) id<DEMDrivingEngineDataSource> datasource;

/**
 *  @brief          Inorder to upload the collected rawdata into the server
 *  @details        If raw data collection is enabled, this method will set the details of the
                    destination FTP server to which the raw data will be sent.  The parameters are 
                    standard FTP required settings. ‘buildNo’ is a string that will be placed in the
                    ‘app.txt’ file of the raw data to specify an app version used to collect the raw 
                    data
 *
 *  @param ftpURL     - String containing the URL of FTP server.
 *  @param userId     - String containing User ID
 *  @param password   - String containing  Password
 *  @param folderPath - String containing  Folder path where the data will be uploaded.
 *  @param buildNo    - String containing a string that has the app version of the SDK.
 */
- (void)setRawDataInfo:(NSString*)ftpURL userName:(NSString*)userId password:(NSString*)password path:(NSString*)folderPath buildNumber:(NSString*)buildNo;

/**
 *  @brief          start Mock updates for location and motion activities from their respective files.
 
 *  @details        Trips can be mocked by providing location file and motion activity file. Updates would be picked from respective files and will be triggered based on cadence.\n\n
 Required headers for location file & their formats\n
 timestamp           - yyyy-MM-dd'T'HH:mm:ss.SSSZZ\n
 altitude            - double\n
 course              - double\n
 horizontalAccuracy  - double\n
 latitude            - double\n
 longitude           - double\n
 rawSpeed            - double\n\n
 
 Required headers for motion file & their formats\n
 startDate       - yyyy-MM-dd'T'HH:mm:ss.SSSZZ\n
 confidence      - CMMotionActivityConfidence(NSInteger)\n
 unknown         - Bool\n
 stationary      - Bool\n
 walking         - Bool\n
 running         - Bool\n
 automotive      - Bool\n
 cycling         - Bool\n
 tripStart       - Bool  // activity for trip start or trip end.\n
 
 *  @param locationPath     - String containing the path for location file.
 *  @param activityPath     - String containing the path for motion activity file.
 *  @param cadenceSecs      - NSTimeInterval, time interval between consecutive updates.
 *  @param fastMock         - if Enabled, timestamp would be selected from file and cadence would be considered.
                            if Disabled, cadence value would be ignored and value would be picked from file.
 
 * @note format for location mock file:\n
timestamp,latitude,longitude,rawSpeed,course,horizontalAccurac,altitude\n
 sample location mock file data:\n
2016-07-26T21:44:50.123+0530,12.929914558519522,77.683217608144744,-1.000000000000000,-1.000000000000000,1414.000000000000000,20.859320868375455,893.910461425781250
 ...\n\n
 format for motion mock file:\n
 startDate,confidence,unknown,stationary,walking,running,automotive,cycling,tripStart\n
 sample motion mock file data:\n
 2016-07-26T21:44:38.123+0530,0,NO,NO,YES,NO,NO,NO,YES
 ...\n

 */
- (void)startMockTripUsingLocation:(NSString* )locationPath activity:(NSString*)activityPath fastMock:(BOOL)isFastMock cadence:(NSTimeInterval)cadenceSecs;

/**
 *@brief Save the current configuration of the engine with the directory path passed and fileName passed by the client
* @param directoryPath - Path to save the file paased by client
* @param fileName -  File name passed by client
* @param error - error object
* @note The fileName should not contain any file extenions, A file of .json extension would be created
 */
-(BOOL)saveConfigurationToFile:(NSString *)directoryPath fileName:(NSString *)fileName error:(NSError**) error;

@end
