from accounts.models import ReservationDeactivationMonth,BoughtItemChoice,RequestItem,RequestItemChoice,CartItem,CartItemChoice,BoughtCheck,User,ArticleDislike,UserDislike,RequestImage,RequestForm,RequestCheckbox,UserView,Request,Article,ArticleImage,ArticleSharedImage,ArticleBookmark,ArticleVideo,ArticleTag,ArticleView,ArticleLike,ArticleUserTag,ArticleComment,CalendarDate,CalendarSchedule,UserReport,UserMessage,UserBlock,UserTag,UserComment,UserFollow,UserLike,UserImage,UserPhone,UserLocation,UserMail,ArticleSharedVideo,CalendarTime,UserCalendarType,CalendarStatus,ArticleCommentDislike,UserCommentDislike,ArticleCommentLike,UserCommentLike,ArticleCategory,ArticleChoiceCategory,ArticleChoice,ArticleForm,ArticleCheckbox,ReservationSchedule,UserMessageVideo,UserMessageImage,UserCartItem,ArticleActivity,ArticleHighlight,ArticleTravelLocation,BusinessType,ArticleAmenity,ArticleDetailCategory,ArticleDetailIncluded,ArticleDetailRule,ArticleDetailSpec,ItemType,UserOpeningHour,MeetingSchedule,MeetingStatus
from django.contrib.auth import authenticate
from django.contrib.auth.models import update_last_login
import datetime as dt
from datetime import datetime
from django.core import serializers
from rest_framework import serializers
from urllib import request
from rest_framework import routers, serializers, viewsets
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse
from rest_framework.exceptions import ValidationError
from django.utils.timezone import now

class BoughtItemChoiceSerializer(serializers.ModelSerializer):

    class Meta:
        model = BoughtItemChoice
        fields = ("id","item","choice","category","timestamp","price")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['item'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class ArticleActivitySerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleActivity
        fields = ("id","article","activity","starttime","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ArticleHighlightSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleHighlight
        fields = ("id","article","highlight","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class MeetingScheduleSerializer(serializers.ModelSerializer):

    class Meta:
        model = MeetingSchedule
        fields = ("id","author","profile","date","time","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class MeetingStatusSerializer(serializers.ModelSerializer):

    class Meta:
        model = MeetingStatus
        fields = ("id","author","dates","times","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        
        raise ValidationError('Unauthorized Request')

class ArticleTravelLocationSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleTravelLocation
        fields = ("id","article","location","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class BusinessTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = BusinessType
        fields = ("id","businesstype","timestamp")

class ArticleAmenitySerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleAmenity
        fields = ("id","article","amenity","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ArticleDetailCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleDetailCategory
        fields = ("id","article","category","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ItemTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = ItemType
        fields = ("id","itemtype","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')

class ArticleDetailIncludedSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleDetailIncluded
        fields = ("id","article","included","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ArticleDetailRuleSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleDetailRule
        fields = ("id","article","rule","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ArticleDetailSpecSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleDetailSpec
        fields = ("id","article","category","spec","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class UserOpeningHourSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserOpeningHour
        fields = ("id","article","isalwaysopen","ispermanentlyclosed","profile","username","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')

class BoughtCheckSerializer(serializers.ModelSerializer):
    boughtcheckchoices_set = BoughtItemChoiceSerializer(source='boughtcheckchoices',required=False,many=True) 

    class Meta:
        model = BoughtCheck
        fields =("id","author","owner","price","item","deliverytime","count","link","type","specialrequest",
"category","boughtcheckchoices_set","deliveryfee","deliverytype","contact","fullname",
"deliverydate","deliveryaddress")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class UserCartItemSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserCartItem
        fields = ("id","author","link","count","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class ArticleCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleCategory
        fields = ("id","author","category","image","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        
        raise ValidationError('Unauthorized Request')



class ArticleChoiceCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleChoiceCategory
        fields = ("id","userproduct","allchooseable","category","timestamp","image")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class ArticleChoiceSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleChoice
        fields = ("id","category","article","timestamp","image","item","price","isbuyenabled","allowstocks","stock")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['userproduct'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class ArticleFormSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleForm
        fields = ("id","article","hint","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')


class ArticleCheckboxSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleCheckbox
        fields = ("id","article","hint","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ReservationScheduleSerializer(serializers.ModelSerializer):

    class Meta:
        model = ReservationSchedule
        fields = ("id","author","profile","reservation","startdate","enddate","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class ReservationDeactivationMonthSerializer(serializers.ModelSerializer):

    class Meta:
        model = ReservationDeactivationMonth
        fields = ("id","author","startdate","enddate","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class RequestItemChoiceSerializer(serializers.ModelSerializer):

    class Meta:
        model = RequestItemChoice
        fields = ("id","request","choice","category","timestamp","price")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['item'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class CartItemChoiceSerializer(serializers.ModelSerializer):
   

    class Meta:
        model = CartItemChoice
        fields = ("id","item","choice","category","timestamp","price")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['item'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class RequestItemSerializer(serializers.ModelSerializer):

    
    class Meta:
        model = RequestItem
        fields = ("id","author","item","link","type","timestamp","count","price")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class CartItemSerializer(serializers.ModelSerializer):
    cartitemchoices_set = CartItemChoiceSerializer(source='cartitemchoices',required=False,many=True) 

    class Meta:
        model = CartItem
        fields = ("id","author","owner","item","link","isfood","foodbusinesstype","type","timestamp","count","price","cartitemchoices_set")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs




class UserMessageVideoSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserMessageVideo
        fields = ("id","author","message","video","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserMessageImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserMessageImage
        fields = ("id","author","message","image","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class ArticleFIOSerializer(serializers.ModelSerializer):

    class Meta:
        model = Article
        fields = ("id","timestamp")

class ArticleCommentLikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleCommentLike
        fields = ('id',"author","article",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserCommentLikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserCommentLike
        fields = ('id',"author","profile",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class ArticleCommentDislikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleCommentDislike
        fields = ('id',"author","article",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserCommentDislikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserCommentDislike
        fields = ('id',"author","profile",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs




class ArticleCommentSerializer(serializers.ModelSerializer): 
    likes = serializers.SerializerMethodField(read_only=True)
    dislikes = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ArticleComment
        fields = ('id','content','article','author','parent','likes','dislikes','category','timestamp')

    def get_likes(self, language):
        return language.articlecommentlikes.count()

    def get_dislikes(self, language):
        return language.articlecommentdislikes.count()

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class UserCommentSerializer(serializers.ModelSerializer): 
    likes = serializers.SerializerMethodField(read_only=True)
    dislikes = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = UserComment
        fields = ('id','content','timestamp','profile','likes','dislikes','author','parent','category')


    def get_likes(self, language):
        return language.usercommentlikes.count()

    def get_dislikes(self, language):
        return language.usercommentdislikes.count()

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class ArticleDislikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleDislike
        fields = ('id',"author","article",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserDislikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserDislike
        fields = ('id',"author","profile",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs




class ArticleUserTagSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleUserTag
        fields = ("id","article","profile","username","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')



class ArticleSharedImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleSharedImage
        fields = ("id","image","article")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class ArticleSharedVideoSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleSharedVideo
        fields = ("id","video","article")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')

class CalendarTimeSerializer(serializers.ModelSerializer):

    class Meta:
        model = CalendarTime
        fields = ("id","author","allowstocks","stock","time","date","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')

class CalendarDateSerializer(serializers.ModelSerializer):

    class Meta:
        model = CalendarDate
        fields = ("id","author","date","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')

class CalendarStatusSerializer(serializers.ModelSerializer):

    class Meta:
        model = CalendarStatus
        fields = ("id","author","dates","items","times","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        
        raise ValidationError('Unauthorized Request')

class CalendarScheduleSerializer(serializers.ModelSerializer):

    class Meta:
        model = CalendarSchedule
        fields = ("id","author","profile","item","date","time","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class RequestImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = RequestImage
        fields = ("id","request","image","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['request'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class RequestFormSerializer(serializers.ModelSerializer):

    class Meta:
        model = RequestForm
        fields = ("id","request","hint","content","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['request'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class RequestCheckBoxSerializer(serializers.ModelSerializer):

    class Meta:
        model = RequestCheckbox
        fields = ("id","request","hint","boolean","timestamp")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['request'].author.id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class RequestSerializer(serializers.ModelSerializer):
    requestchoices_set = RequestItemChoiceSerializer(source='requestchoices',required=False,many=True) 
    requestcheckboxes_set = RequestCheckBoxSerializer(source='requestcheckboxes',required=False,many=True)  
    requestforms_set = RequestFormSerializer(source='requestforms',required=False,many=True)  
    requestimages_set = RequestImageSerializer(source='requestimages',required=False,many=True)  


    class Meta:
        model = Request
        fields = ("id","author","profile","item","date","time","count","price","deliveryaddress","requestchoices_set","contact","deliverydate","deliverytype","fullname","reason","isaccepted","isdenied","clientnow","requestcheckboxes_set","requestforms_set","requestimages_set","link","requesttype","timestamp","buycategory")
#"group",

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        elif attrs['profile'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')



class UserReportSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserReport
        fields = ("id","article","profile","content","timestamp")


class UserBlockSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserBlock
        fields = ("id","author","profile")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class UserMailSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserMail
        fields = ("id","author","mail")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class UserTagSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserTag
        fields  = ('id','tag','author')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class UserImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserImage
        fields  = ('id','author','image')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserPhoneSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserPhone
        fields  = ('id','author','phone','phonename','iswp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserLocationSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserLocation
        fields  = ('id','author','location','locationname')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class ArticleImageSerializer(serializers.ModelSerializer):
  
    class Meta:
        model = ArticleImage
        fields = ('id','image','article')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')



class ArticleVideoSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = ArticleVideo
        fields = ('id','video','article')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')



class ArticleTagSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleTag
        fields = ('id','article','tag')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['article'].author.id == self.context['request'].user.pk:
            return attrs

        raise ValidationError('Unauthorized Request')
 

class ArticleLikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleLike
        fields = ('id',"author","article",'timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class ArticleViewSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleView
        fields = ('id',"article","author")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs


class ArticleBookmarkSerializer(serializers.ModelSerializer):

    class Meta:
        model = ArticleBookmark
        fields = ('id',"article","author")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class UserMessageSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserMessage
        fields = ('id','author','content','profile','timestamp')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs

class UserViewSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserView
        fields = ('id',"profile","author")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')
        return attrs



class UserFollowSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserFollow
        fields = ('id',"author","profile","issilent")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs['author'].id != self.context['request'].user.pk) and (attrs['profile'].public_profile == True):
            raise ValidationError('Unauthorized Request')
        elif (attrs['profile'].id != self.context['request'].user.pk) and (attrs['profile'].public_profile == False):
            raise ValidationError('Unauthorized Request')
        return attrs
                

class UserLikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserLike
        fields = ('id',"author","profile")

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id != self.context['request'].user.pk:
            raise ValidationError('Unauthorized Request')

        return attrs


class ArticleSerializer(serializers.ModelSerializer):

    articleimages_set = ArticleImageSerializer(source='articleimages',required=False,many=True)  
    articlevideos_set = ArticleVideoSerializer(source='articlevideos',required=False,many=True)
    articletags_set = ArticleTagSerializer(source='articletags',required=False,many=True)
    articleusertags_set = ArticleUserTagSerializer(source='articleusertags',required=False,many=True)
    articlechoicecategories_set = ArticleChoiceCategorySerializer(source='articlechoicecategories',required=False,many=True) 
    articlechoices_set = ArticleChoiceSerializer(source='articlechoices',required=False,many=True) 
    articlecheckboxes_set = ArticleCheckboxSerializer(source='articlecheckboxes',required=False,many=True) 
    articleforms_set = ArticleFormSerializer(source='articleforms',required=False,many=True) 
    likes = serializers.SerializerMethodField(read_only=True)
    dislikes = serializers.SerializerMethodField(read_only=True)
    comments = serializers.SerializerMethodField(read_only=True)
    views = serializers.SerializerMethodField(read_only=True)
    articledetailspecs_set = ArticleDetailSpecSerializer(source='articledetailspecs',required=False,many=True)
    articledetailrules_set = ArticleDetailRuleSerializer(source='articledetailrules',required=False,many=True)
    articledetailincludeds_set = ArticleDetailIncludedSerializer(source='articledetailincludeds',required=False,many=True)
    articledetailcategories_set = ArticleDetailCategorySerializer(source='articledetailcategories',required=False,many=True)
    articleamenities_set = ArticleAmenitySerializer(source='articleamenities',required=False,many=True)
    articletravellocations_set = ArticleTravelLocationSerializer(source='articletravellocations',required=False,many=True)
    articlehighlights_set = ArticleHighlightSerializer(source='articlehighlights',required=False,many=True)
    articleactivities_set = ArticleActivitySerializer(source='articleactivities',required=False,many=True)


    class Meta:
        model = Article
        fields = ('id','author','timestamp','category',"locationcountry","locationstate","locationcity"
,'caption','details','allowcomments','anonymity','nsfw','nstl','sensitive','spoiler','hasImage','type',
'isjobposting','articlechoicecategories_set','articlechoices_set','articlecheckboxes_set','articleforms_set','listcategory','productcondition','articleimages_set','originalarticle','articlevideos_set','articletags_set','deliveryfee','isdelivered','etatime','hideifoutofstock','isforstay','checkintime','checkouttime','startdate','enddate','readtime','deliveredfromtime','deliveredtotime','specialinstructions','guide','adults','kids','bedrooms','bathrooms','pricecurrency','pricetype','isquestion','articledetailspecs_set','articledetailrules_set','articledetailincludeds_set','articledetailcategories_set','articleamenities_set','articletravellocations_set','articlehighlights_set','articleactivities_set',
    'time','date','allowstocks','isbuyenabled','stock','category',
    'listcategory','deliveryfee','ishighlighted','etatime','isdelivered',
'articleusertags_set','likes','dislikes','comments','views')



    def get_likes(self, language):
        return language.articlelikes.count()

    def get_dislikes(self, language):
        return language.articledislikes.count()

    def get_comments(self, language):
        return language.articlecomments.count()

    def get_views(self, language):
        return language.articleviews.count()

class UserMessageCountSerializer(serializers.ModelSerializer):
    usermessages = serializers.SerializerMethodField(read_only=True)
    usermessages_set = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields  = ('id','usermessages','usermessages_set')

    def get_usermessages(self, language):
        return language.usermessages.count()

    def get_usermessages_set(self, language):
        return language.usermessages_set.count()


    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs.get('parent') == None) and (attrs.get('id') == self.context['request'].user.pk):
            return attrs
        elif (attrs.get('parent') != None) and (attrs.get('parent').id != self.context['request'].user.pk):
            raise ValidationError('Unauthorized Request')
        return attrs

class UserGetMessageSerializer(serializers.ModelSerializer):
    usermessages = UserMessageSerializer(source='usermessages_set',required=False,many=True)
    usermessages_set = UserMessageSerializer(source='usermessages',required=False,many=True)
    class Meta:
        model = User
        fields  = ('id','usermessages','usermessages_set')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs.get('parent') == None) and (attrs.get('id') == self.context['request'].user.pk):
            return attrs
        elif (attrs.get('parent') != None) and (attrs.get('parent').id != self.context['request'].user.pk):
            raise ValidationError('Unauthorized Request')
        return attrs



class UserSerializer(serializers.ModelSerializer):
    meetingstatuses_set = MeetingStatusSerializer(source='meetingstatuses',required=False,many=True)
    meetingschedules_set = MeetingScheduleSerializer(source='meetingschedules',required=False,many=True)
    usertags_set = UserTagSerializer(source='usertags',required=False,many=True)
    userblocks_set = UserBlockSerializer(source='userblocks',required=False,many=True)
    userbookmarks_set = ArticleBookmarkSerializer(source='userbookmarks',required=False,many=True)
    calendarschedules_set = CalendarScheduleSerializer(source='calendarschedules',required=False,many=True)
    reservationschedules_set = ReservationScheduleSerializer(source='reservationschedules',required=False,many=True)
    calendarstatuses_set = CalendarStatusSerializer(source='calendarstatuses',required=False,many=True)
    reservationdeactivationmonths_set = ReservationDeactivationMonthSerializer(source='reservationdeactivationmonths',required=False,many=True)
    useropeninghours_set = UserOpeningHourSerializer(source='useropeninghours',required=False,many=True)
    following = serializers.SerializerMethodField(read_only=True)
    followers = serializers.SerializerMethodField(read_only=True)
    likes = serializers.SerializerMethodField(read_only=True)
    dislikes = serializers.SerializerMethodField(read_only=True)
    comments = serializers.SerializerMethodField(read_only=True)
    usermessages = UserMessageSerializer(source='usermessages_set',required=False,many=True)
    usermessages_set = UserMessageSerializer(source='usermessages',required=False,many=True)
    cartitems_set = CartItemSerializer(source='cartitems',required=False,many=True)


    class Meta:
        model = User
        fields  = ('id','email','username','password','fullname','isdetailsprivate','public_profile',
'online','open_now','phone_number','details',"locationcountry","locationstate","locationcity",'image','useropeninghours_set','meetingschedules_set','meetingstatuses_set',
'businessstatus','pricerange','business_type','sign_up_date','intensity','issubusersallowed','last_login','reservationschedules_set',
'isprofileanon','birth_date','isnsfwallowed','isnstlallowed','issensitiveallowed','isspoilerallowed','reservationdeactivationmonths_set','ishotel','hotelclass',
'calendar_type','calendar_ismultichoice','likes','wifiname','wifipassword','dislikes','comments','following','followers','usermessages','usermessages_set',
'user_type','parent','userblocks_set','usertags_set','userbookmarks_set','cartitems_set','calendarstatuses_set','calendarschedules_set','gatewayname','gatewaymerchantid','merchantid','merchantname')

    def get_following(self, language):
        return language.following.count()

    def get_followers(self, language):
        return language.followers.count()

    def get_likes(self, language):
        return language.userlikes.count()

    def get_dislikes(self, language):
        return language.userdislikes.count()

    def get_comments(self, language):
        return language.usercomments.count()

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs.get('parent') == None) and (attrs.get('id') == self.context['request'].user.pk):
            return attrs
        elif (attrs.get('parent') != None) and (attrs.get('parent').id != self.context['request'].user.pk):
            raise ValidationError('Unauthorized Request')
        return attrs

class PrivateUserSerializer(serializers.ModelSerializer):
    following = serializers.SerializerMethodField(read_only=True)
    followers = serializers.SerializerMethodField(read_only=True)
    likes = serializers.SerializerMethodField(read_only=True)
    dislikes = serializers.SerializerMethodField(read_only=True)


    class Meta:
        model = User
        fields  = ('id','email','username','password','followers','likes','dislikes','following','fullname','isdetailsprivate','public_profile','details',"locationcountry","locationstate","locationcity",'image','business_type','sign_up_date','last_login','birth_date',)

    def get_following(self, language):
        return language.following.count()

    def get_followers(self, language):
        return language.followers.count()

    def get_likes(self, language):
        return language.userlikes.count()

    def get_dislikes(self, language):
        return language.userdislikes.count()


    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs.get('parent') == None) and (attrs.get('id') == self.context['request'].user.pk):
            return attrs
        elif (attrs.get('parent') != None) and (attrs.get('parent').id != self.context['request'].user.pk):
            raise ValidationError('Unauthorized Request')
        return attrs


class RegisterUserSerializer(serializers.ModelSerializer):



    class Meta:
        model = User
        fields  = ('id','email','username','password','fullname','isdetailsprivate','public_profile','online','open_now','phone_number','details',"locationcountry","locationstate","locationcity",'image',
'business_type','sign_up_date','intensity','issubusersallowed','last_login','isprofileanon','birth_date','isnsfwallowed','isnstlallowed','issensitiveallowed','isspoilerallowed','calendar_type',
'calendar_ismultichoice','user_type','parent',)

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if (attrs.get('parent') == None) and (attrs.get('id') == self.context['request'].user.pk):
            return attrs
        elif (attrs.get('parent') != None) and (attrs.get('parent').id != self.context['request'].user.pk):
            raise ValidationError('Unauthorized Request2')
        return attrs


    def create(self,validated_data):
     user = User.objects.create(
 email=validated_data['email'],
 username=validated_data['username'],
 fullname=validated_data['fullname'],
 details=validated_data['details'],
 locationcountry=validated_data['locationcountry'],
 locationstate=validated_data['locationstate'],
 locationcity=validated_data['locationcity'],
 parent=validated_data['parent'],
 user_type=validated_data['user_type'],
 calendar_type=validated_data['calendar_type'],
 business_type=validated_data['business_type'],
 phone_number=validated_data['phone_number'],
 isprofileanon=validated_data['isprofileanon'],
 issubusersallowed=validated_data['issubusersallowed'],
 intensity=validated_data['intensity'],

 password = make_password(validated_data['password'])


)
     return user




class GeneralUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields  = ('id','email','username','password','fullname','isdetailsprivate','public_profile','details','image','user_type','parent')

class RegisteringUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields  = ('id','email','username','fullname','public_profile')

class TagUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields  = ('id','email','image','username','fullname','public_profile')


class ArticleCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = Article
        fields = ('id','author','timestamp','category','locationstate','locationcity','locationcountry','caption','details','allowcomments','anonymity','sensitive','spoiler','hasImage',
'isjobposting','originalarticle','nsfw','nstl','price','type','time','date','allowstocks','isbuyenabled','stock','category','hideifoutofstock','isforstay','checkintime','checkouttime','startdate','enddate','readtime','deliveredfromtime','deliveredtotime','specialinstructions','guide','adults','kids','bedrooms','bathrooms','pricecurrency','pricetype','isquestion','productcondition','listcategory','deliveryfee','ishighlighted','etatime','isdelivered')

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs['author'].id == self.context['request'].user.pk:
            return attrs
        raise ValidationError('Unauthorized Request')

#(attrs.get('author').parent != None) and 
          