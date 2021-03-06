# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-16 05:57
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0031_auto_20170516_0542'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='proposedtrips',
            name='rider_departure',
        ),
        migrations.RemoveField(
            model_name='proposedtrips',
            name='rider_destination',
        ),
        migrations.RemoveField(
            model_name='proposedtrips',
            name='rider_timeofdeparture',
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_departure_latitude',
            field=models.FloatField(default=123123, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_departure_longitude',
            field=models.FloatField(default=321321, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_destination_latitude',
            field=models.FloatField(default=123123, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_destination_longitude',
            field=models.FloatField(default=321321, max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_timeofdeparture_hour',
            field=models.IntegerField(default=2424),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='proposedtrips',
            name='rider_timeofdeparture_minute',
            field=models.IntegerField(default=5959),
            preserve_default=False,
        ),
    ]
