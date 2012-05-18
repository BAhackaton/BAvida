from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from badata.models import *
import string
from django.db import connection, transaction
import math
import time
from time import mktime
from datetime import datetime
from lxml import etree
from badata.models import Park

class Command(BaseCommand):
    
    def fast_iter(self,context, func):
        # http://www.ibm.com/developerworks/xml/library/x-hiperfparse/
        # Author: Liza Daly
        current_park = None
        for event, elem in context:            
            current_park = func(elem, current_park)
            elem.clear()
            while elem.getprevious() is not None:
                del elem.getparent()[0]
        del context

    def process_element(self, elem, current_park):
        if elem.tag == 'Placemark' and current_park and current_park.name != None:            
            current_park.save()
        elif elem.tag == 'SimpleData':
            if elem.get('name') == 'ESPACIO1':
                if elem.text:
                    current_park = Park(category = elem.text.capitalize())
                else:
                    current_park = None
            if elem.get('name') == 'NOMBRE' and current_park:
               current_park.name = elem.text
            if elem.get('name') == 'AREA' and current_park:
                current_park.area = elem.text
        elif elem.tag == 'coordinates' and current_park:
                latlon = elem.text.partition(',')
                current_park.lat = latlon[2]
                current_park.lon = latlon[0]
        
        return current_park
    
    def handle(self, *args, **options):
    
        context = etree.iterparse( '/Users/gstock/Downloads/badata/centroides.kml')
        self.fast_iter(context,self.process_element)
        
        