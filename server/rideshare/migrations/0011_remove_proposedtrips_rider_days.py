# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-16 23:40
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0010_remove_plannedtrips_driver_days'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='proposedtrips',
            name='rider_days',
        ),
    ]