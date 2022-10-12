"""UBIAI_BACKEND URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import json

from django.contrib import admin
from django.http import HttpResponse
from django.urls import path
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt
def get_document_json(request, *args, **kwargs):
    if request.method == 'POST':
        data = json.loads(request.body)
        with open('file.json', 'w') as f:
            f.write(json.dumps(data))
        return HttpResponse(json.dumps({'message': 'successful save'}))


urlpatterns = [
    path('admin/', admin.site.urls),
    path('export_document', get_document_json)
]
