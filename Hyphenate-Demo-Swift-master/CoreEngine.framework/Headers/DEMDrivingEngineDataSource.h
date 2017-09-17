
/**
 *  @file       DEMDrivingEngineDataSource.h
 *  @brief      Data source for Driving engine manager
 *  @copyright  Copyright © 2016 Allstate Insurance Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>


@class DEMDrivingEngineManager;

@protocol DEMDrivingEngineDataSource <NSObject>

@optional

/**
 *  @brief      Datasource to fetch the metadata from client application.
 *  @details    Application layer should return the meta data when this is called
 *  @param      drivingEngine- Instance of DEMDrivingEngineManager
 *  @return     String containing the metadata
 */
- (NSString *)metaDataForCurrentTrip:(DEMDrivingEngineManager *)drivingEngine;

@end
