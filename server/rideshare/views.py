from rest_framework import viewsets
from rideshare.serializers import *
from django.contrib.auth.models import User

from rest_framework import status
from rest_framework.decorators import api_view, parser_classes, authentication_classes, permission_classes
from rest_framework.response import Response
from rest_framework.parsers import JSONParser
from django.contrib.auth import authenticate
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.exceptions import *
from django.core import serializers
from django.core.exceptions import ObjectDoesNotExist
from django.db import IntegrityError
from django.core.mail import EmailMessage

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
@api_view(['POST'])
@parser_classes((JSONParser,))
def goal_info(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	#for now each user should just have 1 weekly goal and 1 monthly goal
	weekly_goal = user.weeklygoals_set.all()
	monthly_goal = user.monthlygoals_set.all()
	objret = {}
	obj_w_list = []
	obj_m_list = []
	for obj in weekly_goal:
		dict = {}
		dict['goal'] = "Make " + obj.goal_total + " number of rides: " + obj.point_reward + " Points"
		dict['progress'] = obj.goal_current
		obj_w_list.append(dict)
	objret['weekly_goals'] = obj_w_list
	for obj in monthly_goal:
		dict = {}
		dict['goal'] = "Make " + obj.goal_total + " number of rides: " + obj.point_reward + " Points"
		dict['progress'] = obj.goal_current
		obj_m_list.append(dict)
	objret['monthly_goals'] = obj_m_list
	objfin= json.dumps(objret)
	return HttpResponse(objfin, status=200, content_type='application/json')

"""
API: Forgot Password:
POST NEW API
Send an email to the user to remake their password.
What I'm Sending:
user_email

What I need back:
An approval if it went through
"""
@api_view(['POST'])
@parser_classes((JSONParser,))
def forgot_password(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	email = EmailMessage('Forgot Password', 'This is currently a test of BODY', from_email = "admin@slugride.com", to=[user_email])
	email.send()
	return HttpResponse(status=200)
"""
API: buy_points
POST NEW API
Add additional points if there was a purchase on the store

What I"m sending:
user_email: String
point_add: Int

What I need back:
An Approval if it went through
In the back end points should be changed accordingly
"""
@api_view(['POST'])
@parser_classes((JSONParser,))
def buy_points(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	point_add = jsonobj['point_add']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	user.point_count += point_add
	user.save()
	return HttpResponse(status=201)
	
"""
API: Edit Account Information
POST NEW API
This will edit any of the current. If the information is blank do not change the information:
What I'm Sending
user_email: String
first_name: String
last_name: String
user_car: String
car_color: String
car_capacity: Int

What you are sending:
An Approval to show that it went through
"""
@api_view(['POST'])
@parser_classes((JSONParser,))
def edit_account_info(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	user_email = jsonobj['user_email']
	first_name = jsonobj['first_name']
	last_name = jsonobj['last_name']
	user_car = jsonobj['user_car']
	car_color = jsonobj['car_color']
	car_capacity = jsonobj['car_capacity']
	print (jsonobj)
	if user_email:
		user.user_email = user_email
	if first_name:
		user.first_name = first_name
	if last_name:
		user.last_name = last_name
	if user_car:
		user.user_car = user_car
	if car_color:
		user.car_color = car_color
	if car_capacity:
		user.car_capacity = car_capacity
	user.save()
	return HttpResponse(status=201)


@api_view(['POST'])
@parser_classes((JSONParser,))
def account_info(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	user_car = user.user_car
	car_color = user.car_color
	car_capacity = user.car_capacity
	driver_ride_ratings = RideHistory.objects.filter(user = user, as_driver = True)
	driver_rating = 0
	driver_rating_count = 0
	if driver_ride_ratings:
		for rating_d in driver_ride_ratings:
			driver_rating_count += 1
			driver_rating += rating_d.rating
		driver_rating = driver_rating / driver_rating_count
	else:
		driver_rating = 6
		#6 means not rating
	rider_ride_ratings = RideHistory.objects.filter(user = user, as_driver = False)
	rider_rating = 0
	rider_rating_count = 0
	if rider_ride_ratings:
		for rating_r in rider_ride_ratings:
			rider_rating_count += 1
			rider_rating += rating_r.rating
		rider_rating = rider_rating / rider_rating_count
	else:
		rider_rating = 6
		# 6 means no rating
	objret = {}
	objret['driver_rating'] = driver_rating
	objret['rider_rating'] = rider_rating
	objret['rides_given'] = driver_rating_count
	objret['rides_taken'] = rider_rating_count
	objret['user_car'] = user.user_car
	objret['car_color'] = user.car_color
	objret['car_capacity'] = user.car_capacity
	objfin = json.dumps(objret)
	return HttpResponse(objfin, status=200, content_type='application/json')

"""
adato [9:19 PM] 
API: Driver Information Submit:
POST NEW API:
This will take in the driver data for us to take a look at and approve

What I'm sending:
user_email: String
user_car: String
car_color: String
driver_license: String

What I need to recieve: An approval if the request went througH

On our side we need to set the user as pending for approval where we will 
take a look to see if their license is valid and then set them to approved.
"""
@api_view(['POST'])
@parser_classes((JSONParser,))
def driver_info_submit(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	user_car = jsonobj['user_car']
	car_color = jsonobj['car_color']
	driver_license = jsonobj['driver_license']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	user.user_car = user_car
	user.car_color = car_color
	user.driver_license = driver_license
	user.save()
	return HttpResponse(status=200)

"""
API: Rate user:
POST NEW API:
This will take in a rating for the rider or driver they are rating
What I am sending:
user_email:String
rating: InT (number between 1 to 5)

What I need to receive:
An approval if the rating went through
"""
@api_view(['POST'])
@parser_classes((JSONParser,))
def rate_user(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	try:
		user = UserProfile.objects.get(email = user_email)
	except UserProfile.DoesNotExist:
		user = None
		return HttpResponse(status=400)
	rating = jsonobj['rating']
	ride_rate = RideHistory.objects.create(user = user, rating = rating)
	ride_rate.save()
	return HttpResponse(status=200)

@api_view(['POST'])
@parser_classes((JSONParser,))
def end_ride(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	user_email = jsonobj['user_email']
	user = UserProfile.objects.get(email = user_email)
	objlist = []
	#add a try except here
	try:
		user_active_ride = user.active_ride
	except ObjectDoesNotExist:
		objret = {}
		objret['user_emails'] = objlist
		objret = json.dumps(objret)
		return HttpResponse(objret, status=200, content_type='application/json')
	other_users = user.active_ride.userprofile_set.all()
	for other_user in other_users:
		if other_user.email == user_email:
			continue
		objlist.append(other_user.email)
	if user.email != user.active_ride.driver_email:
		objlist = [user.active_ride.driver_email]
	else:
		for riders in user.active_ride.userprofile_set.all():
			riders.active_ride = None
	objret = {}
	objret['user_emails'] = objlist
	user.active_ride = None
	print(objret)
	objfin = json.dumps(objret)
	return HttpResponse(objfin, status=200, content_type='application/json')
	
#THIS FUNCTION STILL NEEDS TO ADD THE "CHANGE RIDER FROM WORLD INTO THE DRIVERS CURRENT RIDE FUNCTION"
# FOR NOW IT JUST REMOVES THEM FROM THE WORLD, DRIVERS RIDE TABLE DOESNT EXIST YET
# It kind of does now
@api_view(['POST'])
@parser_classes((JSONParser,))
def scan_qr_code(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	rider_email = jsonobj['user_email']
	driver_email = jsonobj['driver_email']
	rider = UserProfile.objects.get(email = rider_email)
	driver = UserProfile.objects.get(email = driver_email)
	#check if driver is in driver list and world
	if driver.world == WorldInstance.objects.get(region="Norcal") and driver.driver_status == True:
		rider.world = None
	else:
		objret = {"user_points": rider.point_count,"approved": False}
		objfin = json.dumps(objret)
		print (driver.world.region)
		print (driver.driver_status)
		return HttpResponse(objfin, status=400, content_type='application/json')
	#if they are then get bool to verify they are a driver
	#rider is removed from world and deduct points
	rider.point_count -= 100
	driver.point_count += 100
	# He needs, user_points and if approved or not (success or not)
	# if approved remove rider from active_users(in the world) and deduct points and add to driver, lets start with 100 points
	try:
		if driver.active_ride is not None:
			rider.active_ride = driver.active_ride
			rider.save()
			objret = {"user_points": rider.point_count,"approved": True}
			objfin = json.dumps(objret)
			return HttpResponse(objfin, status=200, content_type='application/json')
		#just a band aid this else statement is, a clone of the except part will research why its neede later
		else:
			new_ride = ActiveRide.objects.create(driver_email = driver.email)
			driver.active_ride = new_ride
			rider.active_ride = new_ride
			new_ride.save()
			driver.save()
			rider.save()
			objret = {"user_points": rider.point_count,"approved": True}
			objfin = json.dumps(objret)
			return HttpResponse(objfin, status=200, content_type='application/json')
	except ObjectDoesNotExist:
		new_ride = ActiveRide.objects.create(driver_email = driver.email)
		driver.active_ride = new_ride
		rider.active_ride = new_ride
		new_ride.save()
		driver.save()
		rider.save()
		objret = {"user_points": rider.point_count,"approved": True}
		objfin = json.dumps(objret)
		return HttpResponse(objfin, status=200, content_type='application/json')
	
@api_view(['POST'])
@parser_classes((JSONParser,))
def query_ride(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['user_email']
	userprofile = UserProfile.objects.get(email = email)
	userprofile.driver_status = jsonobj['driver_status']
	userprofile.location_latitude = jsonobj['location_latitude']
	userprofile.location_longitude = jsonobj['location_longitude']
	userprofile.destination_latitude = jsonobj['destination_latitude']
	userprofile.destination_longitude = jsonobj['destination_longitude']
	userprofile.save() 
	# return a list of all users within 1 mile radius of the user
	# user_list and user_points
	# user_email, driver_status, location_longitude, location_latitude, destination_longitude, destination_latitude
	# {
	#	user_points: int
	#	user_list: [ { ... }, { ... }]
	# }
	objfinaldict = {}
	objfinaldict = {"user_points":userprofile.point_count}
	objlist = []
	#Norcal is the default for now because we are launching in Santa Cruz. When we expand this needs to be changed based on location
	for obj in WorldInstance.objects.get(region="Norcal").userprofile_set.all():
		objiter = {}
		user_email = obj.email
		driver_status = obj.driver_status
		location_longitude = obj.location_longitude
		location_latitude = obj.location_latitude
		destination_longitude = obj.destination_longitude
		destination_latitude = obj.destination_latitude
		objiter = {"user_email": user_email,"driver_status":driver_status,"location_longitude":location_longitude,"location_latitude":location_latitude,"destination_longitude":destination_longitude,"destination_latitude":destination_latitude}
		objlist.append(objiter)
	objfinaldict['user_list'] = objlist
	objret = json.dumps(objfinaldict)
	#print(objret)
	return HttpResponse(objret, status=200, content_type='application/json')

@api_view(['POST'])
@parser_classes((JSONParser,))
def post_ride(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['user_email']
	try:
		userprofile = UserProfile.objects.get(email = email)
	except UserProfile.DoesNotExist:
		return HttpResponse(status=400)
	userprofile.world = WorldInstance.objects.get(region="Norcal")
	userprofile.driver_status = jsonobj['driver_status']
	userprofile.location_latitude = jsonobj['location_latitude']
	userprofile.location_longitude = jsonobj['location_longitude']
	userprofile.destination_latitude = jsonobj['destination_latitude']
	userprofile.destination_longitude = jsonobj['destination_longitude']
	userprofile.save()
	return HttpResponse(status=200)
#
# SDP code blow
#

@api_view(['POST'])
@parser_classes((JSONParser,))
def get_driver_response_ondemand(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['rideremail']
	#email = "od2@ucsc.edu"
	user = User.objects.get(email = email)
	rider = RiderActive.objects.get(user_account = user)
	objlist = []
	if rider.has_response is True:
		objiter = {"response": "accept"}
	else:
		objiter = {"response": "check"}
	objlist.append(objiter)
	objret = json.dumps(objlist)
	return HttpResponse(objret, status=200, content_type='application/json')
	
@api_view(['POST'])
@parser_classes((JSONParser,))
def rider_request_driver(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	print(jsonobj)
	email = jsonobj['rider_email']
	driver = jsonobj['driver_email']
	try:
		user = User.objects.get(email = email)
	except ObjectDoesNotExist:
		return HttpResponse(status=400)
	try:
		d_user = User.objects.get(email = driver)
	except ObjectDoesNotExist:
		return HttpResponse(status=400)
	rider = RiderActive.objects.get(user_account = user)
	rider.riderod_destination_lon = jsonobj['riderdest_lon']
	rider.riderod_destination_lat = jsonobj['riderdest_lat']
	driver = DriverActive.objects.get(user_account = d_user)
	#rider.driverod_active_profile = driver
	rider.driverod_email = email
	driver.riderod_email = email
	rider.has_trip = False
	rider_has_response = False
	driver.save()
	rider.save()
	return HttpResponse(status=200)

@api_view(['GET'])
@parser_classes((JSONParser,))
def rider_getdrivers_ondemand(request):
	drivers = DriverActive.objects.filter(isactive=True).first()
	objlist = []
	objiter = {}
	#if drivers is not None:
	#	has_driver_accepted = drivers.rejected_rider.all().count()# or rejected
	#if drivers is None or has_driver_accepted > 0:
	#	return HttpResponse(status=201)
	#else:
	email = drivers.driverod_email
	dep_lon = drivers.driverod_departure_lon
	dest_lon = drivers.driverod_destination_lon
	dep_lat = drivers.driverod_departure_lat
	dest_lat = drivers.driverod_destination_lat
	objiter = {"driverod_email": email,"driver_departure_lon": dep_lon,"driver_destination_lon":dest_lon,"driver_departure_lat": dep_lat,"driver_destination_lat":dest_lat}
	objlist.append(objiter)
	objret = json.dumps(objlist)
	return HttpResponse(objret, status=200, content_type='application/json')

@api_view(['POST'])
@parser_classes((JSONParser,))
def rider_ondemand(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['rider_email']
	dest_lon = jsonobj['rider_destination_lon']
	dep_lon = jsonobj['rider_departure_lon']
	dest_lat = jsonobj['rider_destination_lat']
	dep_lat = jsonobj['rider_departure_lat']
	user = User.objects.get(email=email)
	try:
		rideractive = RiderActive.objects.get(user_account=user)
	except ObjectDoesNotExist:
		return HttpResponse(status=400)
	rideractive.isactive = True
	rideractive.riderod_departure_lon = dep_lon
	rideractive.riderod_destination_lon = dest_lon
	rideractive.riderod_departure_lat = dep_lat
	rideractive.riderod_destination_lat = dest_lat
	rideractive.save()
	return HttpResponse(status=200)

@api_view(['POST'])
@parser_classes((JSONParser,))
def decide_rider_ondemand(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	demail = jsonobj['driveremail']
	remail = jsonobj['rideremail']
	#temp
	#remail = "od2@ucsc.edu"
	response = jsonobj['response']
	if response == "accept":
		rider_user = User.objects.get(email=remail)
		rider_active = RiderActive.objects.get(user_account=rider_user)
		rider_active.has_trip = True
		rider_active.has_response = True
		rider_active.save()
		return HttpResponse(status=200)
	elif response == "reject":
		rider_user = User.objects.get(email=remail)
		rider_active = RiderActive.objects.get(user_account=rider_user)
		driver_active = DriverActive.objects.get(driverod_email=demail)
		rider_active.driverod_email = None
		driver_active.riderod_email = None
		rider_active.has_trip = False
		rider_has_response = True
		ride_active.save()
		return HttpResponse(status=200)
	else:
		print(response)
		return HttpResponse(status=400)
		
@api_view(['POST'])
@parser_classes((JSONParser,))
def driver_ondemand_get_rider(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['driver_email']
	driverod_active_profile = DriverActive.objects.get(driverod_email = email)
	#temporary change
	rider_active_profile = RiderActive.objects.filter(isactive = True).first() #od2
	#r_user = User.objects.get(email = driverod_active_profile.riderod_email)
	#rider_active_profile = RiderActive.objects.get(user_account = r_user)
	rider_reject = None
	if rider_active_profile is not None:
		try:
			rider_reject = driverod_active_profile.rejected_rider.get(user_account = rider_active_profile.user_account)
		except ObjectDoesNotExist:
			print("not rejected yet!")
	if rider_active_profile == rider_reject:
		print("rejected")
	if rider_active_profile is None or rider_active_profile == rider_reject:
		objlist = []
		objdict = {"riderod_email": "no rider matched", "riderod_departure_lat": "no rider matched", "riderod_destination_lat": "no rider matched"}
		objlist.append(objdict)
		objret = json.dumps(objlist)
		print("no rider online")
		return HttpResponse(objret, status=201, content_type='application/json')
		
	riderod_email = rider_active_profile.user_account.email
	riderod_dep_lon = rider_active_profile.riderod_departure_lon
	riderod_dest_lon = rider_active_profile.riderod_destination_lon
	riderod_dep_lat = rider_active_profile.riderod_departure_lat
	riderod_dest_lat = rider_active_profile.riderod_destination_lat
	objlist = []
	objdict = {"riderod_email": riderod_email, "rider_departure_lon": riderod_dep_lon, "rider_destination_lat": riderod_dest_lat,"rider_departure_lat": riderod_dep_lat, "rider_destination_lon": riderod_dest_lon}
	objlist.append(objdict)
	objret = json.dumps(objlist)
	driverod_active_profile.rejected_rider.add(rider_active_profile)
	print("driver email: " + email)
	print("rider email: " + riderod_email)
	return HttpResponse(objret, status=200, content_type='application/json')

@api_view(['POST'])
@parser_classes((JSONParser,))
def driver_ondemand_change(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['driver_email']
	dep_lon = jsonobj['driver_departure_lon']
	dep_lat = jsonobj['driver_departure_lat']
	dest_lon = jsonobj['driver_destination_lon']
	dest_lat = jsonobj['driver_destination_lat']
	#tod = jsonobj['Driverondemand']['driverod_timeofdeparture']
	#just for now
	tod = "default"
	try:
		rideapp = DriverActive.objects.get(driverod_email = email)
	except DriverActive.DoesNotExist:
		return HttpResponse(status=400)
	if rideapp.isactive is False:
		rideapp.isactive = True
	else:
		rideapp.isactive = False
	rideapp.driverod_departure_lon = dep_lon
	rideapp.driverod_departure_lat = dep_lat
	rideapp.driverod_destination_lat = dest_lon
	rideapp.driverod_destination_lon = dest_lat
	rideapp.driverod_timeofdeparture = tod
	if rideapp.driverod_destination_lon is None:
		rideapp.driverod_destination_lon = 0
	if rideapp.driverod_departure_lon is None:
		rideapp.driverod_departure = 0
	rideapp.save()
	return HttpResponse(status=201)

@api_view(['POST'])
@parser_classes((JSONParser,))
def rider_approval(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	trip_id = jsonobj['trip_id']
	rider_email = jsonobj['rider_email']
	rider_approval = jsonobj['rider_approval'] #boolean
	trip = PlannedTrips.objects.get(trip_id=trip_id)
	user = RideProfile.objects.get(email=jsonobj['rider_email'])
	try:
		riderapprove = RiderApproveTrip.objects.get(planned_trip=trip, user_profile = user)
	except RiderApproveTrip.DoesNotExist:
		return Response(status=400)
	if rider_approval is False:
		riderapprove.delete()
	elif rider_approval is True:
		riderapprove.approve = True
	riderapprove.save()
	return HttpResponse(status=201)

@api_view(['POST'])
@parser_classes((JSONParser,))
def get_riders_approved_trips(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['email']
	user = User.objects.get(email = email)
	ride_profile = RideProfile.objects.get(user_account = user)
	rides_approved = RiderApproveTrip.objects.filter(user_profile = ride_profile)
	objlist = []
	for obj in rides_approved:
		objiter = {}
		first_name = user.first_name
		last_name = user.last_name
		driver_departure_longitude = obj.planned_trip.driver_departure_longitude
		driver_departure_latitude = obj.planned_trip.driver_departure_latitude
		driver_destination_longitude = obj.planned_trip.driver_destination_longitude
		driver_destination_latitude = obj.planned_trip.driver_destination_latitude
		driver_timeofdeparture_hour = obj.planned_trip.driver_timeofdeparture_hour
		driver_timeofdeparture_minute = obj.planned_trip.driver_timeofdeparture_minute
		monday = obj.planned_trip.monday
		tuesday = obj.planned_trip.tuesday
		wednesday = obj.planned_trip.wednesday
		thursday = obj.planned_trip.thursday
		friday = obj.planned_trip.friday
		saturday = obj.planned_trip.saturday
		sunday = obj.planned_trip.sunday
		trip_id	 = obj.planned_trip.trip_id
		driver_departure = obj.planned_trip.driver_departure
		driver_destination = obj.planned_trip.driver_destination
		objiter = {"first_name": first_name,"last_name":last_name,"driver_departure_longitude":driver_departure_longitude,"driver_departure_latitude":driver_departure_latitude,"driver_destination_longitude":driver_destination_longitude,"driver_destination_latitude":driver_destination_latitude,"driver_timeofdeparture_hour":driver_timeofdeparture_hour,"driver_timeofdeparture_minute":driver_timeofdeparture_minute,"monday":monday,"tuesday":tuesday,"wednesday":wednesday,"thursday":thursday,"friday":friday,"saturday":saturday,"sunday":sunday,"trip_id":trip_id,"driver_departure":driver_departure,"driver_destination":driver_destination}
		objlist.append(objiter)
	objret = json.dumps(objlist)
	return HttpResponse(objret, status=200, content_type='application/json')

@api_view(['POST'])
@parser_classes((JSONParser,))
def get_riders_on_trip(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	email = jsonobj['email']
	trip_id = jsonobj['trip_id']
	trip = PlannedTrips.objects.get(trip_id=trip_id)
	riderapprove = RiderApproveTrip.objects.filter(planned_trip=trip)
	#ridera_serialize = serializers.serialize('json', riderapprove)
	objlist = []
	for obj in riderapprove:
		objiter = {}
		#needs rider_ for json object
		email = obj.user_profile.email
		firstname = obj.user_profile.rider_firstname
		lastname = obj.user_profile.rider_lastname
		rider_departure_longitude = obj.user_profile.rider_departure_lon
		rider_departure_latitude = obj.user_profile.rider_departure_lat
		rider_destination_longitude = obj.user_profile.rider_destination_lon
		rider_destination_latitude = obj.user_profile.rider_destination_lat
		rider_destination = obj.user_profile.rider_destination
		tod_hour = obj.user_profile.rider_timeofdeparture_hour
		tod_minute = obj.user_profile.rider_timeofdeparture_minute
		rider_departure = obj.user_profile.rider_departure
		rider_destination = obj.user_profile.rider_destination
		approved = obj.approve
		objiter = {"rider_email": email,"rider_firstname":firstname,"rider_lastname":lastname,"rider_departure_longitude":rider_departure_longitude,"rider_departure_latitude":rider_departure_latitude,"rider_destination_longitude":rider_destination_longitude,"rider_destination_latitude":rider_destination_latitude,"rider_timeofdeparture_hour":tod_hour,"rider_timeofdeparture_minute":tod_minute,"rider_approved":approved,"rider_departure":rider_departure,"rider_destination":rider_destination}
		objlist.append(objiter)
	#print(ridera_serialize)
	objret = json.dumps(objlist)
	return HttpResponse(objret,status=201,content_type='application/json')

@api_view(['POST'])
@parser_classes((JSONParser,))
def get_driver_planned_trips(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	tripset = PlannedTrips.objects.filter(driver_email=jsonobj['email'])
	if tripset is None:
		return Response(status=400)
	serializer = PlannedTripSerializer(tripset, many=True)
	return JsonResponse(serializer.data, safe=False, status=201)

@api_view(['POST'])
@parser_classes((JSONParser,))
def ride_join_trip(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	trip = PlannedTrips.objects.get(trip_id=jsonobj['trip_id'])
	if trip is None:
		return Response(status=400)
	rider_profile = RideProfile.objects.get(email = jsonobj['email'])
	rider_profile.desired_trip.add(trip)
	rider_profile.save()
	rider_approve = RiderApproveTrip.objects.filter(user_profile = rider_profile, planned_trip = trip)
	if rider_approve.count() > 0:
		return JsonResponse(jsonobj, status=201)
	else:
		rider_approve = RiderApproveTrip.objects.create(user_profile = rider_profile, planned_trip = trip)
	if rider_approve is None:
		rider_approve.save()
		print("saved join trip")
	return JsonResponse(jsonobj, status=201)

@api_view(['GET'])
@parser_classes((JSONParser,))
def get_all_planned_trips(request):
	tripset = PlannedTrips.objects.all()
	serializer = PlannedTripSerializer(tripset, many=True)
	return JsonResponse(serializer.data, safe=False, status=201)

@api_view(['POST'])
@parser_classes((JSONParser,))
def new_planned_trip(request):
	# # # #serializer = PlannedTripSerializer(data = request.data)
	jsonobj = json.loads(request.body.decode('utf-8'))
	#print(request.data)
	#if serializer.is_valid():
	#	 trip = serializer.save()
	#	 #trip = PlannedTrips.objects.(driver_email=serializer.validated_data['driver_email'])
	#	 user = User.objects.get(email = serializer.validated_data['driver_email'])
	#	 trip.first_name = user.first_name
	#	 trip.last_name = user.last_name
	 #	 trip.trip_id = 1
	#	 trip.save()
	#	 trip.trip_id = trip.id
	#	 trip.save()
	#	return JsonResponse(serializer.validated_data, status=201)
	user = User.objects.get(email = jsonobj['driver_email'])
	trip = PlannedTrips(driver_email=jsonobj['driver_email'])
	trip.first_name = user.first_name
	trip.last_name = user.last_name
	trip.monday = jsonobj['monday']
	trip.tuesday = jsonobj['tuesday']
	trip.wednesday = jsonobj['wednesday']
	trip.thursday = jsonobj['thursday']
	trip.friday = jsonobj['friday']
	trip.saturday = jsonobj['saturday']
	trip.sunday = jsonobj['sunday']
	trip.driver_departure_longitude = jsonobj['driver_departure_longitude']
	trip.driver_departure_latitude = jsonobj['driver_departure_latitude']
	trip.driver_destination_longitude = jsonobj['driver_destination_longitude']
	trip.driver_destination_latitude = jsonobj['driver_destination_latitude']
	trip.driver_timeofdeparture_hour = jsonobj['driver_timeofdeparture_hour']
	trip.driver_timeofdeparture_minute = jsonobj['driver_timeofdeparture_minute']
	trip.driver_departure = jsonobj['driver_departure']
	trip.driver_destination = jsonobj['driver_destination']
	trip.save()
	trip.trip_id = trip.id
	trip.save()
	return HttpResponse(status=200)
	
@api_view(['POST'])
@parser_classes((JSONParser,))
def new_proposed_trip(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	serializer = ProposedTripSerializer(data = request.data)
	trip = ProposedTrips.objects.create()
	trip.save()
	#print(request.data)
	#if serializer.is_valid():
	 #	 trip = serializer.save()
	 #	 trip.trip_id = 1
	 #	 trip.save()
	 #	 trip.trip_id = trip.id
	 #	 trip.save()
		# rider_email  rider_departure rider_destination rider_timeofdeparture
	 #	 riderprofile = RideProfile.objects.get(email = jsonobj['rider_email'])
	 #	 riderprofile.rider_location = jsonobj['rider_departure']
	 #	 riderprofile.rider_destination = jsonobj['rider_destination']
	 #	 riderprofile.rider_timeofdeparture = jsonobj['rider_timeofdeparture']
	 #	 riderprofile.rider_firstname = riderprofile.user_account.first_name
	  #	 riderprofile.rider_lastname = riderprofile.user_account.last_name
	  #	 riderprofile.save()
	  #	 return JsonResponse(serializer.validated_data, status=201)
	#print(serializer.errors)
	trip.rider_email = jsonobj['rider_email']
	trip.monday = jsonobj['monday']
	trip.tuesday = jsonobj['tuesday']
	trip.wednesday = jsonobj['wednesday']
	trip.thursday = jsonobj['thursday']
	trip.friday = jsonobj['friday']
	trip.saturday = jsonobj['saturday']
	trip.sunday = jsonobj['sunday']
	trip.rider_departure_longitude = jsonobj['rider_departure_longitude']
	trip.rider_departure_latitude = jsonobj['rider_departure_latitude']
	trip.rider_destination_longitude = jsonobj['rider_destination_longitude']
	trip.rider_destination_latitude = jsonobj['rider_destination_latitude']
	trip.rider_timeofdeparture_hour = jsonobj['rider_timeofdeparture_hour']
	trip.rider_timeofdeparture_minute = jsonobj['rider_timeofdeparture_minute']
	trip.rider_departure = jsonobj['rider_departure']
	trip.rider_destination = jsonobj['rider_destination']
	trip.save()
	return HttpResponse(status=200)

@api_view(['POST'])
@authentication_classes([])
@permission_classes([])
def user_registration(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	if User.objects.filter(username=jsonobj['email']).exists():
		return HttpResponse(status=400)
	user = User.objects.create_user(first_name = jsonobj['first_name'], last_name = jsonobj['last_name'], email = jsonobj['email'], username = jsonobj['email'])
	user.set_password(jsonobj['password'])
	email = jsonobj['email']
	if email.endswith("ucsc.edu") is False:
		return HttpResponse(status=400)
	first_name = jsonobj['first_name']
	last_name = jsonobj['last_name']
	share_code = jsonobj['share_code']
	userprofile = UserProfile.objects.create(email = email, first_name = first_name, last_name = last_name, point_count = 500, share_code = share_code)
	userprofile.save()
	user.save()
	return HttpResponse(status=201)
		
@api_view(['POST'])
@parser_classes((JSONParser,))
def user_login(request):
	jsonobj = json.loads(request.body.decode('utf-8'))
	print(jsonobj['email'])
	email = jsonobj['email']
	password = jsonobj['password']
	user = authenticate(username=email, password=password)
	if user is not None:
		userprofile = UserProfile.objects.get(email = email)
	else:
		return HttpResponse(status=400)
	objret = {"email": email,"first_name":userprofile.first_name,"last_name":userprofile.last_name,"point_count":userprofile.point_count,"driver_approval":userprofile.driver_approval}
	objrt = json.dumps(objret)
	userprofile.world = None
	try:
		u_active_ride = userprofile.active_ride
		#bandaid this if statement is
		if userprofile.active_ride is not None:
			if userprofile.active_ride.driver_email == userprofile.email:
				userprofile.active_ride.delete()
				userprofile.active_ride = None
				return HttpResponse(objrt, status=200, content_type='application/json')
	except ObjectDoesNotExist:
		userprofile.active_ride = None
	return HttpResponse(objrt, status=200, content_type='application/json')
	
	
	
	
	
