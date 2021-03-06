# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-17 05:55
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0034_auto_20170516_0702'),
    ]

    operations = [
        migrations.AlterField(
            model_name='driveractive',
            name='driverod_departure_lat',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='driveractive',
            name='driverod_departure_lon',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='driveractive',
            name='driverod_destination_lat',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='driveractive',
            name='driverod_destination_lon',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_departure_latitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_departure_longitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_destination_latitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_destination_longitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_timeofdeparture_hour',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='plannedtrips',
            name='driver_timeofdeparture_minute',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_departure_latitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_departure_longitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_destination_latitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_destination_longitude',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_timeofdeparture_hour',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='proposedtrips',
            name='rider_timeofdeparture_minute',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='rideractive',
            name='riderod_departure_lat',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='rideractive',
            name='riderod_departure_lon',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='rideractive',
            name='riderod_destination_lat',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='rideractive',
            name='riderod_destination_lon',
            field=models.FloatField(blank=True, max_length=200, null=True),
        ),
    ]
