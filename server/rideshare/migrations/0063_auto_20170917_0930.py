# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-09-17 09:30
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('rideshare', '0062_auto_20170917_0900'),
    ]

    operations = [
        migrations.RenameField(
            model_name='arityride',
            old_name='arityride',
            new_name='user',
        ),
    ]
