from rest_framework import serializers
from django.contrib.auth.models import User
from rideshare.models import *
import json

class PlannedTripSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField(required=False)
    last_name = serializers.CharField(required=False)
    class Meta:
        model = PlannedTrips
        fields = ('trip_id','first_name','last_name','driver_email','driver_departure_longitude','driver_departure_latitude','driver_destination_longitude','driver_destination_latitude','driver_timeofdeparture_hour','driver_timeofdeparture_minute','monday','tuesday','wednesday','thursday','friday','saturday','sunday','driver_departure','driver_destination')
    
    def create(self, validated_data):
        return PlannedTrips.objects.create(**validated_data)
        
class ProposedTripSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProposedTrips
        fields = ('id','rider_email','rider_departure','rider_destination','rider_timeofdeparture','monday','tuesday','wednesday','thursday','friday','saturday','sunday',)
    
    def create(self, validated_data):
        return ProposedTrips.objects.create(**validated_data)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'first_name', 'last_name', 'email', 'password',)

    def create(self, validated_data):
        return User.objects.create(**validated_data)
        
    def update(self, instance, validated_data):
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.email = validated_data.get('email', instance.email)
        instance.password = validated_data.get('password', instance.password)
        instance.save()
        return instance
        
class UserLoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('email', 'password',)
        
        
