from django.conf.urls import url
from django.conf import settings
from django.conf.urls.static import static

from rideshare import views
from rest_framework.authtoken import views as rest_framework_views

urlpatterns = [
    url(r'^rideshare/user_registration/$', views.user_registration),
    url(r'^rideshare/user_login/$', views.user_login),
    url(r'^rideshare/new_planned_trip/$', views.new_planned_trip),
    url(r'^rideshare/new_proposed_trip/$', views.new_proposed_trip),
    url(r'^rideshare/get_all_planned_trips/$', views.get_all_planned_trips),
    url(r'^rideshare/ride_join_trip/$', views.ride_join_trip),
    url(r'^rideshare/get_driver_planned_trips/$', views.get_driver_planned_trips),
    url(r'^rideshare/get_riders_on_trip/$', views.get_riders_on_trip),
    url(r'^rideshare/rider_approval/$', views.rider_approval),
    url(r'^rideshare/driver_ondemand_change/$', views.driver_ondemand_change),
    url(r'^rideshare/driver_ondemand_get_rider/$', views.driver_ondemand_get_rider),
    url(r'^rideshare/decide_rider_ondemand/$', views.decide_rider_ondemand),
    url(r'^rideshare/rider_ondemand/$', views.rider_ondemand),
    url(r'^rideshare/rider_getdrivers_ondemand/$', views.rider_getdrivers_ondemand),
    url(r'^rideshare/rider_request_driver/$', views.rider_request_driver),
    url(r'^rideshare/get_driver_response_ondemand/$', views.get_driver_response_ondemand),
    url(r'^rideshare/get_riders_approved_trips/$', views.get_riders_approved_trips),
	url(r'^rideshare/post_ride/$', views.post_ride),
	url(r'^rideshare/query_ride/$', views.query_ride),
	url(r'^rideshare/scan_qr_code/$', views.scan_qr_code),
	url(r'^rideshare/end_ride/$', views.end_ride),
	url(r'^rideshare/rate_user/$', views.rate_user),
	url(r'^rideshare/driver_info_submit/$', views.driver_info_submit),
	url(r'^rideshare/account_info/$', views.account_info),
	url(r'^rideshare/edit_account_info/$', views.edit_account_info),
	url(r'^rideshare/buy_points/$', views.buy_points),
	url(r'^rideshare/goal_info/$', views.goal_info),
	url(r'^rideshare/forgot_password/$', views.forgot_password),
	url(r'^rideshare/get_auth_token/$', rest_framework_views.obtain_auth_token, name='get_auth_token'),
    url(r'^rideshare/get_arity_trip_data/$', views.get_arity_trip_data),
]