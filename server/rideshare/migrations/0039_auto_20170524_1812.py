# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-24 18:12
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0038_auto_20170524_1747'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='rideprofile',
            name='rider_timeofdeparture',
        ),
        migrations.AddField(
            model_name='rideprofile',
            name='rider_timeofdeparture_hour',
            field=models.IntegerField(default=24),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='rideprofile',
            name='rider_timeofdeparture_minute',
            field=models.IntegerField(default=60),
            preserve_default=False,
        ),
    ]
