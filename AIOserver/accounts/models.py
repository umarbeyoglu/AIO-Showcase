import uuid
from django.contrib.auth.models import BaseUserManager, AbstractUser
from django.contrib.auth.models import PermissionsMixin
from django.db import models
from django.utils.translation import gettext as _

from .validators import validate_file_extension


class UserManager(BaseUserManager):

    def create_user(self, email, password=None):
   
        if not email:
            raise ValueError('Users Must Have an email address')
        user = self.model(email=self.normalize_email(email),)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):

        if password is None:
            raise TypeError('Superusers must have a password.')
        user = self.create_user(email, password)
        user.is_superuser = True
        user.is_staff = True
        user.save()
        return user


class User(AbstractUser,PermissionsMixin):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.CharField(max_length=255,null=True,blank=True,unique=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    username =models.CharField(max_length=40,unique=True,null=True,blank=True,default='undefinedusername')
    fullname = models.CharField(max_length=50, unique=False, null=True, blank=True)
    parent = models.ForeignKey('self',on_delete=models.CASCADE,null=True, blank=True)
    sign_up_date = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)
    online = models.BooleanField(default=False)
    public_profile = models.BooleanField(default=True)
    open_now =  models.BooleanField(default=False)
    birth_date = models.DateField(null=True, blank=True)
    details = models.CharField(unique=False,max_length=64000,null=True,blank=True)
    intensity = models.CharField(max_length=20,null=True,blank=True)
    businessstatus = models.CharField(max_length=10,null=True,blank=True)
    pricerange = models.CharField(max_length=10,null=True,blank=True) 
    isdetailsprivate = models.BooleanField(default=False)
    isprofileanon = models.BooleanField(default=False)
    issubusersallowed =  models.BooleanField(default=False)
    TYPE_CHOICES = (('P','Person'),('B','Business'),)
    user_type = models.CharField(max_length=6,null=True,blank=True,choices=TYPE_CHOICES)
    business_type = models.CharField(max_length=50,null=True,blank=True)
    calendar_type = models.CharField(max_length=50, unique=False, null=True, blank=True)
    calendar_ismultichoice =  models.BooleanField(default=True)
    locationcountry = models.CharField(max_length=200,null=True, blank=True)
    locationstate = models.CharField(max_length=200,null=True, blank=True) 
    locationcity = models.CharField(max_length=200,null=True, blank=True) 
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension]) 
    phone_number = models.CharField(max_length=30, null=True, blank=True)
    isnsfwallowed = models.BooleanField(default=False)
    isnstlallowed = models.BooleanField(default=False)
    issensitiveallowed = models.BooleanField(default=False)
    isspoilerallowed = models.BooleanField(default=False)
    gatewayname = models.CharField(max_length=150, null=True, blank=True)
    gatewaymerchantid = models.CharField(max_length=150, null=True, blank=True)
    merchantid = models.CharField(max_length=150, null=True, blank=True)
    merchantname= models.CharField(max_length=150, null=True, blank=True)
    wifiname = models.CharField(max_length=100,null=True,blank=True)
    wifipassword = models.CharField(max_length=100,null=True,blank=True) 
    ishotel = models.BooleanField(default=False)
    hotelclass = models.IntegerField(default='0')

#isbusinessatt(bool) instead of profile type?

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = UserManager()

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')

class ArticleCategory(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='articlecategories')
    category = models.CharField(unique=False,max_length=100,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension]) 

class Article(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,on_delete=models.CASCADE,related_name='articles')
    originalarticle = models.CharField(max_length=250,null=True,blank=True)
    caption = models.CharField(max_length=250)
    name = models.CharField(max_length=50,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    price = models.IntegerField(default='0')
    locationcountry = models.CharField(max_length=200,null=True, blank=True)
    locationstate = models.CharField(max_length=200,null=True, blank=True) 
    locationcity = models.CharField(max_length=200,null=True, blank=True) 
    type = models.CharField(max_length=20,null=True, blank=True) 
    details = models.CharField(max_length=64000, blank=True)
    allowcomments = models.BooleanField(default=False)
    anonymity = models.BooleanField(default=False)
    nsfw = models.BooleanField(default=False)
    nstl = models.BooleanField(default=False)
    sensitive = models.BooleanField(default=False)
    spoiler = models.BooleanField(default=False)
    pinned = models.BooleanField(default=False)
    hasImage = models.BooleanField(default=False)
    time = models.CharField(max_length=300)
    productcondition = models.CharField(max_length=300)
    date = models.CharField(max_length=300)
    allowstocks = models.BooleanField(default=False)
    isbuyenabled = models.BooleanField(default=False)
    stock = models.IntegerField(default='0')
    category = models.CharField(max_length=200,null=True, blank=True) 
    listcategory  = models.ForeignKey(ArticleCategory, on_delete=models.CASCADE,null=True,blank=True,related_name='articles_set')
    deliveryfee  = models.CharField(unique=False,max_length=100,null=True,blank=True)
    ishighlighted = models.BooleanField(default=False)
    etatime = models.CharField(max_length=50,null=True, blank=True)
    isdelivered = models.BooleanField(default=False)
    isjobposting = models.BooleanField(default=False)
    hideifoutofstock = models.BooleanField(default=False)
    isforstay = models.BooleanField(default=False)
    checkintime = models.CharField(max_length=50,null=True,blank=True)
    checkouttime = models.CharField(max_length=50,null=True,blank=True)
    startdate = models.CharField(max_length=50,null=True,blank=True)
    enddate = models.CharField(max_length=50,null=True,blank=True)
    readtime = models.CharField(max_length=30,null=True,blank=True)
    deliveredfromtime = models.CharField(max_length=30,null=True,blank=True)
    deliveredtotime = models.CharField(max_length=30,null=True,blank=True)
    specialinstructions = models.CharField(max_length=5000,null=True,blank=True)
    guide = models.CharField(max_length=5000,null=True,blank=True)
    adults = models.IntegerField(default='0')
    kids = models.IntegerField(default='0')
    bedrooms = models.IntegerField(default='0')
    bathrooms = models.IntegerField(default='0')
    pricecurrency = models.CharField(max_length=10,null=True,blank=True)
    pricetype = models.CharField(max_length=30,null=True,blank=True)
    isquestion = models.BooleanField(default=False)

class ArticleChoiceCategory(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articlechoicecategories')
    category = models.CharField(unique=False,max_length=100,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    allchooseable = models.BooleanField(default=False)
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension]) 

class ArticleChoice(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    category = models.CharField(unique=False,max_length=100,null=True,blank=True)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articlechoices')
    item = models.CharField(unique=False,max_length=100,null=True,blank=True)
    price  = models.CharField(unique=False,max_length=100,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    isbuyenabled = models.BooleanField(default=False)
    allowstocks = models.BooleanField(default=False)
    stock = models.IntegerField(default='0')
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension]) 


class ArticleForm(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='articleforms_set')
    article = models.ForeignKey(Article,null=True,blank=True,  on_delete=models.CASCADE,related_name='articleforms')
    timestamp = models.DateTimeField(auto_now_add=True)
    hint = models.CharField(max_length=500,null=True,blank=True)



class ArticleCheckbox(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='articlecheckboxes_set')
    article = models.ForeignKey(Article,null=True,blank=True,  on_delete=models.CASCADE,related_name='articlecheckboxes')
    timestamp = models.DateTimeField(auto_now_add=True)
    hint = models.CharField(max_length=500,null=True,blank=True)


class ArticleActivity(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articleactivities')
    activity= models.CharField(max_length=150,null=True,blank=True)
    starttime = models.CharField(max_length=200,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['activity', 'article'],name='unique_articleactivity')]

class ArticleHighlight(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articlehighlights')
    highlight = models.CharField(max_length=300,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['highlight', 'article'],name='unique_articlehighlight')]

class ArticleTravelLocation(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articletravellocations')
    location = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['location', 'article'],name='unique_articletravellocation')]

class BusinessType(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    businesstype = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['businesstype'],name='unique_businesstype')]

class ArticleAmenity(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articleamenities')
    amenity = models.CharField(max_length=200,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['amenity', 'article'],name='unique_articleamenity')]

class ArticleDetailCategory(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articledetailcategories')
    category = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['category', 'article'],name='unique_articledetailcategory')]

class ArticleDetailIncluded(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articledetailincludeds')
    included = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['included', 'article'],name='unique_articledetailincluded')]

class ArticleDetailRule(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articledetailrules')
    rule= models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['rule', 'article'],name='unique_articledetailrule')]

class ArticleDetailSpec(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articledetailspecs')
    category = models.CharField(max_length=150,null=True,blank=True)
    spec = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['category','spec','article'],name='unique_articledetailspec')]

class ItemType(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    itemtype = models.CharField(max_length=150,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['itemtype'],name='unique_itemtype')]

class UserOpeningHour(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='useropeninghours')
    weekday = models.CharField(max_length=150,null=True,blank=True)
    fromhour = models.CharField(max_length=150,null=True,blank=True)
    tohour = models.CharField(max_length=150,null=True,blank=True)
    isalwaysopen = models.BooleanField(default=False)
    ispermanentlyclosed = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)



    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'weekday'],name='unique_useropeninghour')]


class ReservationSchedule(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='reservationschedules')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,related_name='reservationschedules_set')
    reservation = models.ForeignKey(Article, on_delete=models.CASCADE,related_name='reservationschedules_set2')
    startdate = models.CharField(max_length=200)
    enddate = models.CharField(max_length=200)
    timestamp = models.DateTimeField(auto_now_add=True)

class ArticleImage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension])
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articleimages')

class ArticleSharedImage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.CharField(null=True,blank=True,max_length=300)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articlesharedimages')

class ArticleSharedVideo(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    video = models.CharField(null=True,blank=True,max_length=300)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articlesharedvideos')

class ArticleBookmark(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='userbookmarks')
    article = models.ForeignKey(Article,on_delete=models.CASCADE,null=True,related_name='userbookmarks_set')
    timestamp = models.DateTimeField(auto_now_add=True)

class ArticleVideo(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    video = models.FileField(upload_to='videos',null=True,blank=True, validators=[validate_file_extension])
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articlevideos')

class ArticleTag(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    tag = models.CharField(max_length=35,null=True,blank=True)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True, related_name='articletags')
    timestamp = models.DateTimeField(auto_now_add=True)

class ArticleView(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='articleviews_set')
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articleviews')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'article'],name='unique_articleview')]

class ArticleLike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='articlelikes_set')
    article = models.ForeignKey(Article, on_delete=models.CASCADE,related_name='articlelikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'article'],name='unique_articlelike')]


class ArticleDislike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='articledislikes_set')
    article = models.ForeignKey(Article, on_delete=models.CASCADE,related_name='articledislikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'article'],name='unique_articledislike')]

class ArticleUserTag(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    article = models.ForeignKey(Article,  on_delete=models.CASCADE,related_name='articleusertags')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,related_name='articleusertags_set')
    username = models.CharField(max_length=150)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['profile', 'article'],name='unique_articleusertag')]



class ArticleComment(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,on_delete=models.CASCADE,related_name='articlecomments_set')
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name='articlecomments')
    parent = models.ForeignKey('self', null=True, blank=True,on_delete=models.CASCADE, related_name='replies')
    content = models.CharField(max_length=100)
    timestamp = models.DateTimeField(auto_now_add=True)
    categorychoices = (('A','Comment'),('B','Insight'),('C','AccountHealth'),('D','Review'),('E','Education'),('F','QnA'),('G','Feedback'),('H','Suggestion'))
    category = models.CharField(max_length=30, choices= categorychoices ,default='A') 


class CalendarStatus(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='calendarstatuses')
    times = models.CharField(max_length=300)
    dates = models.CharField(max_length=300)
    items = models.CharField(max_length=300)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'times','dates','items'],name='unique_calendarstatus')]

class CalendarTime(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='calendartimes')
    time= models.CharField(max_length=50)
    date = models.CharField(max_length=300)
    timestamp = models.DateTimeField(auto_now_add=True)
    allowstocks = models.BooleanField(default=False)
    stock = models.IntegerField(default='0')


    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'time','date'],name='unique_calendartime')]

class CalendarDate(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='calendardates')
    date = models.CharField(max_length=200)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'date'],name='unique_calendardate')]


class CalendarSchedule(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='calendarschedules')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,related_name='calendarschedules_set')
    item = models.CharField(max_length=200)
    date = models.CharField(max_length=200)
    time= models.CharField(max_length=200,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

   # class Meta:
   #     constraints = [models.UniqueConstraint(fields=['author','profile','item','date','time'],name='unique_calendarschedule')]

class UserMessage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='usermessages_set')
    profile = models.ForeignKey(User,on_delete=models.CASCADE,null=True,related_name='usermessages')
    content = models.CharField(unique=False,max_length=500)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)


class UserReport(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    profile = models.ForeignKey(User,  on_delete=models.CASCADE,null=True,blank=True)
    article = models.ForeignKey(Article, on_delete=models.CASCADE,null=True,blank=True)
    content = models.CharField(max_length=150)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['profile'],name='unique_userreport')]

class UserBan(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    profile = models.ForeignKey(User,  on_delete=models.CASCADE,null=True)
    banreason = models.CharField(unique=False,max_length=500)
    bantime = models.CharField(unique=False,max_length=500)
    timestamp = models.DateTimeField(auto_now_add=True)


    class Meta:
        constraints = [models.UniqueConstraint(fields=[ 'profile'],name='unique_userban')]

class UserBlock(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='userblocks')
    profile = models.ForeignKey(User,  on_delete=models.CASCADE,null=True,related_name='userblocks_set')
    timestamp = models.DateTimeField(auto_now_add=True)


    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_userblock')]



class UserTag(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    tag = models.CharField(max_length=35,null=True,blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='usertags')
    timestamp = models.DateTimeField(auto_now_add=True)

class UserCalendarType(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    calendar_type = models.CharField(max_length=70, unique=False, null=True, blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='usercalendartype')
    timestamp = models.DateTimeField(auto_now_add=True)

    
class UserImage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension])
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='userimages')
    timestamp = models.DateTimeField(auto_now_add=True)

class UserPhone(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    phone = models.CharField(max_length=100,null=True,blank=True)
    phonename = models.CharField(max_length=30,null=True,blank=True)
    iswp = models.BooleanField(default=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='userphones')
    timestamp = models.DateTimeField(auto_now_add=True)

class UserMail(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    mail = models.CharField(max_length=100,null=True,blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='usermails')
    timestamp = models.DateTimeField(auto_now_add=True)

class UserView(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='userviews')
    profile = models.ForeignKey(User,  on_delete=models.CASCADE,null=True,related_name='userviews_set')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_userview')]


class UserLocation(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    location = models.CharField(max_length=100,null=True,blank=True)
    locationname = models.CharField(max_length=80,null=True,blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,blank=True, related_name='userlocations')
    timestamp = models.DateTimeField(auto_now_add=True)

class UserComment(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,on_delete=models.CASCADE,related_name='usercomments_set')
    profile = models.ForeignKey(User, on_delete=models.CASCADE, related_name='usercomments')
    parent = models.ForeignKey('self', null=True, blank=True,on_delete=models.CASCADE, related_name='replies')
    content = models.CharField(max_length=100)
    timestamp = models.DateTimeField(auto_now_add=True)
    categorychoices = (('A','Feedback'),('B','Insight'),('C','AccountHealth'),('D','Review'),('E','Education'),('F','QnA'),('G','Comment'),('H','Suggestion'))
    category = models.CharField(max_length=15,choices=categorychoices ,default='A') 



class UserFollow(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,on_delete=models.CASCADE,related_name='following')
    profile = models.ForeignKey(User,on_delete=models.CASCADE,related_name='followers')
    issilent = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_userfollow')]



class UserLike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='userlikes')
    profile = models.ForeignKey(User,on_delete=models.CASCADE,null=True,related_name='userlikes_set')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_userlike')]

class UserDislike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='userdislikes')
    profile = models.ForeignKey(User,on_delete=models.CASCADE,null=True,related_name='userdislikes_set')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_userdislike')]



class Request(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='requests_sett')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,related_name='requests')  
    item = models.CharField(max_length=200,null=True,blank=True)
    buycategory = models.CharField(max_length=200,null=True,blank=True)
    reason = models.CharField(max_length=500,null=True,blank=True)
    date = models.CharField(max_length=200,null=True,blank=True)
    link = models.CharField(max_length=200,null=True,blank=True)
    requesttype = models.CharField(max_length=200,null=True,blank=True)
    time= models.CharField(max_length=200,null=True,blank=True)
    clientnow = models.BooleanField(default=False)
    isdenied = models.BooleanField(default=False)
    isaccepted = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)
    contact = models.CharField(max_length=80,blank=True)
    fullname = models.CharField(max_length=200,blank=True)
    deliverydate = models.CharField(max_length=80,blank=True)
    deliverytype = models.CharField(max_length=80,blank=True)
    deliveryaddress = models.CharField(max_length=200,blank=True)
    count = models.IntegerField(default='1')
    price = models.FloatField(default='0')


    #product = models.CharField(max_length=200,null=True,blank=True) 
    #group = models.ForeignKey(Group,on_delete=models.CASCADE,related_name='requests_set',null=True, blank=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile','requesttype','item'],name='unique_request')]



class RequestImage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    request = models.ForeignKey(Request,null=True,blank=True,  on_delete=models.CASCADE,related_name='requestimages')
    timestamp = models.DateTimeField(auto_now_add=True)
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension])

class RequestForm(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    request = models.ForeignKey(Request,null=True,blank=True,  on_delete=models.CASCADE,related_name='requestforms')
    timestamp = models.DateTimeField(auto_now_add=True)
    hint = models.CharField(max_length=500,null=True,blank=True)
    content = models.CharField(max_length=500,null=True,blank=True)

class RequestCheckbox(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    request = models.ForeignKey(Request,null=True,blank=True,  on_delete=models.CASCADE,related_name='requestcheckboxes')
    timestamp = models.DateTimeField(auto_now_add=True)
    hint = models.CharField(max_length=500,null=True,blank=True)
    boolean = models.BooleanField(default=False)



class ArticleCommentLike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='articlecommentlikes_set')
    article = models.ForeignKey(ArticleComment, on_delete=models.CASCADE,related_name='articlecommentlikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'article'],name='unique_articlecommentlike')]


class ArticleCommentDislike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='articlecommentdislikes_set')
    article = models.ForeignKey(ArticleComment, on_delete=models.CASCADE,related_name='articlecommentdislikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'article'],name='unique_articlecommentdislike')]

class UserCommentLike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='usercommentlikes_set')
    profile = models.ForeignKey(UserComment, on_delete=models.CASCADE,related_name='usercommentlikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_usercommentlike')]


class UserCommentDislike(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='usercommentdislikes_set')
    profile = models.ForeignKey(UserComment, on_delete=models.CASCADE,related_name='usercommentdislikes')
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile'],name='unique_usercommentdislike')]

class RequestItem(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='requestitems_set')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='requestitems')
    item = models.CharField(unique=False,max_length=100,null=True,blank=True)
    link = models.CharField(unique=False,max_length=300,null=True,blank=True)
    type = models.CharField(unique=False,max_length=10,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    count = models.IntegerField(default='1')
    price = models.FloatField(default='0')

class CartItem(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='cartitems')
    owner = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='cartitems_set')
    item = models.CharField(unique=False,max_length=100,null=True,blank=True)
    link = models.CharField(unique=False,max_length=300,null=True,blank=True)
    type = models.CharField(unique=False,max_length=20,null=True,blank=True)
    isfood = models.BooleanField(default=False)
    foodbusinesstype = models.CharField(unique=False,max_length=10,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    count = models.IntegerField(default='1')
    price = models.FloatField(default='0')


class CartItemChoice(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    item = models.ForeignKey(CartItem,on_delete=models.CASCADE,null=True,related_name='cartitemchoices')
    choice = models.CharField(unique=False,max_length=300,null=True,blank=True)
    category = models.CharField(unique=False,max_length=300,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    price = models.IntegerField(default='0')

class RequestItemChoice(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    request = models.ForeignKey(Request,on_delete=models.CASCADE,null=True,related_name='requestchoices')
    choice = models.CharField(unique=False,max_length=300,null=True,blank=True)
    category = models.CharField(unique=False,max_length=300,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    price = models.IntegerField(default='0')


class UserMessageImage(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='usermessageimages_set')
    message = models.ForeignKey(UserMessage,on_delete=models.CASCADE,null=True,related_name='usermessageimages')
    image = models.FileField(upload_to='images',null=True,blank=True, validators=[validate_file_extension]) 
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)

class UserMessageVideo(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='usermessagevideos_set')
    message = models.ForeignKey(UserMessage,on_delete=models.CASCADE,null=True,related_name='usermessagevideos')
    video = models.FileField(upload_to='videos',null=True,blank=True, validators=[validate_file_extension])
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)

class ReservationDeactivationMonth(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,related_name='reservationdeactivationmonths')
    timestamp = models.DateTimeField(auto_now_add=True)
    startdate = models.CharField(null=True,blank=True,max_length=30)
    enddate = models.CharField(null=True,blank=True,max_length=30)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author','startdate','enddate'],name='unique_reservationdeactivationmonth')]

class UserCartItem(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User, on_delete=models.CASCADE,null=True,related_name='usercartitems')
    link = models.CharField(unique=False,max_length=100,null=True,blank=True)
    count = models.IntegerField(default='1')
    isfood = models.BooleanField(default=False)
    foodbusinesstype = models.CharField(unique=False,max_length=10,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)

class BoughtCheck(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='boughtchecks_set')
    owner = models.ForeignKey(User, on_delete=models.CASCADE,related_name='boughtchecks')
    price = models.FloatField(default='0')
    deliveryfee = models.FloatField(default='0')
    count = models.IntegerField(default='1')
    item = models.CharField(unique=False,max_length=200,null=True,blank=True)
    link = models.CharField(unique=False,max_length=300,null=True,blank=True)
    type = models.CharField(unique=False,max_length=20,null=True,blank=True)
    specialrequest = models.CharField(max_length=500,blank=True)
    category = models.CharField(max_length=200,null=True,blank=True)
    contact = models.CharField(max_length=80,blank=True)
    fullname = models.CharField(max_length=200,blank=True)
    deliverydate = models.CharField(max_length=80,blank=True)
    deliverytype = models.CharField(max_length=80,blank=True)
    deliverytime = models.CharField(max_length=80,blank=True)
    deliveryaddress = models.CharField(max_length=200,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)


class BoughtItemChoice(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    item = models.ForeignKey(BoughtCheck,on_delete=models.CASCADE,null=True,related_name='boughtcheckchoices')
    choice = models.CharField(unique=False,max_length=300,null=True,blank=True)
    category = models.CharField(unique=False,max_length=300,null=True,blank=True)
    timestamp = models.DateTimeField(unique=False,auto_now_add=True)
    price = models.IntegerField(default='0')

class MeetingStatus(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='meetingstatuses')
    times = models.CharField(max_length=300)
    dates = models.CharField(max_length=300)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'times','dates'],name='unique_meetingstatus')]


class MeetingSchedule(models.Model):

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    author = models.ForeignKey(User,  on_delete=models.CASCADE,related_name='meetingschedules')
    profile = models.ForeignKey(User, on_delete=models.CASCADE,related_name='meetingschedules_set')
    date = models.CharField(max_length=200)
    time= models.CharField(max_length=200,null=True,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [models.UniqueConstraint(fields=['author', 'profile','date','time'],name='unique_meetingschedule')]
