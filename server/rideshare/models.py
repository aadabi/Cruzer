from django.db import models
from django.utils import timezone
from django.core.validators import MaxValueValidator, MinValueValidator
import json
from django.contrib.auth.models import User

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token

#Auth token creation
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

class ActiveRide(models.Model):
	driver_email = models.CharField(max_length=100)
	def __str__(self):
		return 'Driver is: ' + self.driver_email

class WorldInstance(models.Model):
	status = models.BooleanField(default=True)
	region = models.CharField(max_length=50)
	def __str__(self):
		return self.region

class UserProfile(models.Model):
	email = models.CharField(max_length=100)
	first_name = models.CharField(max_length=100)
	last_name = models.CharField(max_length=100)
	point_count = models.IntegerField()
	driver_approval = models.BooleanField(default=False)
	driver_status = models.BooleanField(default=False)
	share_code = models.CharField(max_length=100, blank=True, null=True)
	location_longitude = models.FloatField(max_length=500,default=0)
	location_latitude = models.FloatField(max_length=500,default=0)
	destination_longitude = models.FloatField(max_length=500,default=0)
	destination_latitude = models.FloatField(max_length=500,default=0)
	world = models.ForeignKey(WorldInstance, on_delete=models.DO_NOTHING,null=True, blank=True)
	active_ride = models.ForeignKey(ActiveRide, on_delete=models.DO_NOTHING,null=True,blank=True)
	#user info about car
	user_car = models.CharField(max_length=100, blank=True, null=True)
	car_color = models.CharField(max_length=100, blank=True, null=True)
	car_capacity = models.IntegerField(blank=True, null=True)
	driver_license = models.CharField(max_length=100, blank=True, null=True)
	def __str__(self):
		return self.email
	
class RideHistory(models.Model):
	user = models.ForeignKey(UserProfile, on_delete=models.DO_NOTHING,null=True,blank=True)
	as_driver = models.BooleanField(default=False)
	rating = models.FloatField(max_length=100,null=True,blank=True)

"""
API: Goal Information
POST NEW API
This will show the current weekly and monthly goals and the user's progress through them

What I'm Sending:
user_email

What I need back:
weekly_goals: [{goal: String, progress: Int}, ...]
monthly_goals: [{goal: String, progress: Int}, ...]
(The goals should look like this Make _____ number of rides: ___ Points)
If the user acomplishes a goal they should be awarded the points.
"""
class WeeklyGoals(models.Model):
	user = models.ForeignKey(UserProfile, on_delete=models.DO_NOTHING,null=True,blank=True)
	goal_total = models.IntegerField()
	goal_current = models.IntegerField()
	points_reward = models.IntegerField()

class MonthlyGoals(models.Model):
	user = models.ForeignKey(UserProfile, on_delete=models.DO_NOTHING,null=True,blank=True)
	goal_total = models.IntegerField()
	goal_current = models.IntegerField()
	points_reward = models.IntegerField()
	
# SDP code below this line

class PlannedTrips(models.Model):
	trip_id = models.PositiveIntegerField(blank=True, null=True)
	first_name = models.CharField(max_length=100)
	last_name = models.CharField(max_length=100)
	driver_email = models.CharField(max_length=100)
	driver_departure_longitude = models.FloatField(max_length=500)
	driver_departure_latitude = models.FloatField(max_length=500)
	driver_destination_longitude = models.FloatField(max_length=500)
	driver_destination_latitude = models.FloatField(max_length=500)
	driver_timeofdeparture_hour = models.IntegerField()
	driver_timeofdeparture_minute = models.IntegerField()
	monday = models.BooleanField(default=False)
	tuesday = models.BooleanField(default=False)
	wednesday = models.BooleanField(default=False)
	thursday = models.BooleanField(default=False)
	friday = models.BooleanField(default=False)
	saturday = models.BooleanField(default=False)
	sunday = models.BooleanField(default=False)
	driver_departure = models.CharField(max_length=200)
	driver_destination = models.CharField(max_length=200)
	def get_days(self):
		return json.loads(driver_days)
	
class ProposedTrips(models.Model):
	trip_id = models.PositiveIntegerField(blank=True, null=True)
	rider_email = models.CharField(max_length=100)
	rider_departure_longitude = models.FloatField(max_length=200, blank=True, null=True)
	rider_departure_latitude = models.FloatField(max_length=200, blank=True, null=True)
	rider_destination_longitude = models.FloatField(max_length=200, blank=True, null=True)
	rider_destination_latitude = models.FloatField(max_length=200, blank=True, null=True)
	rider_timeofdeparture_hour = models.IntegerField(blank=True, null=True)
	rider_timeofdeparture_minute = models.IntegerField(blank=True, null=True)
	monday = models.BooleanField(default=False)
	tuesday = models.BooleanField(default=False)
	wednesday = models.BooleanField(default=False)
	thursday = models.BooleanField(default=False)
	friday = models.BooleanField(default=False)
	saturday = models.BooleanField(default=False)
	sunday = models.BooleanField(default=False)
	rider_departure = models.CharField(max_length=200)
	rider_destination = models.CharField(max_length=200)
	
class RideProfile(models.Model):
	desired_trip = models.ManyToManyField(PlannedTrips)
	proposed_trip = models.ManyToManyField(ProposedTrips)
	user_account = models.OneToOneField(User)
	email = models.CharField(max_length=100)
	rider_firstname = models.CharField(max_length=100)
	rider_lastname = models.CharField(max_length=100)
	rider_departure_lon = models.FloatField(max_length=200, blank=True, null=True)
	rider_departure_lat = models.FloatField(max_length=200, blank=True, null=True)
	rider_destination_lon = models.FloatField(max_length=200, blank=True, null=True)
	rider_destination_lat = models.FloatField(max_length=200, blank=True, null=True)
	rider_timeofdeparture_hour = models.IntegerField(blank=True, null=True)
	rider_timeofdeparture_minute = models.IntegerField(blank=True, null=True)
	rider_departure = models.CharField(max_length=200)
	rider_destination = models.CharField(max_length=200)

class RiderApproveTrip(models.Model):
	user_profile = models.ForeignKey(RideProfile,  on_delete=models.CASCADE)
	planned_trip = models.ForeignKey(PlannedTrips, on_delete=models.CASCADE)
	approve = models.BooleanField(default=False)
	
class DriverActive(models.Model):
	isactive = models.BooleanField(default=False)
	user_account = models.OneToOneField(User)
	driverod_email = models.CharField(max_length=100)
	driverod_departure_lon = models.FloatField(max_length=200, blank=True, null=True)
	driverod_departure_lat = models.FloatField(max_length=200, blank=True, null=True)
	driverod_destination_lon = models.FloatField(max_length=200, blank=True, null=True)
	driverod_destination_lat = models.FloatField(max_length=200, blank=True, null=True)
	driverod_timeofdeparture = models.CharField(max_length=10)
	riderod_email = models.CharField(max_length=100)
	rejected_rider = models.ManyToManyField('RiderActive', related_name='rejected_rider')
	
class RiderActive(models.Model):
	isactive = models.BooleanField(default=False)
	driverod_email = models.CharField(max_length=100, blank=True, null=True)
	user_account = models.OneToOneField(User)
	driverod_active_profile = models.OneToOneField(DriverActive, blank=True, null=True)
	riderod_departure_lon = models.FloatField(max_length=200, blank=True, null=True)
	riderod_departure_lat = models.FloatField(max_length=200, blank=True, null=True)
	riderod_destination_lon = models.FloatField(max_length=200, blank=True, null=True)
	riderod_destination_lat = models.FloatField(max_length=200, blank=True, null=True)
	has_trip = models.BooleanField(default=False)
	has_response = models.BooleanField(default=False)
	seen_driver = models.ManyToManyField(DriverActive, related_name='seen_driver')
