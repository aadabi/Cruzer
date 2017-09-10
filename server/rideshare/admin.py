from django.contrib import admin
from .models import *

class CustomUserProfile(admin.ModelAdmin):
    search_fields = ['email']
    list_display = ('email','driver_approval','driver_status','active_ride','point_count','world',)
	
class CustomActiveRide(admin.ModelAdmin):
	model = ActiveRide
	search_fields = ['driver_email']
	list_display = ('driver_email','get_name')
	def get_name(self, obj):
		return "test" #obj.userprofile.email
	get_name.admin_order_field  = 'userprofile'  #Allows column order sorting
	get_name.short_description = 'Rider Email'  #Renames column head
	
class CustomRideHistory(admin.ModelAdmin):
	model = RideHistory
	search_fields = ['user']
	list_display = ('get_name','as_driver','rating')
	def get_name(self, obj):
		return obj.user.email
	get_name.admin_order_field  = 'userprofile'  #Allows column order sorting
	get_name.short_description = 'User Email'  #Renames column head

class CustomWeeklyGoals(admin.ModelAdmin):
	model = WeeklyGoals
	search_fields = ['user']
	list_display = ('get_name','goal_total','goal_current','points_reward')
	def get_name(self, obj):
		return obj.user.email
	get_name.admin_order_field  = 'userprofile'  #Allows column order sorting
	get_name.short_description = 'User Email'  #Renames column head

class CustomMonthlyGoals(admin.ModelAdmin):
	model = MonthlyGoals
	search_fields = ['user']
	list_display = ('get_name','goal_total','goal_current','points_reward')
	def get_name(self, obj):
		return obj.user.email
	get_name.admin_order_field  = 'userprofile'  #Allows column order sorting
	get_name.short_description = 'User Email'  #Renames column head

	
admin.site.register(RideHistory, CustomRideHistory)
admin.site.register(UserProfile, CustomUserProfile)
admin.site.register(WorldInstance)
admin.site.register(ActiveRide, CustomActiveRide)
admin.site.register(WeeklyGoals, CustomWeeklyGoals)
admin.site.register(MonthlyGoals, CustomMonthlyGoals)

