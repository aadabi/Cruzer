# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-16 21:42
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0008_proposedtrips'),
    ]

    operations = [
        migrations.AddField(
            model_name='plannedtrips',
            name='first_name',
            field=models.CharField(default='default', max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='plannedtrips',
            name='last_name',
            field=models.CharField(default='default', max_length=100),
            preserve_default=False,
        ),
    ]