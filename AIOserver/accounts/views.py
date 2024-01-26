from accounts.models import ReservationDeactivationMonth,RequestItem,RequestItemChoice,CartItem,CartItemChoice,BoughtCheck,User,ArticleDislike,UserDislike,RequestImage,RequestForm,RequestCheckbox,UserView,Request,Article,ArticleImage,ArticleSharedImage,ArticleBookmark,ArticleVideo,ArticleTag,ArticleView,ArticleLike,ArticleUserTag,ArticleComment,CalendarDate,CalendarSchedule,UserReport,UserMessage,UserBlock,UserTag,UserComment,UserFollow,UserLike,UserImage,UserPhone,UserLocation,UserMail,ArticleSharedVideo,CalendarTime,UserCalendarType,CalendarStatus,ArticleCommentDislike,UserCommentDislike,ArticleCommentLike,UserCommentLike,ArticleCategory,ArticleChoiceCategory,ArticleChoice,ArticleForm,ArticleCheckbox,ReservationSchedule,UserMessageImage,UserMessageVideo,UserCartItem,ArticleActivity,ArticleHighlight,ArticleTravelLocation,BusinessType,BoughtItemChoice,ArticleAmenity,ArticleDetailCategory,ArticleDetailIncluded,ArticleDetailRule,ArticleDetailSpec,ItemType,UserOpeningHour,BoughtItemChoice,MeetingStatus,MeetingSchedule
from accounts.serializers import UserSerializer,BoughtCheckSerializer,TagUserSerializer,RegisteringUserSerializer,ArticleDislikeSerializer,UserDislikeSerializer,RequestImageSerializer,RequestFormSerializer,RequestCheckBoxSerializer,UserViewSerializer,RegisterUserSerializer,ArticleSerializer,ArticleCreateSerializer,ArticleImageSerializer,ArticleSharedImageSerializer,ArticleBookmarkSerializer,ArticleVideoSerializer,ArticleTagSerializer,ArticleViewSerializer,ArticleLikeSerializer,ArticleUserTagSerializer,ArticleCommentSerializer,CalendarDateSerializer,CalendarScheduleSerializer,UserReportSerializer,UserMessageSerializer,UserBlockSerializer,UserTagSerializer,UserCommentSerializer,UserFollowSerializer,RequestSerializer,UserLikeSerializer,UserImageSerializer,UserPhoneSerializer,UserLocationSerializer,UserMailSerializer,ArticleSharedVideoSerializer,CalendarTimeSerializer,CalendarStatusSerializer,GeneralUserSerializer,PrivateUserSerializer,ArticleCommentDislikeSerializer,UserCommentDislikeSerializer,ArticleCommentLikeSerializer,UserCommentLikeSerializer,ArticleFIOSerializer,ReservationScheduleSerializer,UserMessageCountSerializer,RequestItemSerializer,CartItemSerializer,CartItemChoiceSerializer,RequestItemChoiceSerializer,UserMessageImageSerializer,UserMessageVideoSerializer,UserGetMessageSerializer,ReservationDeactivationMonthSerializer,ArticleCategorySerializer,ArticleChoiceCategorySerializer,ArticleChoiceSerializer,ArticleCheckboxSerializer,ArticleFormSerializer,UserCartItemSerializer,ArticleActivitySerializer,ArticleHighlightSerializer,ArticleTravelLocationSerializer,BusinessTypeSerializer,ArticleAmenitySerializer,ArticleDetailCategorySerializer,ArticleDetailIncludedSerializer,ArticleDetailRuleSerializer,ArticleDetailSpecSerializer,ItemTypeSerializer,UserOpeningHourSerializer,BoughtItemChoiceSerializer,MeetingStatusSerializer,MeetingScheduleSerializer
from accounts.filters import FollowedUserPhoneFilterBackend,AuthorPublicUserFilterBackend,ProfilePublicUserFilterBackend,FollowedUserLocationFilterBackend,FollowedUserMailFilterBackend,FollowedCalendarTimeFilterBackend,PublicCalendarTimeFilterBackend,SubuserTaggedFilterBackend,LikeDislikeFilterBackend,SubuserRequestFilterBackend,UserTaggedFilterBackend,SubuserArticleFilterBackend,SubUserParentFilterBackend,NonGroupArticlesFilterBackend,PublicArticleofGroupsFilterBackend,PublicArticleFilterBackend,OwnProfileFilterBackend,PrivateUserFilterBackend,PublicGroupFilterBackend,FollowedAuthorFilterBackend,UserRequestFilterBackend,FollowingUserFilterBackend,SubUserFilterBackend,PrivateGroupFilterBackend,ArticleFilterBackend,UserFilterBackend,FollowedUserFilterBackend,UserGroupFilterBackend,PublicUserFilterBackend,FollowingAuthorFilterBackend,PublicUserCommentFilterBackend,PublicArticleCommentFilterBackend,FollowedUserCommentFilterBackend,FollowedArticleCommentFilterBackend,MessageSubFilterBackend,PublicReservationDMFilterBackend,FollowedReservationDMFilterBackend,ItemSubFilterBackend
from rest_framework import serializers, viewsets,filters
from rest_framework.permissions import IsAuthenticated
from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.authentication import TokenAuthentication
from rest_framework.pagination import PageNumberPagination
from rest_framework import filters

class StandardResultsSetPagination(PageNumberPagination):
    page_size = 5
    page_size_query_param = 'page_size'
    max_page_size = 1000

class FIOResultsSetPagination(PageNumberPagination):
    page_size = 50
    page_size_query_param = 'page_size'
    max_page_size = 1000


class ArticleTravelLocationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleTravelLocation.objects.all().order_by('-timestamp')
    serializer_class = ArticleTravelLocationSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class BoughtCheckViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = BoughtCheck.objects.all().order_by('-timestamp')
    serializer_class = BoughtCheckSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination
    http_method_names = ['get','post','head','put']

class ArticleHighlightViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleHighlight.objects.all().order_by('-timestamp')
    serializer_class = ArticleHighlightSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class MeetingStatusViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = MeetingStatus.objects.all().order_by('-timestamp')
    serializer_class = MeetingStatusSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class MeetingScheduleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = MeetingSchedule.objects.all().order_by('-timestamp')
    serializer_class = MeetingScheduleSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']

class ArticleActivityViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleActivity.objects.all().order_by('-timestamp')
    serializer_class = ArticleActivitySerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleAmenityViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleAmenity.objects.all().order_by('-timestamp')
    serializer_class = ArticleAmenitySerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleDetailCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDetailCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleDetailCategorySerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleDetailIncludedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDetailIncluded.objects.all().order_by('-timestamp')
    serializer_class = ArticleDetailIncludedSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleDetailRuleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDetailRule.objects.all().order_by('-timestamp')
    serializer_class = ArticleDetailRuleSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleDetailSpecViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDetailSpec.objects.all().order_by('-timestamp')
    serializer_class = ArticleDetailSpecSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class UserOpeningHourViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserOpeningHour.objects.all().order_by('-timestamp')
    serializer_class = UserOpeningHourSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class ItemTypeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ItemType.objects.all().order_by('-timestamp')
    serializer_class = ItemTypeSerializer
    pagination_class = StandardResultsSetPagination

class BusinessTypeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = BusinessType.objects.all().order_by('-timestamp')
    serializer_class = BusinessTypeSerializer
    pagination_class = StandardResultsSetPagination

class UserCartItemViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserCartItem.objects.all()
    serializer_class = UserCartItemSerializer
    filter_backends = [UserFilterBackend]

class ArticleChoiceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleChoice.objects.all().order_by('-timestamp')
    serializer_class = ArticleChoiceSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleChoiceCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleChoiceCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleChoiceCategorySerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleCategorySerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedArticleCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleCategorySerializer
    filter_backends = [FollowedAuthorFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicArticleCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleCategorySerializer
    filter_backends = [AuthorPublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class ArticleCheckboxViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCheckbox.objects.all().order_by('-timestamp')
    serializer_class = ArticleCheckboxSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleFormViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleForm.objects.all().order_by('-timestamp')
    serializer_class = ArticleFormSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ReservationScheduleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ReservationSchedule.objects.all().order_by('-timestamp')
    serializer_class = ReservationScheduleSerializer
    filter_backends = [UserTaggedFilterBackend]
    pagination_class = StandardResultsSetPagination


class UserMessageCountViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserMessageCountSerializer
    filter_backends = [OwnProfileFilterBackend]


class RequestItemViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = RequestItem.objects.all().order_by('-timestamp')
    serializer_class = RequestItemSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class CartItemViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CartItem.objects.all().order_by('-timestamp')
    serializer_class = CartItemSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class CartItemChoiceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CartItemChoice.objects.all().order_by('-timestamp')
    serializer_class = CartItemChoiceSerializer
    filter_backends = [ItemSubFilterBackend]
    pagination_class = StandardResultsSetPagination

class BoughtItemChoiceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = BoughtItemChoice.objects.all().order_by('-timestamp')
    serializer_class = BoughtItemChoiceSerializer
    filter_backends = [ItemSubFilterBackend]
    pagination_class = StandardResultsSetPagination

class RequestItemChoiceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = RequestItemChoice.objects.all().order_by('-timestamp')
    serializer_class = RequestItemChoiceSerializer
    filter_backends = [ItemSubFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserMessageImageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMessageImage.objects.all().order_by('-timestamp')
    serializer_class = UserMessageImageSerializer
    filter_backends = [MessageSubFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserMessageVideoViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMessageVideo.objects.all().order_by('-timestamp')
    serializer_class = UserMessageVideoSerializer
    filter_backends = [MessageSubFilterBackend]
    pagination_class = StandardResultsSetPagination

class TagUsersViewSet(viewsets.ModelViewSet):
    queryset = User.objects.none()
    serializer_class = TagUserSerializer
    pagination_class = StandardResultsSetPagination

class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [OwnProfileFilterBackend]
    


class UserGetMessageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserGetMessageSerializer
    filter_backends = [OwnProfileFilterBackend]

class RegisteringUserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.none()
    serializer_class = RegisteringUserSerializer

class RegisterUserCheckViewSet(viewsets.ModelViewSet):
    queryset = User.objects.none()
    serializer_class = RegisteringUserSerializer

class RegisterUserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.none()
    serializer_class = RegisterUserSerializer




class ArticleDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDislike.objects.all().order_by('-timestamp')
    serializer_class = ArticleDislikeSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserDislike.objects.all().order_by('-timestamp')
    serializer_class = UserDislikeSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class FetchSubuserNotificationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all().order_by('-id')
    serializer_class = TagUserSerializer
    filter_backends = [SubUserFilterBackend]

class AllUnauthUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = PrivateUserSerializer
    pagination_class = StandardResultsSetPagination

class TagUsersViewSet(viewsets.ModelViewSet):
    queryset = User.objects.none()
    serializer_class = RegisteringUserSerializer
    pagination_class = StandardResultsSetPagination

class UserArticleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['type']


class SubuserCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserComment.objects.all().order_by('-timestamp')
    serializer_class = UserCommentSerializer
    filter_backends = [SubUserParentFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']




class FollowedUserMailViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMail.objects.all().order_by('-timestamp')
    serializer_class = UserMailSerializer
    filter_backends = [FollowedUserMailFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedUserPhoneViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserPhone.objects.all().order_by('-timestamp')
    serializer_class = UserPhoneSerializer
    filter_backends = [FollowedUserPhoneFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedUserLocationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserLocation.objects.all().order_by('-timestamp')
    serializer_class = UserLocationSerializer
    filter_backends = [FollowedUserLocationFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']


class PublicCalendarTimeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarTime.objects.all().order_by('-timestamp')
    serializer_class = CalendarTimeSerializer
    filter_backends = [PublicCalendarTimeFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedCalendarTimeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarTime.objects.all().order_by('-timestamp')
    serializer_class = CalendarTimeSerializer
    filter_backends = [FollowedCalendarTimeFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class NonGrouppArticleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [filters.SearchFilter,DjangoFilterBackend,PublicArticleFilterBackend]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^author__id','^details','^articletags__tag','^caption','^type','^articledetailspecs__spec','^articledetailrules__rule','^articledetailincludeds__included','^articledetailcategories__category','^articleamenities__amenity','^articletravellocations__location','^articlehighlights__highlight','^articleactivities__activity','^specialinstructions','^guide']
    filterset_fields = ['type']

class UsersViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = PrivateUserSerializer
    filter_backends = [PrivateUserFilterBackend]
    pagination_class = StandardResultsSetPagination


class SubUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [SubUserFilterBackend]
    pagination_class = StandardResultsSetPagination

class FetchSubUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = TagUserSerializer
    filter_backends = [SubUserFilterBackend]



class FetchUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [FollowingUserFilterBackend]
    pagination_class = StandardResultsSetPagination




class ArticleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [FollowedAuthorFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicArticleViewSet(viewsets.ModelViewSet):
#,PublicArticleFilterBackend    permission_classes = (IsAuthenticated,) 
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [filters.SearchFilter,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^author__id','^details','^articletags__tag','^caption','^type','^articledetailspecs__spec','^articledetailrules__rule','^articledetailincludeds__included','^articledetailcategories__category','^articleamenities__amenity','^articletravellocations__location','^articlehighlights__highlight','^articleactivities__activity','^specialinstructions','^guide']
    filterset_fields = ['type']







class PublicArticlePriceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [PublicArticleFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicArticleofGroupsViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [PublicArticleofGroupsFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicArticleofGroupsPriceViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [PublicArticleofGroupsFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']


class PublicUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [PublicUserFilterBackend,filters.SearchFilter]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^username','^fullname','^usertags__tag','^details']


class PrivateUserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = PrivateUserSerializer
    filter_backends = [PrivateUserFilterBackend,filters.SearchFilter]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^username','^fullname','^usertags__tag','^details']


class ArticleCreateViewSet(viewsets.ModelViewSet):
    queryset = Article.objects.none()
    serializer_class = ArticleCreateSerializer

class ArticleImageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleImage.objects.all()
    serializer_class = ArticleImageSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class ArticleSharedImageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleSharedImage.objects.all()
    serializer_class = ArticleSharedImageSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleSharedVideoViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleSharedVideo.objects.all()
    serializer_class = ArticleSharedVideoSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleBookmarkViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleBookmark.objects.all().order_by('-timestamp')
    serializer_class = ArticleBookmarkSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']


class ArticleVideoViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleVideo.objects.all()
    serializer_class = ArticleVideoSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class ArticleTagViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleTag.objects.all()
    serializer_class = ArticleTagSerializer
    authentication_classes = (TokenAuthentication,)
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class ArticleViewViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleView.objects.all().order_by('-timestamp')
    serializer_class = ArticleViewSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleLike.objects.all().order_by('-timestamp')
    serializer_class = ArticleLikeSerializer
    filter_backends = [ArticleFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','article']




class ArticleUserTaggedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleUserTag.objects.all().order_by('-timestamp')
    serializer_class = ArticleUserTagSerializer
    filter_backends = [UserTaggedFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleSubuserTaggedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleUserTag.objects.all().order_by('-timestamp')
    serializer_class = ArticleUserTagSerializer
    filter_backends = [SubuserTaggedFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleUserTagViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleUserTag.objects.all().order_by('-timestamp')
    serializer_class = ArticleUserTagSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleComment.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentSerializer
    filter_backends = [ArticleFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['article']

class AllArticleCommentViewSet(viewsets.ModelViewSet):
    queryset = ArticleComment.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentSerializer
    filter_backends = [ArticleFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['article']

class RequestViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Request.objects.all().order_by('-timestamp')
    serializer_class = RequestSerializer
    filter_backends = [UserRequestFilterBackend]
    pagination_class = StandardResultsSetPagination


class RequestImageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = RequestImage.objects.all().order_by('-timestamp')
    serializer_class = RequestImageSerializer
    filter_backends = [UserRequestFilterBackend]
    pagination_class = StandardResultsSetPagination

class RequestFormViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = RequestForm.objects.all().order_by('-timestamp')
    serializer_class = RequestFormSerializer
    filter_backends = [UserRequestFilterBackend]
    pagination_class = StandardResultsSetPagination

class RequestCheckBoxViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = RequestCheckbox.objects.all().order_by('-timestamp')
    serializer_class = RequestCheckBoxSerializer
    filter_backends = [UserRequestFilterBackend]
    pagination_class = StandardResultsSetPagination




class CalendarTimeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarTime.objects.all().order_by('-timestamp')
    serializer_class = CalendarTimeSerializer
    filter_backends = [DjangoFilterBackend,UserFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class CalendarStatusViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarStatus.objects.all().order_by('-timestamp')
    serializer_class = CalendarStatusSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']


class CalendarDateViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarDate.objects.all().order_by('-timestamp')
    serializer_class = CalendarDateSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class CalendarScheduleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = CalendarSchedule.objects.all().order_by('-timestamp')
    serializer_class = CalendarScheduleSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']



class UserReportViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserReport.objects.all().order_by('-timestamp')
    serializer_class = UserReportSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']

class UserMessageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMessage.objects.all().order_by('-timestamp')
    serializer_class = UserMessageSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination


class UserBlockViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserBlock.objects.all().order_by('-timestamp')
    serializer_class = UserBlockSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']

class UserTagViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserTag.objects.all().order_by('-timestamp')
    serializer_class = UserTagSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserImageViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserImage.objects.all().order_by('-timestamp')
    serializer_class = UserImageSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserMailViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMail.objects.all().order_by('-timestamp')
    serializer_class = UserMailSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class UserPhoneViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserPhone.objects.all().order_by('-timestamp')
    serializer_class = UserPhoneSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']



class UserLocationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserLocation.objects.all().order_by('-timestamp')
    serializer_class = UserLocationSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class UserCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserComment.objects.all().order_by('-timestamp')
    serializer_class = UserCommentSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['profile']

class UserFollowViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','profile']

class UserViewViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset =  UserView.objects.all().order_by('-timestamp')
    serializer_class =  UserViewSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserLike.objects.all().order_by('-timestamp')
    serializer_class = UserLikeSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class SubuserRequestViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Request.objects.all().order_by('-timestamp')
    serializer_class = RequestSerializer
    filter_backends = [SubuserRequestFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class SubuserArticleCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleComment.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentSerializer
    filter_backends = [SubuserArticleFilterBackend]
    pagination_class = StandardResultsSetPagination


class SubuserArticleLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleLike.objects.all().order_by('-timestamp')
    serializer_class = ArticleLikeSerializer
    filter_backends = [SubuserArticleFilterBackend]
    pagination_class = StandardResultsSetPagination



class SubuserArticleViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all().order_by('-timestamp')
    serializer_class = ArticleSerializer
    filter_backends = [SubUserParentFilterBackend]
    pagination_class = StandardResultsSetPagination


class UserUnLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserLike.objects.all().order_by('-timestamp')
    serializer_class = UserLikeSerializer
    filter_backends = [LikeDislikeFilterBackend,DjangoFilterBackend]
    filterset_fields = ['author','profile']
    pagination_class = StandardResultsSetPagination

class ArticleUnDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleDislike.objects.all().order_by('-timestamp')
    serializer_class = ArticleDislikeSerializer
    pagination_class = StandardResultsSetPagination
    filter_backends = [LikeDislikeFilterBackend,DjangoFilterBackend]
    filterset_fields = ['author','article']


class UserUnDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserDislike.objects.all().order_by('-timestamp')
    serializer_class = UserDislikeSerializer
    filter_backends = [LikeDislikeFilterBackend,DjangoFilterBackend]
    filterset_fields = ['author','profile']
    pagination_class = StandardResultsSetPagination

class ArticleUnLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleLike.objects.all().order_by('-timestamp')
    serializer_class = ArticleLikeSerializer
    filter_backends = [LikeDislikeFilterBackend,DjangoFilterBackend]
    filterset_fields = ['author','article']
    pagination_class = StandardResultsSetPagination

class PublicUserFollowingViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [AuthorPublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedUserFollowingViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [FollowedAuthorFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicUserFollowedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [ProfilePublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedUserFollowedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [FollowingAuthorFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class UserFollowingViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [UserRequestFilterBackend]
    pagination_class = StandardResultsSetPagination


class UserFollowedViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserFollow.objects.all().order_by('-timestamp')
    serializer_class = UserFollowSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination




class PublicArticleCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleComment.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentSerializer
    filter_backends = [PublicArticleCommentFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','article']


class PublicUserCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserComment.objects.all().order_by('-timestamp')
    serializer_class = UserCommentSerializer
    filter_backends = [PublicUserCommentFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','profile']


class FollowedArticleCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleComment.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentSerializer
    filter_backends = [FollowedArticleCommentFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','article']


class FollowedUserCommentViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserComment.objects.all().order_by('-timestamp')
    serializer_class = UserCommentSerializer
    filter_backends = [FollowedUserCommentFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author','profile']

class PublicUserMailViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserMail.objects.all().order_by('-timestamp')
    serializer_class = UserMailSerializer
    filter_backends = [AuthorPublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicUserPhoneViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserPhone.objects.all().order_by('-timestamp')
    serializer_class = UserPhoneSerializer
    filter_backends = [AuthorPublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicUserLocationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserLocation.objects.all().order_by('-timestamp')
    serializer_class = UserLocationSerializer
    filter_backends = [AuthorPublicUserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']


class UserCommentLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserCommentLike.objects.all().order_by('-timestamp')
    serializer_class = UserCommentLikeSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCommentLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCommentLike.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentLikeSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCommentDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCommentDislike.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentDislikeSerializer
    filter_backends = [ArticleFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserCommentDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserCommentDislike.objects.all().order_by('-timestamp')
    serializer_class = UserCommentDislikeSerializer
    filter_backends = [UserFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserCommentUnLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserCommentLike.objects.all().order_by('-timestamp')
    serializer_class = UserCommentLikeSerializer
    filter_backends = [LikeDislikeFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCommentUnLikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCommentLike.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentLikeSerializer
    filter_backends = [LikeDislikeFilterBackend]
    pagination_class = StandardResultsSetPagination

class ArticleCommentUnDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCommentDislike.objects.all().order_by('-timestamp')
    serializer_class = ArticleCommentDislikeSerializer
    filter_backends = [LikeDislikeFilterBackend]
    pagination_class = StandardResultsSetPagination

class UserCommentUnDislikeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = UserCommentDislike.objects.all().order_by('-timestamp')
    serializer_class = UserCommentDislikeSerializer
    filter_backends = [LikeDislikeFilterBackend]
    pagination_class = StandardResultsSetPagination

class FollowedArticleFIOViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all()
    serializer_class = ArticleFIOSerializer
    filter_backends = [NonGroupArticlesFilterBackend]
    pagination_class = FIOResultsSetPagination


class PublicArticleFIOViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Article.objects.all()
    serializer_class = ArticleFIOSerializer
    filter_backends = [PublicArticleFilterBackend]
    pagination_class = FIOResultsSetPagination

class PublicReservationDeactivationMonthViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ReservationDeactivationMonth.objects.all().order_by('-timestamp')
    serializer_class = ReservationDeactivationMonthSerializer
    filter_backends = [PublicReservationDMFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class FollowedReservationDeactivationMonthViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ReservationDeactivationMonth.objects.all().order_by('-timestamp')
    serializer_class = ReservationDeactivationMonthSerializer
    filter_backends = [FollowedReservationDMFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class ReservationDeactivationMonthViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ReservationDeactivationMonth.objects.all().order_by('-timestamp')
    serializer_class = ReservationDeactivationMonthSerializer
    filter_backends = [UserFilterBackend,DjangoFilterBackend]
    pagination_class = StandardResultsSetPagination
    filterset_fields = ['author']

class PublicArticleCategorySearchViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleCategorySerializer
    filter_backends = [AuthorPublicUserFilterBackend,filters.SearchFilter]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^author__id','^category']

class FollowedArticleCategorySearchViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = ArticleCategory.objects.all().order_by('-timestamp')
    serializer_class = ArticleCategorySerializer
    filter_backends = [FollowedAuthorFilterBackend,filters.SearchFilter]
    pagination_class = StandardResultsSetPagination
    search_fields = ['^author__id','^category']
