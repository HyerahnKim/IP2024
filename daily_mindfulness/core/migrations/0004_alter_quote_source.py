# Generated by Django 5.0.6 on 2024-12-17 18:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_alter_tracker_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='quote',
            name='source',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
