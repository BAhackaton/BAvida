from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from badata.models import *
import string
from django.db import connection, transaction
import math
import time
from time import mktime
from datetime import datetime

class Command(BaseCommand):
    
    def integrate(self, items):
        
        a = 0
        total_items = len(items)
        
        for item in items:
            a += math.pow(10,(int(item) / 10))
        
        integration = 10 * math.log( (1.0 / total_items) * a, 10)

        return integration
    
    def average(self, tmi, sday, vday, vnight):
        
        int_day = self.integrate(vday)
        int_night = self.integrate(vnight)
        
        day = dt = datetime.fromtimestamp(mktime(time.strptime(sday,'%d/%m/%Y')))
        
        #self.stdout.write("Day %s - Night %s \n" % (int_day, int_night))
        
        dnoise = DailyNoise(tmi = tmi, day = day, avg_day = int_day, avg_night = int_night)
        dnoise.save()
        
        
    def process_hourly_values(self):
        cursor = connection.cursor()
        cursor.execute("SELECT distinct(tmi) from badata_noise")
        
        for row in cursor.fetchall():
            
            tmi = row[0]
            noises = Noise.objects.filter(tmi = tmi).order_by("day","time")
            
            current_day = None
            
            night = []
            day = []
            
            for noise in noises:
                
                if current_day == None or current_day != noise.day:
                    
                    if current_day: #We changed date, compute
                        self.stdout.write(str(tmi) + " " + str(current_day) + "\n")
                        if len(day) > 0 and len(night) > 0:
                            self.average(tmi, current_day, day,night)
                        night = []
                        day = []                        

                    current_day = noise.day
                                    
                if noise.avg_energy_time and noise.avg_energy_time != '': #Avoid empty values
                    try:
                        value = int(noise.avg_energy_time)
                        if noise.time <= '06:00' or noise.time >= '22:00':                    
                            night.append(value)
                        else:
                            day.append(value)
                    except:
                        pass
    
    def process_daily_values(self):
        cursor = connection.cursor()
        cursor.execute("SELECT distinct(tmi) from badata_dailynoise")

        for row in cursor.fetchall():

            tmi = row[0]
            noises = DailyNoise.objects.filter(tmi = tmi).order_by("day")

            night = []
            day = []

            for noise in noises:
                
                day.append(noise.avg_day)
                night.append(noise.avg_night)
                
            int_day = self.integrate(day)
            int_night = self.integrate(night)
        
            ynoise = YearlyNoise(tmi = tmi, avg_day = int_day, avg_night = int_night)
            ynoise.save()
            

    def handle(self, *args, **options):
        
        #process_hourly_values()
        self.process_daily_values()
                
                
                