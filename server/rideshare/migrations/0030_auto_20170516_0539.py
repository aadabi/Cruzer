# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-16 05:39
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0029_auto_20170322_0106'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='plannedtrips',
            name='driver_departure',
        ),
        migrations.RemoveField(
            model_name='plannedtrips',
            name='driver_destination',
        ),
        migrations.RemoveField(
            model_name='plannedtrips',
            name='driver_timeofdeparture',
        ),
        migrations.AddField(
            model_name='driveractive',
            name='riderod_email',
            field=models.CharField(default='default-ignore', max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='plannedtrips',
            name='driver_departure_longitude',
            field=models.FloatField(default=1122334455, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='plannedtrips',
            name='driver_destination_longitude',
            field=models.FloatField(default=44332211, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='plannedtrips',
            name='driver_timeofdeparture_hour',
            field=models.IntegerField(default=2424),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='rideractive',
            name='has_response',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='rideractive',
            name='has_trip',
            field=models.BooleanField(default=False),
        ),
    ]
