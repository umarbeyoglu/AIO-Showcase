import 'package:repository.dart';

String addchoicest=languagest == 'EN' ? 'Add Choice':'';
String addextendeddetailsst=languagest == 'EN' ? 'Add Extended Details':'';
String reservationst =languagest == 'EN' ? 'Reservation': '';
String crowdnesssearchst =languagest == 'EN' ? 'Crowd Level': '';
String crowdnessst =languagest == 'EN' ? 'Crowd Level': '';
String adultsandkidsst =languagest == 'EN' ? 'Adults&Kids': '';
String bedroomsandbathroomsst =languagest == 'EN' ? 'Bedrooms&Bathrooms': '';
String edithotelinfost =languagest == 'EN' ? 'Edit Hotel Info': '';
String searchprofilest =languagest == 'EN' ? 'Search Profile': '';
String activitiesst=languagest == 'EN' ? 'Activities':'';
String includedst=languagest == 'EN' ? 'Included':'';
String rulesst=languagest == 'EN' ? 'Rules':'';
String searchinprofilest=languagest == 'EN' ? 'Search In Profile':'';
String canceledappointmentst=languagest == 'EN' ? 'Canceled Appointment':'';
String meetingschedulesst=languagest == 'EN' ? 'Meeting Schedules':'';
String gotopostsst=languagest == 'EN' ? 'Go To Posts':'';
String amenitiesst=languagest == 'EN' ? 'Amenities':'';
String highlightsst=languagest == 'EN' ? 'Highlights':'';
String travellocationsst=languagest == 'EN' ? 'Travel Locations':'';
String nocommentsyetst=languagest == 'EN' ? 'No Comments Yet' : '';
String iswhatsappst=languagest == 'EN' ? 'Is Whatsapp Number' : '';
String istelegramst=languagest == 'EN' ? 'Is Telegram Number' : '';

bool isstringnullsearch(String text){
  if(text == null){return true;}
  if(text == ''){return true;}
  if(text == ' '){return true;}
  if(text == '-'){return true;}
  if(text == '0'){return true;}
  if(text == 'null'){return true;}
  return false;
}

bool isstringnull(String text){
  if(text == null){return true;}
  if(text == ''){return true;}
  if(text == ' '){return true;}
  if(text == '-'){return true;}
  if(text == 'null'){return true;}
  return false;
}

bool isintnull(int text){
  if(text == null){return true;}
  if(text == 0){return true;}
  if(text < 0){return true;}
  return false;
}

String firsttimeaboutexpst =languagest == 'EN' ? 'Tell people something about you. People will read it when they'
    'enter your profile': 'İnsanlara kendiniz'
    'hakkında birşeylerden bahsedin.Profilinizi ziyaret ettiklerinde bu yazıyı okuyacaklardır.';

String firsttimehotelinfoexpst =languagest == 'EN' ? 'Enter your class and tick the box if this account is for your hotel': '.';
String firsttimeaboutbsexpst =languagest == 'EN' ? 'Tell people something about your business. People will read it when they'
    'enter your profile': 'İnsanlara işletmeniz'
    'hakkında birşeylerden bahsedin.Profilinizi ziyaret ettiklerinde bu yazıyı okuyacaklardır.';

String firsttimecalendarexpst =languagest == 'EN' ? 'Choose your calendar type so you can announce what you are'
    'up to in certain dates,so you can set appointments with clients': 'Takvim çeşidinizi seçin. Seçtiğinizde yapacağınız etkinlikleri'
    'gösterebilir veya müşterilerinizle randevu alabilirsiniz';
String firsttimeimageexpst =languagest == 'EN' ? 'Create a Profile Picture so other people can identify you'
    : 'Profil resmi eklemeniz insanlar sizi tanımasına yardımcı olur.';

String firsttimeimagebsexpst =languagest == 'EN' ? 'Create a Profile Picture so other people can identify your business'
    : 'Profil resmi eklemeniz insanlar işletmenizi tanımasına yardımcı olur.';

String firsttimenameexpst =languagest == 'EN' ? 'Enter your name so people can identify you': ''
    'Sizin ismini girin ki insanlar sizi tanıyabilsin';
String firsttimenamebsexpst =languagest == 'EN' ? 'Enter your business name so people can identify your business': ''
    'İşletmenizin ismini girin ki insanlar işletmenizi tanıyabilsin';

String firsttimelocationexpst =languagest == 'EN' ? 'Use location so you can be more relevant when'
    'people search for your profile': 'Konum kullanmanız kullancılar profilinizi ararken sizi gösterme sıklığı artar.';

String firsttimewifiexpst =languagest == 'EN' ? 'Enter wifi information so clients can use your wifi.'
    '': 'Wifi bilgilerinizi girerseniz kullanıcılar internetinize erişebilir.';

String firsttimecreditcardinfoexpst=languagest == 'EN' ? 'Upload your credit card info so we can send you payments' :
'Kredi kartı bilgilerinizi girin ki size ödemeleri gönderebilelim';

String firsttimephoneexpst =languagest == 'EN' ? 'Enter your Whatsapp Number so people that visit your profile'
    'can contact you from Whatsapp': 'Whatsapp numaranızı girerseniz kullanıcılar profilinize girdiğinde siz Whatsapptan ulaşabilir';
String firsttimepricerangeexpst =languagest == 'EN' ? 'Choose your price range so people can expect costs of'
    'choosing your business': 'Fiyat aralığınızı seçin ki insanlar sizin işletmenizi kullanmadan önce maliyetinizi bilsinler';
String firsttimepublicprofileexpst =languagest == 'EN' ? 'Is your profile going to be open for view by everyone?':
'Profiliniz herkese açık mı olacak?';
String firsttimetagsexpst =languagest == 'EN' ? 'Add some tags to distinct your profile'
    : 'Profilinizi farklılaştırmak için tag ekleyiniz';
String articlelikest = languagest == 'EN' ? 'liked your article':'postunuzu beğendi';
String articlecommentst =languagest == 'EN' ? 'commented on your article': 'postunuza yorum yaptı';
String usercommentst = languagest == 'EN' ? 'commented on your profile':'profilinize yorum yaptı';
String allchooseablest = languagest == 'EN' ? 'All Chooseable':'Hepsi Seçilebilir';
String calendaritemcommentst = languagest == 'EN' ? 'commented on your calendar item':'takvim ürününüze yorum yaptı';
String calendareventcommentst =languagest == 'EN' ? 'commented on your calendar event': 'takvim etkinliğinize yorum yaptı';
String userproductcommentst = languagest == 'EN' ? 'commented on your user product':'kullanıcı ürününüze yorum yaptı';
String userservicecommentst =languagest == 'EN' ? 'commented on your user service': 'kullanıcı servisinize yorum yaptı';
String articleusertagst = languagest == 'EN' ? 'tagged you in an article':'postta sizi etiketledi';
String unspecifiedst =languagest == 'EN' ? 'Unspecified':'Belirtilmemiş';
String quietst=languagest == 'EN' ? 'Quiet':'Sessiz';
String addtolistst=languagest == 'EN' ? 'Add To List':'Listeye Ekle';
String removefromlistst=languagest == 'EN' ? 'Remove From List':'Listeden Çıkar';
String premiumst=languagest == 'EN' ? 'Expensive':'Pahalı';
String highst=languagest == 'EN' ? 'High':'Yüksek';
String stockst=languagest == 'EN' ? 'Stock':'Stok';
String payst=languagest == 'EN' ? 'Pay':'Öde';
String countst=languagest == 'EN' ? 'Count':'Adet';
String ownerst=languagest == 'EN' ? 'Owner':'Sahip';
String feest=languagest == 'EN' ? 'Fee':'Ücret';
String namesurnamest=languagest == 'EN' ? 'Name Surname':'İsim Soyisim';
String ibannost=languagest == 'EN' ? 'IBAN NO':'IBAN NUMARASI';
String deliveryoptionst=languagest == 'EN' ? 'Food Delivery Option':'Yemek Teslim Tipi';
String reservationcommentst=languagest == 'EN' ? 'Reservation Comment':'Rezervasyon Yorumu';
String reservationsst=languagest == 'EN' ? 'Reservations':'Rezervasyonlar';
String addreservationsst=languagest == 'EN' ? 'Add Reservation':'Rezervasyon ekle';
String firsttimebusinessst=languagest == 'EN' ? 'Business Type':'İşletme Tipi';
String restaurantst=languagest == 'EN' ? 'Restaurant':'Restoran';
String groceryshopst=languagest == 'EN' ? 'Grocery Shops':'Bakkallar';
String deliverydatest=languagest == 'EN' ? 'Delivery Date':'Teslim Günü';
String deliverytimest=languagest == 'EN' ? 'Delivery Time':'Teslim Saati';
String daysareunavailablest=languagest == 'EN' ? 'Days are Unavailable!':'Günler Uygun Değil!';
String firsttimebusinessexpst=languagest == 'EN' ? 'If your business is considered as one of these types,please choose it':'Eğer işletmeniz bu şıklardan birine uyuyorsa lütfen seçiniz';

String daysst=languagest == 'EN' ? 'Days':'Günler';
String itemsst=languagest == 'EN' ? 'Items':'Ürünler';
String monthandyearst=languagest == 'EN' ? 'Month and Year':'Ay ve Yıl';
String timesst=languagest == 'EN' ? 'Times':'Saatler';
String meetingstatuswarningst=languagest == 'EN' ? 'Deleting them wont affect any schedule or requests': "Saatleri silmenin randevu ve isteklere bir etkisi olmayacaktır";

String deniedmeetingrequestst=languagest == 'EN' ? 'Denied meeting request':'Toplantı isteğini reddetti';
String acceptedmeetingrequestst=languagest == 'EN' ?  'Accepted meeting request':'Toplantı isteğini kabul etti';
String sentmeetingdetailsst=languagest == 'EN' ? 'Sent meeting details':'Toplantı detaylarını gönderdi';
String sentmeetingrequestst=languagest == 'EN' ? 'Sent meeting request':'Toplantı isteği gönderdi';
String sendmeetingrequestst=languagest == 'EN' ? 'Send meeting request':'Toplantı isteği gönder';
String meetingst=languagest == 'EN' ? 'Meeting':'Toplantı';

String startdatest=languagest == 'EN' ? 'Start Date':'Başlangıç Günü';
String enddatest=languagest == 'EN' ? 'End Date':'Bitiş Günü';

String doyouwanttodeletethisst=languagest == 'EN' ? 'Do you want to delete this?':'Bu öğeyi silmek istiyor musunuz?';
String appointmentstypest=languagest == 'EN' ? 'Appointment Type':'Randevu Tipi';
String appointmentsettingsst=languagest == 'EN' ? 'Appointment Settings':'Randevu Ayarları';
String takenappointmentsst=languagest == 'EN' ? 'Created Appointments':'Alınmış Randevular';
String publishst=languagest == 'EN' ? 'Publish':'Yayınla';

String registerst=languagest == 'EN' ? 'Register':'Kaydol';
String clickherest=languagest == 'EN' ? 'Click Here':'Buraya Tıkla';
String clientprofilest=languagest == 'EN' ? 'Client Profile':'Müşteri Profili';
String itemdetailsst=languagest == 'EN' ? 'Item Details':'Ürün Detayları';
String editmerchantinfost=languagest == 'EN' ? 'Edit Merchant Information':'Tüccar Bilgisini Düzenle';
String firsttimecreditcardinfost=languagest == 'EN' ? 'Credit Card Information':'Kredi Kartı bilgisi';
String firsttimewifist =languagest == 'EN' ? 'Wi-Fi': "Wi-Fi";
String checkoutst =languagest == 'EN' ? 'Cart': "Sepet";
String contactst=languagest == 'EN' ? 'Contact Number':'İletişim Numarası';
String addressst=languagest == 'EN' ? 'Delivery Address':'Teslim Adresi';
String productnamest=languagest == 'EN' ? 'Product Name':'Ürün İsmi';
String specialrequestst=languagest == 'EN' ? 'Special Request (Optional)':'Ekstra İstek (İsteğe bağlı)';
String boughtanitemst=languagest == 'EN' ? 'bought an item':'ürün satın aldı';
String isbuyenabledst=languagest == 'EN' ? 'Enable Buy Option':'Satın Almayı Etkinleştir';
String areyouincyprusst=languagest == 'EN' ? 'Are you in living in Cyprus?':"Kıbrıs'ta mı yaşıyorsunuz?";
String clearst=languagest == 'EN' ? 'Clear':'Temizle';
String mailst=languagest == 'EN' ? 'Mail':'Posta';
String dislikesst=languagest == 'EN' ? 'Dislikes':'Beğenmeyenler';
String phonest=languagest == 'EN' ? 'Phone':'Telefon';
String choosedatest=languagest == 'EN' ? 'Choose Date':'Tarih Seçin';
String standardst=languagest == 'EN' ? 'Standard':'Standart';
String operatingasusualst=languagest == 'EN' ? 'Operating Usually':'Her zamanki gibi işliyor';
String underservicechangesst=languagest == 'EN' ? 'Under Service Changes':'Servis değişiklikleri altında';
String temporarilyclosedst=languagest == 'EN' ? 'Temporarily closed':'Geçici olarak kapalı';
String permanentlyclosedst=languagest == 'EN' ? 'Permanently closed':'Kalıcı olarak kapalı';
String businessstatusst =languagest == 'EN' ? 'Business Status': "İşletme Durumu";
String pricerangest =languagest == 'EN' ? 'Price Range': "Fiyat Aralığı";
String jobpostingst =languagest == 'EN' ? 'Job Posting': "İş ilanı";
String skipst =languagest == 'EN' ? 'Skip': 'Atla';
String starst =languagest == 'EN' ? 'Star': 'Yıldız';

String starsst =languagest == 'EN' ? 'Stars': 'Yıldız';

String productconditionst =languagest == 'EN' ? 'Product Condition': 'Ürün durumu';
String skipallst =languagest == 'EN' ? 'Skip All': 'Hepsini Atla';
String hotelclassst =languagest == 'EN' ? 'Hotel Class': 'Otel Sınıfı';



String firsttimeaboutst =languagest == 'EN' ? 'About': 'Hakkınızda';
String firsttimecalendarst =languagest == 'EN' ? 'Setup Your Calendar': 'Takviminizi Ayarlayın';
String firsttimeimagest =languagest == 'EN' ? 'Upload an Image': 'Resminizi Yükleyin';
String firsttimenamest =languagest == 'EN' ? 'Enter Your Name': 'İsminizi Yükleyin';
String firsttimephonest =languagest == 'EN' ? 'Enter Your Whatsapp Number': 'Whatsapp Numaranızı Yükleyin';
String firsttimelocationst =languagest == 'EN' ? 'Enter Your Location': 'Konumunuzu Girin';
String firsttimepricerangest = languagest == 'EN' ? 'Enter Your Price Range':'Fiyat Aralığınızı Girin';
String firsttimepublicprofilest =languagest == 'EN' ? 'Is Your Profile Public?': 'Profiliniz Genele Açık mı?';
String firsttimetagsst = languagest == 'EN' ? 'Enter Your Tags':'Taglarınızı Girin';
String mailsst=languagest == 'EN' ? 'Contact Mails':'İletişim Mailleri';
String clientst=languagest == 'EN' ? 'Client' : 'Müşteri';
String phonesst=languagest == 'EN' ? 'Contact Phones':'İletişim Telefonları';
String locationsst=languagest == 'EN' ? 'Contact Locations':'İletişim Konumları';
String requestedfollowingservicest = languagest == 'EN' ? 'Requested Following Service': "şu servis için istekte bulundu";
String personst = languagest == 'EN' ? 'Person': "Kişi";
String businessst = languagest == 'EN' ? 'Business' : "İşletme";
String welcomest = languagest == 'EN' ?'Welcome!': "Hoşgeldiniz!";
String emailst =languagest == 'EN' ? 'Email': "Email";
String grouptagsearchst =languagest == 'EN' ? 'Group Tags': "Grup Tagları";
String verybusyst =languagest == 'EN' ? 'Very Busy': "Çok Kalabalık";
String busyst =languagest == 'EN' ? 'Busy': "Kalabalık";
String normalst =languagest == 'EN' ? 'Normal': "Normal";
String lowst =languagest == 'EN' ? 'Low': "Düşük";
String sendst =languagest == 'EN' ? 'Send': "Gönder";
String dislikest =languagest == 'EN' ? 'Dislike': "Beğenmedim";
String undislikest =languagest == 'EN' ? 'Undislike': "Geri Al";
String deniedyourservicest =languagest == 'EN' ? 'Denied your service request': "Servis isteğinizi reddetti";
String acceptedyourservicest =languagest == 'EN' ? 'Accepted your service request': "Servis isteğinizi kabul etti";
String explanationst =languagest == 'EN' ? 'Explanation': "Açıklama";
String choosedatesst =languagest == 'EN' ? 'Choose dates': "";
String calendarstatusexpst =languagest == 'EN' ? 'Create Status so your clients will choose from specified date&time': "";
String extendedfiltersst =languagest == 'EN' ? 'Extended Filters': "Gelişmiş Filtreleme";
String explanationforacceptordenyst =languagest == 'EN' ? 'Explanation for Accepting/Denying': "Kabul/Reddetme için Açıklama";
String servicenamest =languagest == 'EN' ? 'Service Name': "Servis İsmi";
String userservicecategoriesst =languagest == 'EN' ? 'User Service Categories': "Kullanıcı Servis Kategorileri";
String formcategoriesst =languagest == 'EN' ? 'Form Categories': "Form Kategorileri";
String productcategoriesst =languagest == 'EN' ? 'Product Categories': "Ürün Kategorileri";
String requireimagesst =languagest == 'EN' ? 'Require Images option': "Gerekli Fotoğraflar seçeneği";
String addformst =languagest == 'EN' ? 'Add Form': "Form ekle";
String searchthingsst =languagest == 'EN' ? 'Search Stuff': "Bişeyler ara";
String addcheckboxst =languagest == 'EN' ? 'Add Checkbox': "Tik Kutusu Ekle";
String idlest =languagest == 'EN' ? 'Idle': "Boş";
String minimumst =languagest == 'EN' ? 'Minimum': "Minimum";
String maximumst = languagest == 'EN' ? 'Maximum': "Maksimum";
String calendarschedulesst =languagest == 'EN' ? 'Calendar Schedules': "Takvim Randevuları";
String publicst =languagest == 'EN' ? 'Public': "Erişime Açık";
String darklightthemest =languagest == 'EN' ? 'Change Dark/Light Theme ': "Parlak/Karanlık Temayı Değiştir ";
String requestedfollowingproductst =languagest == 'EN' ? 'Requested Following Product:': "Aşağıdaki Ürünü Talep Etti:";
String makeadmin =languagest == 'EN' ? 'Make Admin': "Admin Yap";
String makemod =languagest == 'EN' ? 'Make Mod': "Mod Yap";
String subprofilesst =languagest == 'EN' ? 'Subusers': "Alt Kullanıcılar";
String interestst =languagest == 'EN' ? 'Interest': "İlgilen";
String bookmarkst =languagest == 'EN' ? 'Bookmark': "Yer imi";
String intensityst =languagest == 'EN' ? 'Crowdness': "Kalabalık";
String isprofileanonst =languagest == 'EN' ? 'Is Sub-user Private?': "Alt-kullanıcı gizli mi?";
String removefrommod =languagest == 'EN' ? 'Remove Mod': "Remove Mod";
String groupnamest =languagest == 'EN' ? 'Group Name': "Grup İsmi";
String activatest =languagest == 'EN' ? 'Activate': "Aktif Et";
String nothingtoseeherest =languagest == 'EN' ? 'Nothing to see here': "Görülecek birşey yok";
String deactivatest =languagest == 'EN' ? 'Deactivate': "Deaktive Et";
String joinst =languagest == 'EN' ? 'Subscribe': "Katıl";
String sharest =languagest == 'EN' ? 'Share': "Paylaş";
String removefromgroupst =languagest == 'EN' ? 'Remove From Group': "Gruptan Çıkar";
String deletest =languagest == 'EN' ? 'Delete': "Sil";
String bookmarksst =languagest == 'EN' ? 'Bookmarks': "Yer İmleri";
String issuest =languagest == 'EN' ? 'Issue': "Sorun";
String noissueenteredst =languagest == 'EN' ? 'No Issue Entered': "Sorun girilmedi";
String leavest =languagest == 'EN' ? 'Unsubscribe': "Çık";
String aboutst =languagest == 'EN' ? 'About': "Hakkında";
String groupmembersst =languagest == 'EN' ? 'Group Members': "Grup Üyeleri";
String taguserst =languagest == 'EN' ? 'Tag Users': "Kullanıcı Etiketle";
String editgroupst =languagest == 'EN' ? 'Edit Group': "Grubu Düzenle";
String isprivatest =languagest == 'EN' ? 'Private': "Gizli";
String namest =languagest == 'EN' ? 'Name': "İsim";
String productsandformsst =languagest == 'EN' ? 'Products and Services': "Ürünler ve Servisler";
String choosegroupst =languagest == 'EN' ? 'Choose Group': "Grup Seç";
String groupsst =languagest == 'EN' ? 'Groups': "Gruplar";
String timestatusexpst =languagest == 'EN' ? 'Add times you want inside status here': "";
String subusersst =languagest == 'EN' ? 'Sub users': "Alt kullanıcılar";
String nonameenteredst =languagest == 'EN' ? 'No Name Entered': "İsim girilmedi";
String emailinst =languagest == 'EN' ? 'Email*': "Email*";
String eyemailst = languagest == 'EN' ?'Enter your email': "Emailinizi girin";
String passwordst =languagest == 'EN' ? 'Password': "Şifre";
String passwordinst =languagest == 'EN' ? 'Password*': "Şifre*";
String eypasswordst = languagest == 'EN' ?'Enter your password': "Şifrenizi girin";
String validpsst =languagest == 'EN' ? 'Must be at least 6 characters': "6 Karakter gerekli";
String validps2st =languagest == 'EN' ? 'Please enter a password': "Lütfen şifrenizi girin";
String loginst =languagest == 'EN' ? 'Login': "Giriş yap";
String emailerrorst = languagest == 'EN' ? 'Please enter your email correctly': "Lütfen emailinizi doğru girin";
String emailerror2st = languagest == 'EN' ? 'Please enter a valid email': "Lütfen geçerli bir email girin";
String imageerrorst = languagest == 'EN' ? 'Please insert your image': "Lütfen resim giriniz";
String locationerrorst = languagest == 'EN' ? 'Please enter your location': "Lütfen konumunuzu girin";
String phonenumbererrorst =  languagest == 'EN' ? 'Please enter your phone number': "Lütfen telefon numaranızı girin";
String passworderrorst = languagest == 'EN' ? 'Please enter your password correctly': "Lütfen şifrenizi doğru girin";
String inputerrorst = languagest == 'EN' ? 'Please check your input and try again': "Lütfen girdiklerinizi kontrol edip tekrar deneyin";
String postcreatesuccessst = languagest == 'EN' ? 'Post Created!We will redirect you to homepage shortly!': "Başarılı!Sizi kısa sürede yönlendireceğiz!";
String postcreateinformationst = languagest == 'EN' ? 'Please wait for the pictures to upload..': "Lütfen resimlerin yüklenmesini bekleyin..";
String joinusst =languagest == 'EN' ? 'Join us!': "Bize katılın!";
String tfcamerast = languagest == 'EN' ?'Take from camera': "Kamerayı kullan";
String tfphonest = languagest == 'EN' ?'Take from phone': "Galeriyi kullan";
String profiletypest =languagest == 'EN' ? 'User Type :': "Kullanıcı tipi :";
String genderst =languagest == 'EN' ? 'Gender :': "Cinsiyet :";
String requiredst = languagest == 'EN' ?'Required*': "Gerekli*";
String validemailst =languagest == 'EN' ? 'Please enter a valid email': "Lütfen geçerli bir mail girin";
String validusernamest =languagest == 'EN' ? 'Please enter a username': "Lütfen bir kullanıcı adı girin";
String usernamest =languagest == 'EN' ? 'Username*': "Kullanıcı adı*";
String eyusernamest =languagest == 'EN' ? 'Enter your username': "Kullanıcı adınızı girin";
String firstnamest =languagest == 'EN' ? 'First Name': "Ad";
String requiredinfost =languagest == 'EN' ? 'Required Information': "Gerekli Bilgi";
String personalinfost =languagest == 'EN' ? 'Personal Information': "Kişisel Bilgi";
String businessinfost =languagest == 'EN' ? 'Business Information': "İşletme Bilgisi";
String fullnamest =languagest == 'EN' ? 'Full Name': "Ad Soyad";
String eyfirstnamest =languagest == 'EN' ? 'Enter your first name': "Adınızı girin";
String eyfullnamest =languagest == 'EN' ? 'Enter your full name': "Ad,soyad girin";
String lastnamest =languagest == 'EN' ? 'Last Name': "Soyad";
String eylastnamest =languagest == 'EN' ? 'Enter your last name': "Soyadınızı girin";
String locationst =languagest == 'EN' ? 'Location': "Konum";
String location2st =languagest == 'EN' ? 'Location:': "Konum:";
String datest = languagest == 'EN' ? 'Date:': "Tarih:";
String eylocationst =languagest == 'EN' ? 'Enter your location': "Konumunuzu girin:";
String phonenost =languagest == 'EN' ? 'Whatsapp Number': "Whatsapp numarası";
String eyphonenost =languagest == 'EN' ? 'Enter your whatsapp number': "Lütfen whatsapp numarası girin";
String eyaboutst =languagest == 'EN' ? 'About you': "Hakkınızda";
String usertagsst =languagest == 'EN' ? 'Tags': "Taglar";
String postedbyst =languagest == 'EN' ? 'Posted by:': "Şu kişi paylaştı:";
String posttagsst =languagest == 'EN' ? 'Tags': "Taglar";
String eyposttagsst =languagest == 'EN' ? 'Enter your tags': "Taglarınızı girin:";
String changest =languagest == 'EN' ? 'Change': "Değiştir";
String eypersontagsst =languagest == 'EN' ? 'Tags (Split with ,) Ex:Bookworm,Social etc..': "Taglar (, ile ayır) Ör:Kitapkurdur,sosyal vb..";
String eybusinesstagsst =languagest == 'EN' ? 'Tags (Split with ,) Ex:Car Dealer,Accounting etc...': "Taglar (, ile ayır) Ör:Pet shop,muhasebeci vb..";
String signupst =languagest == 'EN' ? "Register": "Kaydol";
String errortruest =languagest == 'EN' ? 'Either server is not running or there is a problem with your input': "Ya server çalışmıyor ya da girdiklerinizde sorun var.";
String signupsuccessst =languagest == 'EN' ? 'Success!We will redirect you shortly!': "Başarılı!Sizi kısa sürede yönlendireceğiz!";
String likest =languagest == 'EN' ? 'Like': "Beğen";
String likesst =languagest == 'EN' ? 'Likes': "Beğeniler";
String addsubusersst =languagest == 'EN' ? 'Add Subusers': "Altkullanıcı Ekle";
String editpostst =languagest == 'EN' ? 'Edit Post': "Postu Düzenle";
String backst =languagest == 'EN' ? 'Back': "Geri";
String donest = languagest == 'EN' ?'Done': "Tamam";
String commentst = languagest == 'EN' ?'Comment': "Yorum";
String writeacommentst =languagest == 'EN' ? 'Write a Comment...': "Yorum yaz...";
String writeafeedbackst =languagest == 'EN' ? 'Write a Feedback...': "Geridönüş yaz...";
String comment2st =languagest == 'EN' ? 'Comments': "Yorumlar";
String authorst =languagest == 'EN' ? 'Author': "Yazar";
String detailsst =languagest == 'EN' ? 'Details': "Detaylar";
String eventdatest =languagest == 'EN' ? 'Event': "Etkinlik";
String details2st =languagest == 'EN' ? 'Details:': "Detaylar:";
String details3st =languagest == 'EN' ? 'Details (Optional)': "Detaylar (Gerekli Değil)";
String captionst =languagest == 'EN' ? 'Caption': "Genel yazı";
String logoutst  =languagest == 'EN' ? 'Logout': "Çıkış yap";
String morest =languagest == 'EN' ? 'More': "Daha fazla";
String categoryst =languagest == 'EN' ? 'Category': "Kategori";
String disablecommentsst =languagest == 'EN' ? 'Disable Comments': "Yorumları devre dışı bırak";
String disablestatsst =languagest == 'EN' ? 'Disable Stats': "İstatistikleri devre dışı bırak";
String nocaptionenteredst =languagest == 'EN' ? 'No caption entered': "Genel yazı girilmedi";
String notagenteredst =languagest == 'EN' ? 'No tag entered': "Taglar girilmedi";
String choosepicturesst =languagest == 'EN' ? 'Choose pictures': "Resim seç";
String eyposttags2st =languagest == 'EN' ? "Tags (Split with ,) Ex:Welpie,Flutter,Dart": "Taglar (, ile ayır)";
String followst =languagest == 'EN' ? 'Follow': "Takip et";
String followingst =languagest == 'EN' ? 'Following': "Takip edilenler";
String followersst =languagest == 'EN' ? 'Followers': "Takipçiler";
String confirmsst =languagest == 'EN' ? 'Confirms': "Onaylar";
String postsst =languagest == 'EN' ? 'Posts': "Paylaşımlar";
String unfollowst =languagest == 'EN' ? 'Unfollow': "Takipten çıkar";
String unlikest =languagest == 'EN' ? 'Unlike': "Beğeniyi kaldır";
String confirmst =languagest == 'EN' ? 'Confirm': "Onayla";
String unconfirmst =languagest == 'EN' ? 'Unconfirm': "Onayı kaldır";
String feedbacksst =languagest == 'EN' ? 'Feedbacks': "Geridönüşler";
String username2st =languagest == 'EN' ? 'Username:': "Kullanıcı adı:";
String edituserst =languagest == 'EN' ? 'Edit User': "Kullanıcıyı düzenle";
String deleteuserst =languagest == 'EN' ? 'Delete User': "Kullanıcıyı sil";
String deletemyprofilest =languagest == 'EN' ? 'Yes,delete my profile': "Evet,kullanıcıyı silin";
String gobackst =languagest == 'EN' ? 'Go Back': "Geri git";
String edituserrefreshst =languagest == 'EN' ? 'Note:When you apply the changes,please click Refresh Button in feed': "Not:Değişiklikleri kaydettiğinizde,lütfen ana sayfada Yenile tuşuna tıklayınız";
String remembermest =languagest == 'EN' ? 'Remember me': "Beni hatırla";
String mediast =languagest == 'EN' ? 'Media': "Medya";
String marketst =languagest == 'EN' ? 'Market': "Market";
String statusst =languagest == 'EN' ? 'Status': "Durum";
String malest =languagest == 'EN' ? 'Male': "Erkek";
String femalest =languagest == 'EN' ? 'Female': "Kadın";
String nonbinaryst =languagest == 'EN' ? 'Non-Binary': "Diğer";
String userst =languagest == 'EN' ? 'User': "Kişi";
String usertagssearchst =languagest == 'EN' ? 'User Tag': "Kişi tagı";
String groupsearchst =languagest == 'EN' ? 'Group': "Grup";
String posttagssearchst =languagest == 'EN' ? 'Post Tag': "Post tagı";
String postst =languagest == 'EN' ? 'Post': "Post";
String pricest =languagest == 'EN' ? 'Price': "Fiyat";
String postpricest =languagest == 'EN' ? 'Prices': "Fiyatlar";
String noitemschosenst =languagest == 'EN' ? 'No Items Chosen': "Ürün Seçilmedi";
String postcaptionst =languagest == 'EN' ? 'Post Caption': "Post genel yazısı";
String writeotherissueherest =languagest == 'EN' ? 'Write issue here': "Sorunu buraya yazın";
String postdetailsst =languagest == 'EN' ? 'Post Detail': "Post detayları";
String blockedusersst =languagest == 'EN' ? 'Blocked Users': "Engellenmiş Kullanıcılar";
String sharearticlest =languagest == 'EN' ? 'Share Article': "Postu Paylai";
String forbusinessst =languagest == 'EN' ? 'For Businesses': "İşletmeler için";
String unblockst =languagest == 'EN' ? 'Unblock': "Engeli Kaldır";
String calendarst =languagest == 'EN' ? 'Calendar': "Takvim";
String cancelrequestst =languagest == 'EN' ? 'Cancel Request': "İsteği Kaldır";
String sendsubscriptionrequestst =languagest == 'EN' ? 'Send Follow Request': "Takip İsteği Gönder";
String blockuserst =languagest == 'EN' ? 'Block User': "Kullanıcıyı Engelle";
String creategroupst =languagest == 'EN' ? 'Create Group': "Grup Kur";
String timest =languagest == 'EN' ? 'Time': "Saat";
String previousst =languagest == 'EN' ? 'Back': "Geri";
String nextst =languagest == 'EN' ? 'Next': "İleri";
String chooseimagesst =languagest == 'EN' ? 'Choose Images': "Resimleri Seç";
String entertimeherest =languagest == 'EN' ? 'Enter Time Here': "Saat Gir";
String acceptst =languagest == 'EN' ? 'Accept': "Kabul Et";
String denyst =languagest == 'EN' ? 'Deny': "Reddet";
String businessnamest =languagest == 'EN' ? 'Business Name': "İşletme İsmi";
String businesstypest =languagest == 'EN' ? 'Business Type': "İşletme Tipi";
String finishst =languagest == 'EN' ? 'Finish': "Bitir";
String nocalendarst =languagest == 'EN' ?"Calendar Disabled" : 'Takvim devre dışı';
String addtimest =languagest == 'EN' ? 'Add Time': "Saati Ekle";
String commitst =languagest == 'EN' ? 'Commit': "Bitir";
String adddatesst =languagest == 'EN' ? 'Add Dates': "Günleri Ekle";
String additemst =languagest == 'EN' ? 'Add Item': "Öğeyi ekle";
String choosetimesst =languagest == 'EN' ? 'Choose Times': "Saatleri Ekle";
String schedulerequestst =languagest == 'EN' ? 'Schedule Request': "Randevu İsteği";
String fullcalendarst =languagest == 'EN' ? 'All Features': "Tüm Özellikler";
String createsubuserst =languagest == 'EN' ? 'Create Sub-user': "Alt-Kullanıcı oluştur";
String gototimesst =languagest == 'EN' ? 'Go To Times': "Saatlere git";
String eventsonlyst =languagest == 'EN' ? 'Events Only': "Sadece Etkinlikler";
String chooseitemsst =languagest == 'EN' ? 'Choose Items': "Öğeleri Seç";
String requestsonlyst =languagest == 'EN' ? 'Requests Only': "Sadece İstekler";
String chooseitemsherest =languagest == 'EN' ? 'Choose Items Here': "Öğeleri buradan seç";
String reportuserst =languagest == 'EN' ? 'Report User': "Kullanıcıyı Şikayet Et";
String dorequestst =languagest == 'EN' ? 'Do Request': "İstek Gönder";
String statusscreenst =languagest == 'EN' ? 'Status Screen': "Durum Ekranı";
String choosedatefromcalendarst =languagest == 'EN' ? 'Choose a day From Calendar': "Takvimden bir gün seç";
String reporttype1st =languagest == 'EN' ? 'Inappropriate/Vulgar content': "Uygunsuz/Kaba içerik";
String reporttype2st =languagest == 'EN' ? 'Gore Content': "Kanlı içerik";
String reporttype3st =languagest == 'EN' ? 'Abusive Behaviour': "Kötü davranış";
String reporttype4st =languagest == 'EN' ? 'Fake Account': "Sahte Hesap";
String reporttype5st =languagest == 'EN' ? 'Spam/advertising': "Spam/Reklam";
String reporttype6st =languagest == 'EN' ? 'Harrasment': "Taciz";
String highlightst = languagest == 'EN' ? 'Highlights' : 'Öne çıkanlar';
String reporttype7st =languagest == 'EN' ? 'Fraud': "Dolandırıcı";
String reporttype8st =languagest == 'EN' ? 'Other': "Diğer";
String ispromovideost =languagest == 'EN' ? 'Is Promotional Video': "Promosyon Videosu mu?";
String isjobpostingst =languagest == 'EN' ? 'Is Job Posting': "İş paylaşımı mı?";
String nsfwst =languagest == 'EN' ? 'NSFW': "NSFW";
String userservicesst =languagest == 'EN' ? 'User Services': "Kullanıcı Servisleri";
String calendareventsst =languagest == 'EN' ? 'Events': "Etkinlikler";
String calendaritemsst =languagest == 'EN' ? 'Appointments': "Randevular";
String banreasonst =languagest == 'EN' ? 'Ban Reason': "Ban Nedeni";
String reasonst =languagest == 'EN' ? 'Reason': "Neden";
String bantimest =languagest == 'EN' ? 'Ban Time': "Ban Süresi";
String nstlst =languagest == 'EN' ? 'NSTL': "NSTL";
String bannedusersst =languagest == 'EN' ? 'Banned Users': "Banlanmış Kullanıcılar";
String ratingsst =languagest == 'EN' ? 'Rating': "Oy";
String sensitivest =languagest == 'EN' ? 'Sensitive': "Hassas";
String spoilerst =languagest == 'EN' ? 'Spoiler': "Spoiler";
String allownsfwst =languagest == 'EN' ? 'Allow NSFW': "NSFW paylaşıma izin ver";
String allownstlst =languagest == 'EN' ? 'Allow NSTL': "NSTL paylaşıma izin ver";
String allowsensitivest =languagest == 'EN' ? 'Allow Sensitive': "Hassas paylaşıma izin ver";
String allowspoilerst =languagest == 'EN' ? 'Allow Spoiler': "Spoiler paylaşıma izin ver";
String pickimageerrorst =languagest == 'EN' ? 'Pick Image Error': "Resim alma hatası";
String pickimagevideoerrorst =languagest == 'EN' ? 'Pick Image/Video Error': "Resim/Video alma hatası";
String youhavenotyetpickedavideost =languagest == 'EN' ? 'You have not yet picked a video': "Herhangi bir video almadınız";
String youhavenotyetpickedanimageorvideost =languagest == 'EN' ? 'You have not yet picked  image/video': "Herhangi bir video/resim almadınız";
String youhavenotyetpickedanimagest =languagest == 'EN' ? 'You have not yet picked an image': "Herhangi bir resim almadınız";
String producttemplateest =languagest == 'EN' ? 'Product Template': "Ürün şablonu";
String eventtemplateest =languagest == 'EN' ? 'Event Template': "Etkinlik şablonu";
String servicetemplateest =languagest == 'EN' ? 'Service Template': "Servis şablonu";
String jobtemplateest =languagest == 'EN' ? 'Job Template': "İş şablonu";
String calendartypest =languagest == 'EN' ? 'Calendar Type': "Takvim çeşidi";
String yesst =languagest == 'EN' ? 'Yes': "Evet";
String nost =languagest == 'EN' ? 'No': "Hayır";
String cartst =languagest == 'EN' ? 'Cart': "Sepet";
String choosest =languagest == 'EN' ? 'Choose': "Seç";
String addtouserproductsst =languagest == 'EN' ? 'Add to user products': "Kullanıcı ürünlerine ekle";
String userproductcategoriesst =languagest == 'EN' ? 'User Product Categories': "Kullanıcı Ürün Kategorileri";
String userproductsst =languagest == 'EN' ? 'User Products': "Kullanıcı Ürünleri";
String userproducttagsst =languagest == 'EN' ? 'User Product Tags': "Kullanıcı Ürün Tagları";
String deletegroupst =languagest == 'EN' ? 'Delete Group' : "Grubu Sil";
String allowcalendarst =languagest == 'EN' ? 'Allow Calendar': "Takvime İzin Ver";
String allowsubusersst =languagest == 'EN' ? 'Allow Subusers': "Alt Kullanıcılara İzin Ver";
String ismultipleitemchoicecalendarst =languagest == 'EN' ? 'Is Multiple Item Choice Allowed': "Birden çok ürün seçmeye izniniz var mı?";
String addimagesst =languagest == 'EN' ? 'Add images here': "Resimleri buradan ekle";
String addeventsst =languagest == 'EN' ? 'Add event': "Etkinlik ekle";
String calendardayownschedulest = languagest == 'EN' ? 'Your own calendar schedules at same day': "Aynı günde olan takvim randevularınız";
String chosendatesst =languagest == 'EN' ? 'Chosen Dates': "Seçilen günler";
String date2st =languagest == 'EN' ? 'Date': "Tarih";
String searchfilterst =languagest == 'EN' ? 'Search Filter': "Arama Filtresi";
String jobapplicationsst =languagest == 'EN' ? 'Job Applications': "İş Başvuruları";
String additemsst =languagest == 'EN' ? 'Add Items': "Ürün ekle";
String eventsst =languagest == 'EN' ? 'Events': "Etkinlikler";
String formsst =languagest == 'EN' ? 'Forms': "Formlar";
String totalcostst =languagest == 'EN' ? 'Total Cost': "Toplam Maliyet";
String deniedyourrequestst =languagest == 'EN' ? 'Denied Your Request': "İsteğinizi reddetti";
String acceptedyourrequestst =languagest == 'EN' ? 'Accepted Your Request': "İsteğinizi kabul etti";

String descriptionst =languagest == 'EN' ? 'Description': "Açıklama";
String chooselocationst =languagest == 'EN' ? 'Choose Location': "Konum Seç";
String connectedbusinessesst =languagest == 'EN' ? 'Connected Businesses': "Bağlı İşletmeler";
String productsst =languagest == 'EN' ? 'Products': "Ürünler";
String appointmentsst =languagest == 'EN' ? 'Appointments': "Randevular";
String addstatusst =languagest == 'EN' ? 'Add Status': "Durum ekle";
String editstatusst =languagest == 'EN' ? 'Edit Status': "Durumu düzenle";
String chosenitemsst =languagest == 'EN' ? 'Chosen Items': "Seçilmiş ürünler";
String chosentimesst =languagest == 'EN' ? 'Chosen Times': "Seçilmiş zamanlar";
String otherst =languagest == 'EN' ? 'Other': "Diğer";
String termsandconditionsst =languagest == 'EN' ? 'I am older than 13 years old and i accept Terms&Conditions': "13 Yaşından büyüğüm ve Koşulları&Kuralları kabul ediyorum";
String termsandconditionserrorst =languagest == 'EN' ? 'Terms and Conditions are not accepted': "Koşullar ve kurallar kabul edilmedi";
String emailexistsst =languagest == 'EN' ? 'Email Exists': "Eposta zaten kayıtlı";
String usernameexistsst =languagest == 'EN' ? 'Username Exists': "Kullanıcı adı zaten kayıtlı";
String founderandcoderst =languagest == 'EN' ? 'Founder and Coder': "Kurucu ve kodlamacı";
String poweredbyflutterst =languagest == 'EN' ? 'Powered By Flutter': "Flutter tarafından yapıldı";
String sentgrouprequestst =languagest == 'EN' ? 'Sent Group Membership Request for group :': "Şu gruba üyelik isteği gönderdi";
String sentfollowrequestst =languagest == 'EN' ? 'Sent Follow Request': "Takip isteği gönderdi";
String sentcalendarrequestst =languagest == 'EN' ? 'Sent Calendar Request': "Takvim isteği gönderdi";
String sentreservationrequestst =languagest == 'EN' ? 'Sent Reservation Request': "Rezervasyon isteği gönderdi";
String sentcalendardetailsst =languagest == 'EN' ? 'Sent Calendar Details': "Takvim detaylarını gönderdi";
String deniedcalendarst =languagest == 'EN' ? 'denied date/time offered': "önerilen zamanı/saati reddetti";
String itemst =languagest == 'EN' ? 'Item': "Ürün";
String fromst =languagest == 'EN' ? 'From': "Burdan";
String restauranttypest =languagest == 'EN' ? 'Restaurant Type': "Restoran Tipi";
String tost =languagest == 'EN' ? 'To': "Buraya";
String foodsst =languagest == 'EN' ? 'Foods': "Yemekler";
String stockleftst = languagest == 'EN' ? 'Stock Left': "Kalan Stok";
String buyst =languagest == 'EN' ? 'Buy': "Satın Al";
String editst =languagest == 'EN' ? 'Edit': "Değiştir";

String checkintimest =languagest == 'EN' ? 'Check In Time': "";
String checkouttimest =languagest == 'EN' ? 'Check Out Time': "";
String readtimest =languagest == 'EN' ? 'Read Time': "";
String deliveredfromtimest =languagest == 'EN' ? 'Deliver Time (Min)': "";
String deliveredtotimest =languagest == 'EN' ? 'Deliver Time (Max)': "";
String bathroomsst =languagest == 'EN' ? 'Bathrooms': "";
String bedroomsst =languagest == 'EN' ? 'Bedrooms': "";
String addactivityst =languagest == 'EN' ? 'Add activities': "";
String addrulesst =languagest == 'EN' ? 'Add rules': "";
String enterdetailrulestextst =languagest == 'EN' ? 'Enter Rule Text': "";
String addamenitiesst =languagest == 'EN' ? 'Add amenities': "";
String enteramenitytextst =languagest == 'EN' ? 'Enter amenities Text': "";
String enterdetailincludedtextst =languagest == 'EN' ? 'Enter Thing included': "";
String adddetailincludedtextst =languagest == 'EN' ? 'Add things that are included': "";
String enteractivitytextst =languagest == 'EN' ? 'Enter activity text': "";
String addhighlightsst =languagest == 'EN' ? 'Add highlights': "";
String addtravellocationsst =languagest == 'EN' ? 'Add travel locations': "";
String enterhighlighttextst =languagest == 'EN' ? 'Enter highlight text': "";
String hideifoutofstockst =languagest == 'EN' ? 'Hide if out of stock': "";
String guidest =languagest == 'EN' ? 'Guide': "";
String adddetailincludedst =languagest == 'EN' ? 'Add Detail included': "";
String kidsst =languagest == 'EN' ? 'Kids': "";
String adultsst =languagest == 'EN' ? 'Adults': "";
String pricecurrencyst =languagest == 'EN' ? 'Price Currency': "";
String entertravellocationtextst =languagest == 'EN' ? 'Enter Travel Location Text': "";
String specialinstructionsst =languagest == 'EN' ? 'Special Instructions': "";

String nopostst =languagest == 'EN' ? 'Follow someone to see posts here': "Burada paylaşımlar görmek için birilerini takip edin";

String choosebycataloguest =languagest == 'EN' ? 'Search Places by Product Catalogue': "İşletmeleri Ürün Kataloğu ile Ara";
String bycataloguest =languagest == 'EN' ? 'Product Catalogue': "Ürün Kataloğu";
String deliveryst =languagest == 'EN' ? 'Delivery': "Paket Teslim";
String dineinst =languagest == 'EN' ? 'Dine-In': "Standart";
String pickupst =languagest == 'EN' ? 'Pick-Up': "Al Götür";
String offersst =languagest == 'EN' ? 'Offers': "";
String chooserestauranttypest =languagest == 'EN' ? 'Choose Restaurant Type': "Restoran Türünü Seç";


String creatememest =languagest == 'EN' ? 'Create Meme': "Meme Yarat";
String groceryshoppingst =languagest == 'EN' ? 'Grocery Shopping': "Bakkal Alışverişi";
String whatdoyouwanttocreatest =languagest == 'EN' ? 'What do you want to create?': 'Ne yapmak istiyorsunuz?';
String tutorialst =languagest == 'EN' ? 'Guide': 'Rehber';
String datetimeforappnst =languagest == 'EN' ? 'Give Client Date and Time for Appointment': 'Rehber';
String articlest =languagest == 'EN' ? 'Post': 'Paylaşım';
String clickusertountag =languagest == 'EN' ? 'Click User to Untag': 'Tagı kaldırmak için kullanıcıya tıklayın';
String chosencategoryst =languagest == 'EN' ? 'Chosen Catalogue': 'Seçilen Katalog';
String movearticleinsideacategoryst =languagest == 'EN' ? 'Move Article Inside a Catalogue': 'Makaleyi Kataloğa Yerleştir';
String searchtagsexclusivelyst =languagest == 'EN' ? 'Search with Tags Only': "Sadece Taglar ile Ara";
String city1 = 'Paphos/Baf';
String city2 =  'Nicosia/Lefkoşa';
String city3 = 'Larnaca/Larnaka';
String city4 = 'Kyrenia/Girne';
String city5 = 'Famagusta/Gazimağusa';
String city6 = 'Limassol';
String city7 = 'Güzelyurt';
String city8 = 'İskele';
String city9 = 'Lefke';
String settingsst =languagest == 'EN' ? 'Settings': "Ayarlar";
String publicprofilest =languagest == 'EN' ? 'Public Profile': "Açık profil";
String isdetailsprivatest =languagest == 'EN' ? 'Is Details Private': "Detaylar kapalı olacak mı?";
String calendarsettingsst =languagest == 'EN' ? 'Calendar Settings': "Takvim ayarları";
String sendfollowrequestst =languagest == 'EN' ? 'Send Follow Request': "Takip isteği gönder";
String blockst =languagest == 'EN' ? 'Block': "Engelle";
String reportst =languagest == 'EN' ? 'Report': "Şikayet et";
String censorst =languagest == 'EN' ? 'Censor': "Sensör";
String reservationdeactivateddaysst =languagest == 'EN' ? 'Reservation Deactivated Days': "";
String calendardatewarningst =languagest == 'EN' ? 'IF YOU ARE GOİNG TO CREATE STATUS FOR MULTİPLE MONTHS,CREATE ONE MONTH THEN CREATE ANOTHER MONTH!': "EĞER BİRDEN FAZLA AY İÇİN OLUŞTURACAKSANIZ,BİR AYI BİTİRİP SONRA TEKRARDAN GİRİP OLUŞTURUN!";
String calendarstatuswarningst =languagest == 'EN' ? 'Deleting them wont affect any schedule or requests': "Saatleri silmenin randevu ve isteklere bir etkisi olmayacaktır";
String timeforcalendarst =languagest == 'EN' ? "Time (Ör: 15.30-16.30/All Day)": "Saat (Ör: 15.30-16.30/Tüm Gün)";
String productst =languagest == 'EN' ? "Product": "Ürün";
String reservationschedulesst =languagest == 'EN' ? "Reservation Schedules": "";
String entercheckboxtextst =languagest == 'EN' ? "Enter Checkbox Text": "Tik Kutusu yazısını girin";
String enterformtextst =languagest == 'EN' ? "Enter Form Text": "Form Yazısını girin";

String articleincludescensoredcontentst(String censortype){
  if(languagest == 'EN'){
    return 'Click to see $censortype content';
  }
  if(languagest == 'TR'){
    return '$censortype içeren paylaşımı görmek için tıklayınız';
  }
}
String termsandconditionsdetailsst =languagest == 'EN' ? '''Preview your Terms & Conditions
Terms and Conditions
Welcome to Welpie App!

These terms and conditions outline the rules and regulations for the use of Welpie's application, located at Welpie Application.

By accessing this application we assume you accept these terms and conditions. Do not continue to use Welpie App if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this application and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.

License
Unless otherwise stated, Welpie and/or its licensors own the intellectual property rights for all material on Welpie App. All intellectual property rights are reserved. You may access this from Welpie App for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

Republish material from Welpie App
Sell, rent or sub-license material from Welpie App
Reproduce, duplicate or copy material from Welpie App
Redistribute content from Welpie App
This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Terms And Conditions Generator.

Parts of this application offer an opportunity for users to post and exchange opinions and information in certain areas of the application. Welpie does not filter, edit, publish or review Comments prior to their presence on the application. Comments do not reflect the views and opinions of Welpie,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Welpie shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this application.

Welpie reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

You are entitled to post the Comments on our application and have all necessary licenses and consents to do so;
The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy
The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant Welpie a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.

Hyperlinking to our Content
The following organizations may link to our application without prior written approval:

Government agencies;
Search engines;
News organizations;
Online directory distributors may link to our application in the same manner as they hyperlink to the applications of other listed businesses; and
System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our uygulama.
These organizations may link to our home page, to publications or to other application information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

commonly-known consumer and/or business information sources;
dot.com community sites;
associations or other groups representing charities;
online directory distributors;
internet portals;
accounting, law and consulting firms; and
educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Welpie; and (d) the link is in the context of general resource information.

These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our application, you must inform us by sending an e-mail to Welpie. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our application, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our application as follows:

By use of our corporate name; or
By use of the uniform resource locator being linked to; or
By use of any other description of our application being linked to that makes sense within the context and format of content on the linking party’s site.
No use of Welpie's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our application.

Content Liability
We shall not be hold responsible for any content that appears on your application. You agree to protect and defend us against all claims that is rising on your application. No link(s) should appear on any application that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Your Privacy
Please read Privacy Policy

Reservation of Rights
We reserve the right to request that you remove all links or any particular link to our application. You approve to immediately remove all links to our application upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our application, you agree to be bound to and follow these linking terms and conditions.

Removal of links from our application
If you find any link on our application that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this application is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the application remains available or that the material on the application is kept up to date.

Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our application and the use of this application. Nothing in this disclaimer will:

limit or exclude our or your liability for death or personal injury;
limit or exclude our or your liability for fraud or fraudulent misrepresentation;
limit any of our or your liabilities in any way that is not permitted under applicable law; or
exclude any of our or your liabilities that may not be excluded under applicable law.
The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.

As long as the application and the information and services on the application are provided free of charge, we will not be liable for any loss or damage of any nature.

Commerce Buy&Sell
All monetary transfers and actions are in Beta version,so are responsibility of business and client.We do not take fees,
so we DO NOT take ANY responsiblity against any problems.

''':
'''Şartlar ve Koşullarınızı önizleyin
Şartlar ve koşullar
Welpie Uygulamasına hoş geldiniz!

Bu hüküm ve koşullar, Welpie Uygulamasında bulunan Welpie uygulamasinin kullanımına ilişkin kural ve düzenlemeleri özetlemektedir.

Bu uygulamasine erişerek, bu hüküm ve koşulları kabul ettiğinizi varsayıyoruz. Bu sayfada belirtilen tüm hüküm ve koşulları kabul etmiyorsanız Welpie Uygulamasını kullanmaya devam etmeyin.

Bu Hüküm ve Koşullar, Gizlilik Bildirimi ve Sorumluluk Reddi Bildirimi ve tüm Sözleşmeler için aşağıdaki terminoloji geçerlidir: "Müşteri", "Siz" ve "Sizin", bu uygulamasinde oturum açan ve Şirketin hüküm ve koşullarına uyan kişi olarak sizi ifade eder. "Şirket", "Kendimiz", "Biz", "Bizim" ve "Biz", Şirketimizi ifade eder. "Taraf", "Taraflar" veya "Biz", hem Müşteriyi hem de kendimizi ifade eder. Tüm şartlar, Müşteriye, Şirketin belirtilen hizmetlerinin sağlanmasına ilişkin ihtiyaçlarının açık bir şekilde karşılanması amacıyla Müşteriye yardım sürecini en uygun şekilde üstlenmek için gerekli ödemenin teklifini, kabulünü ve değerlendirilmesini ifade eder. ve Hollanda'nın geçerli yasalarına tabidir. Yukarıdaki terminolojinin veya diğer kelimelerin tekil, çoğul, büyük harf kullanımı ve/veya kendisi veya bunlar birbirinin yerine kullanılabilir ve dolayısıyla aynı anlama gelir.

Kurabiye
Çerez kullanımı kullanıyoruz. Welpie Uygulamasına erişerek, Welpie'nin Gizlilik Politikasına uygun olarak çerezleri kullanmayı kabul etmiş olursunuz.

Çoğu etkileşimli uygulamasi, her ziyaret için kullanıcının ayrıntılarını almamıza izin vermek için çerezleri kullanır. Çerezler, uygulamamizi ziyaret eden kişilerin işini kolaylaştırmak için belirli alanların işlevselliğini sağlamak için uygulamamiz tarafından kullanılmaktadır. Bağlı kuruluş/reklam ortaklarımızdan bazıları da çerez kullanabilir.

Lisans
Aksi belirtilmedikçe, Welpie ve/veya lisans verenleri, Welpie Uygulamasındaki tüm materyallerin fikri mülkiyet haklarına sahiptir. Tüm fikri mülkiyet hakları saklıdır. Bu hüküm ve koşullarda belirlenen kısıtlamalara tabi olarak kendi kişisel kullanımınız için Welpie Uygulamasından buna erişebilirsiniz.

Yapmamalısın:

Welpie Uygulamasından materyali yeniden yayınlayın
Welpie App'ten malzeme satmak, kiralamak veya alt lisans vermek
Welpie Uygulamasından materyalleri çoğaltın, çoğaltın veya kopyalayın
İçeriği Welpie Uygulamasından yeniden dağıtın
Bu Sözleşme, işbu Sözleşme tarihinde başlayacaktır. Hüküm ve Koşullarımız, Hüküm ve Koşullar Oluşturucu yardımıyla oluşturulmuştur.

Bu uygulamasinin bölümleri, kullanıcılara uygulamasinin belirli alanlarında fikir ve bilgi gönderme ve alışverişinde bulunma fırsatı sunar. Welpie, Yorumları uygulamasinde bulunmadan önce filtrelemez, düzenlemez, yayınlamaz veya incelemez. Yorumlar, Welpie'nin, acentelerinin ve/veya bağlı kuruluşlarının görüş ve görüşlerini yansıtmaz. Yorumlar, görüş ve düşüncelerini yayınlayan kişinin görüş ve düşüncelerini yansıtır. Yürürlükteki yasaların izin verdiği ölçüde, Welpie Yorumlardan veya bu Yorumların herhangi bir şekilde kullanılması ve/veya yayınlanması ve/veya görünümünden kaynaklanan ve/veya maruz kalınan herhangi bir yükümlülük, zarar veya masraftan sorumlu olmayacaktır. İnternet sitesi.

Welpie, tüm Yorumları izleme ve uygunsuz, saldırgan olarak kabul edilebilecek veya bu Hüküm ve Koşulların ihlaline neden olabilecek Yorumları kaldırma hakkını saklı tutar.

Şunları garanti ve beyan ediyorsunuz:

Yorumları uygulamamizde yayınlama hakkına sahipsiniz ve bunun için gerekli tüm lisanslara ve izinlere sahipsiniz;
Yorumlar, herhangi bir üçüncü şahsın telif hakkı, patenti veya ticari markası dahil ancak bunlarla sınırlı olmamak üzere herhangi bir fikri mülkiyet hakkını ihlal etmez;
Yorumlar, mahremiyeti ihlal eden herhangi bir karalayıcı, karalayıcı, saldırgan, uygunsuz veya başka şekilde yasa dışı materyal içermemektedir.
Yorumlar, ticari faaliyetleri veya gelenekleri teşvik etmek veya teşvik etmek veya ticari faaliyetler veya yasa dışı faaliyetler sunmak için kullanılmayacaktır.
Burada Welpie'ye münhasır olmayan bir lisans veriyorsunuz, kullanmak, çoğaltmak, düzenlemek ve başkalarına herhangi bir şekilde, herhangi bir biçimde, formatta veya ortamda Yorumlarınızı kullanmak, çoğaltmak ve düzenlemek için yetki vermektesiniz.

İçeriğimize Köprü Oluşturma
Aşağıdaki kuruluşlar önceden yazılı onay almadan uygulamamize bağlanabilir:

Devlet kurumları;
Arama motorları;
Haber kuruluşları;
Çevrimiçi rehber dağıtıcıları, uygulamamize, listelenen diğer işletmelerin uygulamalerine köprü oluşturdukları gibi bağlantı verebilirler; ve
Kar amacı gütmeyen kuruluşlar, hayır amaçlı alışveriş merkezleri ve uygulamamize köprü oluşturamayan hayır kurumu bağış toplama grupları talep eden hariç, sistem çapında Akredite İşletmeler.
Bu kuruluşlar, bağlantı: (a) hiçbir şekilde yanıltıcı olmadığı sürece; (b) bağlantı veren tarafın ve ürünlerinin ve/veya hizmetlerinin sponsorluğunu, onayını veya onayını yanlış bir şekilde ima etmez; ve (c) bağlantı veren tarafın sitesi bağlamına uyması.

Aşağıdaki kuruluş türlerinden gelen diğer bağlantı isteklerini değerlendirebilir ve onaylayabiliriz:

yaygın olarak bilinen tüketici ve/veya ticari bilgi kaynakları;
dot.com topluluk siteleri;
hayır kurumlarını temsil eden dernekler veya diğer gruplar;
çevrimiçi dizin dağıtıcıları;
internet portalları;
muhasebe, hukuk ve danışmanlık firmaları; ve
eğitim kurumları ve ticaret birlikleri.
Aşağıdakilere karar verirsek, bu kuruluşlardan gelen bağlantı isteklerini onaylayacağız: (a) bağlantı kendimiz veya akredite işletmelerimiz için olumsuz görünmemize neden olmaz; (b) kuruluşun bizimle herhangi bir olumsuz kaydının olmaması; (c) köprünün görünürlüğünün bize sağladığı fayda, Welpie'nin yokluğunu telafi eder; ve (d) bağlantı, genel kaynak bilgileri bağlamındadır.

Bu kuruluşlar, bağlantı: (a) hiçbir şekilde yanıltıcı olmadığı; (b) bağlantı veren tarafın ve ürün veya hizmetlerinin sponsorluğunu, onayını veya onayını yanlış bir şekilde ima etmez; ve (c) bağlantı veren tarafın sitesi bağlamına uyması.

Yukarıdaki 2. paragrafta listelenen kuruluşlardan biriyseniz ve uygulamamize bağlantı vermekle ilgileniyorsanız, Welpie'ye bir e-posta göndererek bizi bilgilendirmelisiniz. Lütfen adınızı, kuruluşunuzun adını, iletişim bilgilerinizi ve sitenizin URL'sini, uygulamamize bağlantı vermeyi düşündüğünüz herhangi bir URL'nin bir listesini ve sitemizde yer almak istediğiniz URL'lerin bir listesini ekleyin. bağlantı. Yanıt için 2-3 hafta bekleyin.

Onaylı kuruluşlar uygulamamize aşağıdaki şekilde hiper bağlantı verebilir:

Kurumsal ismimizi kullanarak; veya
Bağlantılı olan tek tip kaynak bulucu kullanılarak; veya
uygulamamizin bağlantılı olduğu diğer herhangi bir açıklamanın kullanılması, bağlantı veren tarafın sitesindeki içeriğin bağlamı ve formatı içinde mantıklıdır.
Bir ticari marka lisans sözleşmesi olmadan bağlantı kurmak için Welpie'nin logosunun veya diğer sanat eserlerinin kullanılmasına izin verilmeyecektir.

iFrame'ler
Önceden onay ve yazılı izin olmaksızın, Web Sayfalarımızın çevresinde, uygulamamizin görsel sunumunu veya görünümünü herhangi bir şekilde değiştiren çerçeveler oluşturamazsınız.

İçerik Sorumluluğu
uygulamanizde görünen herhangi bir içerikten sorumlu tutulamayız. uygulamanizde ortaya çıkan tüm iddialara karşı bizi korumayı ve savunmayı kabul ediyorsunuz. Herhangi bir uygulamasinde, iftira niteliğinde, müstehcen veya suçlu olarak yorumlanabilecek veya herhangi bir üçüncü taraf hakkını ihlal eden, başka bir şekilde ihlal eden veya ihlal veya diğer ihlalleri savunan hiçbir bağlantı bulunmamalıdır.

Gizliliğiniz
Lütfen Gizlilik Politikasını okuyun

Hakların Saklanması
uygulamamize olan tüm bağlantıları veya belirli bir bağlantıyı kaldırmanızı talep etme hakkımızı saklı tutarız. Talep üzerine uygulamamize olan tüm bağlantıları derhal kaldırmayı onaylıyorsunuz. Ayrıca, bu hüküm ve koşulları ve bağlantı politikasını herhangi bir zamanda değiştirme hakkını saklı tutarız. uygulamamize sürekli olarak bağlanarak, bu bağlantı şart ve koşullarına bağlı kalmayı ve bunlara uymayı kabul edersiniz.

uygulamamizden bağlantıların kaldırılması
uygulamamizde herhangi bir nedenle saldırgan bir bağlantı bulursanız, istediğiniz zaman bizimle iletişime geçebilir ve bizi bilgilendirebilirsiniz. Bağlantıları kaldırma isteklerini dikkate alacağız, ancak size doğrudan yanıt vermekle yükümlü değiliz.

Bu uygulamasindeki bilgilerin doğruluğunu garanti etmiyoruz, eksiksizliğini veya doğruluğunu garanti etmiyoruz; ne de uygulamasinin kullanılabilir kalmasını veya uygulamasindeki materyalin güncel tutulmasını sağlamayı taahhüt etmiyoruz.

sorumluluk reddi
Yürürlükteki yasaların izin verdiği azami ölçüde, uygulamamize ve bu uygulamasinin kullanımına ilişkin tüm beyanları, garantileri ve koşulları hariç tutuyoruz. Bu sorumluluk reddi beyanındaki hiçbir şey:

ölüm veya kişisel yaralanma için bizim veya sizin sorumluluğunuzu sınırlamak veya hariç tutmak;
dolandırıcılık veya hileli yanlış beyan için bizim veya sizin sorumluluğunuzu sınırlamak veya hariç tutmak;
bizim veya sizin yükümlülüklerinizden herhangi birini geçerli yasaların izin vermediği şekilde sınırlamak; veya
yürürlükteki yasalar kapsamında hariç tutulmayan herhangi bir yükümlülüğümüzü veya sizin yükümlülüklerinizi hariç tutun.
Bu Bölümde ve bu sorumluluk reddinin başka yerlerinde belirtilen sorumluluk sınırlamaları ve yasakları: (a) önceki paragrafa tabidir; ve (b) sözleşmeden, haksız fiilden ve kanuni görevin ihlalinden doğan yükümlülükler de dahil olmak üzere, sorumluluk reddinden doğan tüm yükümlülükleri yönetir.

uygulamasi ve uygulamasindeki bilgi ve hizmetler ücretsiz olarak sağlandığı sürece, herhangi bir kayıp veya hasardan sorumlu olmayacağız.

Mağaza Alım ve Satım
Tüm parasal alım ve satımlar deneme versiyonu olduğu için,tamamıyla işletme ve müşteri sorumluluğundadır.Komisyon almadığımız için HİÇBİR SORUMLULUK ÜSTLENMİYORUZ.
''';

String allst =languagest == 'EN' ? 'All': "Tümü";
String notificationst =languagest == 'EN' ? 'Notification': "Bildirim";
String orderst =languagest == 'EN' ? 'Order': "Sipariş";
String requestst =languagest == 'EN' ? 'Request': "İstek";
String deliveryfeest =languagest == 'EN' ? 'Delivery Fee': "Teslim Ücreti";
String etatimest =languagest == 'EN' ? 'ETA': "Tahmini Ulaşım Süresi";
String isdeliveredst =languagest == 'EN' ? 'Is Product Delivered': "Teslim Edilecek mi";
String allowstocksst =languagest == 'EN' ? 'Allow Stocks': "Stoğa İzin Ver";
List<String> notificationchoices2 = <String>[allst,notificationst,orderst,requestst];
List<String> pricerangechoices = <String>[premiumst,highst,standardst,lowst,unspecifiedst];
List<String> cities = <String>[city1,city2,city3,city4,city5,city6,city7,city8,city9];
//postpricest//groupsearchst



String userservices2st =languagest == 'EN' ? 'How user services work?': 'Kullanıcı servisleri nasıl işler?';
String userservices3st =languagest == 'EN' ? 'How user service notifications work?': 'Kullanıcı servis bildirimleri nasıl işler?';
String howsubusersworkst=languagest == 'EN' ? 'How subusers work?': 'Altkullanıcılar nasıl işler?';
String whatissubusersst=languagest == 'EN' ? 'What is subuser?': 'Altkullanıcı nedir?';
String howsearchworksst=languagest == 'EN' ? 'How search engine works?': 'Arama motoru nasıl işler?';
String creatingcalendarforfullcalendarst=languagest == 'EN' ? 'Creating system for full calendar': 'Tam takvim için sistemi oluşturma';
String notificationsforrequestsonlyst=languagest == 'EN' ? 'Notifications for requests only calendar': 'Sadece istekler üzerine bir takvim için bildirimler';
String requestappointmentforfullcalendarst=languagest == 'EN' ? 'Creating appointment for full calendar': 'Tam takvim için randevu istemek';
String requestappointmentforrequestsonlyst=languagest == 'EN' ? 'Creating appointment for requests only calendar': 'Sadece istek takvimi için randevu yaratmak';
String tagusersst=languagest == 'EN' ? 'How to tag users?': 'Kullanıcılar nasıl taglanır?';
String eventsonlycalendarst=languagest == 'EN' ? 'How events only calendar works?': 'Sadece etkinlik içeren takvim nasıl işler?';
String iconsst=languagest == 'EN' ? 'What are icons at create screens?': 'Öğe yaratma ekranındaki ikonlar nedir?';
String categoriesst=languagest == 'EN' ? 'What are user product/service categories?': 'Kullanıcı ürün/servis kategorisi nedir?';
String taguserssst=languagest == 'EN' ? 'Tag users': 'Kullanıcıları tagla';

String whatisuserproductst=languagest == 'EN' ? 'What is user product?' : 'Kullanıcı ürünleri nedir?';
String whatisuserservicest =languagest == 'EN' ? 'What is user service?' : 'Kullanıcı servisleri nedir?';
String whatiscalendarst =languagest == 'EN' ? 'What is calendar?' : 'Takvim nedir?';


String whatisuserproductexpst=languagest == 'EN' ? 'User Products allow you to show your inventory to your customers.For example you can post your 3 laptop types under Laptop categories' : 'Kullanıcı ürünleri sizin envanterinizi müşterilerinize göstermenizi sağlar.Örneğin 3 çeşit laptopunuzu laptop kategorisi altında yayınlayabilirsiniz.';
String whatisuserserviceexpst =languagest == 'EN' ? 'User Services allow you to create forms and allow you to collect some information from your customers (registration forms,etc..)'  : 'Kullanıcı servisleri formlar yaratmanızı ve müşterilerinizden bilgi toplamanızı sağlar.';
String whatiscalendarexpst =languagest == 'EN' ? '''
Calendar helps you to show events and create appointments.
-Full calendar allows your customers to choose from existing date and time 
-Requests only allows your customers to choose existing items while you decide date and time 
-Events only allows your customers to view existing events in certain dates
'''  :
'''
Takvim size etkinlikleri göstermenizi ve randevu almanızı sağlar. 
-Tam Takvim özelliği müşterilerinizin bulunan ürünü,saati ve günü seçmesini sağlar. 
-Sadece İstek özelliği müşterilerinizin bulunan ürünü seçmesini,saati ve günü sizin belirlemenizi sağlar. 
-Sadece Etkinlik özelliği belirli tarihlerdeki eklediğiniz etkinlikleri müşterilerinizin görmesini sağlar.
''';

