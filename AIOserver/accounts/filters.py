from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from rest_framework import serializers, viewsets,filters
from rest_framework.permissions import IsAuthenticated
from rest_framework import generics
from url_filter.integrations.drf import DjangoFilterBackend

class ItemSubFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            item__author=request.user
        )

class PublicReservationDMFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            reservation__author__public_profile = True
        )
class FollowedReservationDMFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            reservation__author__public_profile = True
        )


class FollowedUserCommentFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__author__followers__author=request.user
        )

class FollowedArticleCommentFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            article__author__followers__author=request.user
        )

class ItemSubFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            item__author=request.user
        )

class MessageSubFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            message__author=request.user
        )


class PublicUserCommentFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__author__public_profile = True
        )

class PublicArticleCommentFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            article__author__public_profile = True
        )


class ProfilePublicUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__public_profile=True
        ).exclude(
            profile__userblocks__profile=request.user
        )   

class AuthorPublicUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__public_profile=True
        ).exclude(
            author__userblocks__profile=request.user
        )   

class FollowedAuthorFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  

class FollowingAuthorFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__followers__author=request.user
        ).exclude(
            profile__userblocks__profile=request.user
        )  


class FollowedUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            followers__profile=request.user
        ).exclude(
            followers__author__userblocks__profile=request.user
        )  

class UserTaggedFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile=request.user
        ) 

class SubuserTaggedFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__parent=request.user
        ) 


class SubUserParentFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__parent=request.user
        )  


class NonGroupArticlesFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user, author__followers__issilent=False
        ).distinct().exclude(
            author__userblocks__profile=request.user)

#.exclude(group=None).



   
class FollowingUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            followers__author=request.user
        )

class SubUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            parent=request.user
        )

class OwnProfileFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            email=request.user
        )

class UserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author=request.user
        )



class UserRequestFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  



class ArticleFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            article__author=request.user
        )

class LikeDislikeFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author=request.user
        )


class UserProductChoiceCategoryFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            category__userproduct__author=request.user
        )




class PublicArticleFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__public_profile=True, author__followers__issilent=False
        ).exclude(
            author__userblocks__profile=request.user
        )
#.filter(group=None).

class PublicArticleofGroupsFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__public_profile=True
        ).filter(
            group__ispublic =True)


class PrivateUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            public_profile=False
        )

class PublicUserFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            public_profile=True
        ).exclude(
            userblocks__author=request.user
        ).exclude(
            userblocks__profile=request.user
        )
   

class UserGroupFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            groupmembers_set__author=request.user
        ).exclude(
            userblocks__profile=request.user
        )   


class PrivateGroupFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            ispublic=False
        )

class PublicGroupFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            ispublic=True
        )


class SubuserRequestFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            profile__parent=request.user
        )

class SubuserArticleFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            article__author__parent=request.user
        )


class PublicCalendarTimeFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__public_profile=True
        ).exclude(
            author__userblocks__profile=request.user
        )  


class FollowedCalendarTimeFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  


class FollowedUserLocationFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  

class FollowedUserPhoneFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  

class FollowedUserMailFilterBackend(filters.BaseFilterBackend):
    
    def filter_queryset(self, request, queryset, view):
        return queryset.filter(
            author__followers__author=request.user
        ).exclude(
            author__userblocks__profile=request.user
        )  
