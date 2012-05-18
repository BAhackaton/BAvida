from django.db import models

class GeoModel(models.Model):
    lat = models.FloatField(null=True)
    lon = models.FloatField(null=True)
    distance = False
    
    class Meta:
        abstract = True
    
    @classmethod
    def find_from_point(cls,lat,lon, dis = 10):
        
        table = cls._meta.db_table
        
        query = """SELECT *,
        ((ACOS(SIN(%s * PI() / 180) * SIN(lat * PI() / 180) + COS(%s * PI() / 180) * COS(lat * PI() / 180) * COS((%s - lon) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) * 1.6 as distance
        FROM """ + table + " HAVING distance <= %s ORDER BY distance ASC " 
        
        return cls.objects.raw(query, [lat, lat, lon, dis])

class YearlyNoise(GeoModel):
    tmi = models.IntegerField()
    avg_day = models.FloatField()
    avg_night = models.FloatField()

class DailyNoise(models.Model):
    tmi = models.IntegerField()
    day = models.DateField()
    avg_day = models.FloatField()
    avg_night = models.FloatField()

class Noise(models.Model):
    tmi = models.IntegerField()
    day = models.CharField(max_length=25)
    time = models.CharField(max_length=25)
    avg_energy_time = models.CharField(max_length=25)
    
class Air(models.Model):
    station = models.CharField(max_length=25)
    pollutant = models.CharField(max_length=25)
    day = models.CharField(max_length=25)
    time = models.IntegerField()
    avg_level = models.IntegerField()

    
class BikeStation(GeoModel):        
    name = models.CharField(max_length=25)
    street_name = models.CharField(max_length=50)
    street_number = models.IntegerField()
    street_floor = models.CharField(max_length=25)
    street_apt = models.CharField(max_length=25)   
    zip_code = models.CharField(max_length=25)
    country_id = models.IntegerField()
    state_id = models.IntegerField()
    city_id = models.CharField(max_length=25)
    street_near_1 = models.CharField(max_length=25) 
    street_near_2 = models.CharField(max_length=25) 
    phone_area  = models.CharField(max_length=25)    
    phone_number  = models.CharField(max_length=25) 
    phone_area_2   = models.CharField(max_length=25)
    phone_number_2 = models.CharField(max_length=25)
    min_bike = models.IntegerField()
    max_bike = models.IntegerField()
    helmets = models.CharField(max_length=25)       
    create_dated = models.CharField(max_length=25)  
    #lat = models.CharField(max_length=25)           
    #lon = models.CharField(max_length=25)

class Park(GeoModel):
    name = models.CharField(max_length=100)
    category = models.CharField(max_length=50)
    area = models.FloatField()

    
class Category:
    
    def __init__(self, name, desc, value, thumb):
    
        self.name = name
        self.desc = desc
        self.value = value
        self.thumb = thumb
    