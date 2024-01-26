from django.urls import path, include
from rest_framework import permissions
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import re_path as url
from django.contrib.staticfiles.urls import static
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.conf.urls.static import static
from django.conf import settings
from accounts import views
from rest_framework.authtoken import views

urlpatterns = [
    path('rest-framework/', include('rest_framework.urls')),
    path('api/', include('accounts.urls')),
    path('admin/', admin.site.urls),
    url(r'^rest-auth/',  views.obtain_auth_token),
]
if settings.DEBUG:
    urlpatterns += static(
        settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
elif getattr(settings, 'FORCE_SERVE_STATIC', False):
    settings.DEBUG = True
    urlpatterns += static(
        settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(
        settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    settings.DEBUG = False
