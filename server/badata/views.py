from django.http import HttpResponse
import json
from badata.models import *
from django.core import serializers

def value_bike(bikestations):
    
    qty = len(list(bikestations))
    if qty > 0:
        min_dist = bikestations[0].distance
    else:
        return 0 , 0

    #print str(min_dist) + " " + str(qty)
    return [int(100 / min_dist * qty), round(min_dist,2)]
    
def value_noise(yearlynoises):
    qty = len(list(yearlynoises))
    if qty > 0:
        min_dist = yearlynoises[0].distance
        avg_day = yearlynoises[0].avg_day
    else:
        return 0

    value = 0
    
    if avg_day < 50:
        value = 50
    elif avg_day >= 50 and avg_day < 60:
        value = 60
    elif avg_day >= 60 and avg_day < 65:
        value = 70
    elif avg_day >= 65 and avg_day < 70:
        value = 80
    elif avg_day >= 70 and avg_day < 75:
        value = 90
    elif avg_day >= 75:
        value = 100

    return value * -1
    

def getdata(request):
    lat = float(request.GET['lat'])
    lon = float(request.GET['lon'])
    dis = float(request.GET['dis'])
    bikestation = BikeStation.find_from_point(lat, lon, dis)
    yearlynoise = YearlyNoise.find_from_point(lat, lon, dis)

    vbike, min_dis = value_bike(bikestation)
    vnoise = value_noise(yearlynoise)
    
    #print vbike
    #print vnoise
    
    # http://www.tweetworldapp.com.ar/temp/bicing.png
    # http://www.tweetworldapp.com.ar/temp/sound.png
    # http://www.tweetworldapp.com.ar/temp/park.png
    
    noise = Category(name = 'Ruido', desc = 'Hay mucho ruido?', value = vnoise, thumb = 'http://www.tweetworldapp.com.ar/temp/sound.png')
    bikes = Category(name = 'Bicis', desc = 'La bicicleta mas cercana esta a: %s mts' % (min_dis*1000), value = vbike, thumb = 'http://www.tweetworldapp.com.ar/temp/bicing.png')
    
    
    categories = {
        'noise' : noise.__dict__,
        'bikes' : bikes.__dict__    
    }

    response = {'categories' : categories}

    data = json.dumps(response)

    #data = serializers.serialize("json", categories)
    return HttpResponse(data, mimetype="application/json")


    