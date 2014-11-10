/**Открытое api системы VGB version '1.0-alpha.97' */
namespace java com.deviq.vgb.thrift.service.cardproduct

/** строковое определение идентификатора */
typedef string ID
/** Дата без времени в формате "2013-12-31" */
typedef string vgbDate
/** Дата c временем в формате "2013-12-31 05:25:59" */
typedef string vgbFullDate
/** Значение токена сессии (идентификатора сессии), которое является набором байт и для удобства использования используется в виде строки в кодировке base64 */
typedef string AuthTokenBase64
/** числовое значение, используется для определения количества записей */
typedef i32 count

/** Версия продукта VGB */
const string CURRENT_VERSION = '1.0-alpha.97';

/** Непредвиденная ошибка сервера */
exception ServerException {
  /** Код ошибки */
  1: string errorMessageKey;
  /** Сообщение */
  2: string errorMessage
}

/** Ошибки, возникшие при проверке данных */
exception PreconditionException {
  /** Код ошибки */
  1: string errorMessageKey;
  /** Сообщение */
  2: string errorMessage
  /** Уникальный код сообщения */
  3: string i18nCode;
}

/** Ошибки, возникшие при проверке сессии */
exception WrongSessionException {
  /** Код ошибки */
  1: string errorMessageKey;
  /** Сообщение */
  2: string errorMessage
}

/** Нет прав на выполнение действия */
exception AccessDenyException {
  /** Код ошибки */
  1: string errorMessageKey;
  /** Сообщение */
  2: string errorMessage
}

struct Picture {
  1: binary img;
}

/** Пол пользователя */
enum Gender{
    /** неопределено */
    UNDEFINED,
    /** мужчина */
    MALE,
    /** женщина */
    FEMALE
}

/** Основная информация о Клиенте */
struct ClientInfo {
  /** идентификатор */
  1:ID id;
  /** Логин */
  2: string login;
  /** Имя */
  3: string firstName;
  /** Фамилия */
  4: string lastName;
  /** Отчество */
  5: string middleName;
  /** Дата рождения */
  6: vgbDate birthDay;
  /** Дата регистрации в системе */
  7: vgbDate registrationDate;
  /** Атрибуты для хранения дополнительной информации */
  8: map<string,string> attrs;
  /** пол */
  9: Gender gender;
}

/** Роли пользователей системы(под пользователями подразумеваются НЕ КЛИЕНТЫ, а работники магазинов и сотрудники VGB) */
enum Role {
  /** Администратор: может создавать профиля сотрудников и назначать им права */
  ADMIN,
  /** Мерчандайзер: управляет торговыми точками и акциями */
  CONTENT,
  /** Продавец: может создавать и принимать счета */
  SELLER,
  /** Бухгалтер: может просматривать оплаты в пользу магазина и отделений */
  BOOKER,
  /** Бухгалтер: может просматривать оплаты в пользу отделений */
  BOOKER_ASSISTANT
}

/** Тип пользователя системы */
enum UserType{
  /** Клиент системы, может пользоваться бонусными программами */
  CLIENT,
  /** Сотрудник магазина */
  MERCHANT_USER,
  /** Сотрудник VGB */
  INTERNAL,
  /** Сервер для начисления бонусов */
  ETL_SERVER
}



/** Тип обьктов для тегов */
enum TagObject {
    /** Магазины */
    MERCHANT,
    /** Акции */
    ACTION,
    /** Сертификаты */
    CERTIFICATE
}

/** Wish type */
enum WishType {
    /** Merchant action */
    ACTION,
    /**  Certificate  */
    CERTIFICATE
}
/**  structure for wish */
struct Wish {
  /** ID of wish */
  1: ID id;
  /** Id of merchant action, Certificate, etc  */
  2: ID wishId;
  /** Type of wish */
  3: WishType wishType;
}


/** Сотрудник */
struct User {
  /** Основная информация */
  1: ClientInfo clientInfo;
  /** Тип сотрудника */
  2: UserType type;
  /** Идентификатор магазина */
  3: ID merchantId;
  /** Идентификатор системы зачисления */
  4: ID supplierId;
  /** "Супер пользователь". Один в разрезе одной сети магазинов, может создавать/удалять пользователей.
   * "Суперпользователя" не могут удалить администраторы магазина.
   * Создается при добавлении нового магазина в систему.
   **/
  5: bool superUser;
  /** список доступных полей */
  6: set<Role> roles;
  /** Дата удаления */
  7: vgbDate deleteDate;
}

/** Адрес. К сотруднику и клиенту может быть присоединено любое количество адресов */
struct Address {
  /** Идентификатор */
  1: ID id;
  /** Почтовый индекс*/
  2: string zipCode;
  /** Страна */
  3: string country;
  /** Область */
  4: string state;
  /** Город */
  5: string city;
  /** Улица */
  6: string street;
  /** Дом */
  7: string house;
  /** Квартира */
  8: string apartment;
  /** Отметка, указывающая что адрес основной. Только один адрес может быть основным */
  9: bool main;
}

/** Тип связи */
enum CommunicationType {
  /** Электронная почта */
  EMAIL,
  /** Телефон */
  PHOHE
}

/** Средство связи. К сотруднику и клиенту может быть присоединено любое количество средств связи */
struct Communication {
  /** Идентификатор */
  1: ID id;
  /** Тип связи */
  2: CommunicationType type;
  /** Значение */
  3: string value;
  /** Отметка о том подтверждено ли средство связи */
  4: bool confirmed;
  /** Отметка, указывающая что средство связи основное. Только одно подтвержденное средство связи может быть основным */
  5: bool main;
}

/** Сессия для коммуникации с сервером */
struct AuthSession {
  /** Идентификатор */
  1: AuthTokenBase64 token;
  /** Дата окончания */
  2: vgbFullDate expireDate;
  /** Дата создания */
  3: vgbFullDate createDate;
  /** Дата последнего изменения */
  4: vgbFullDate updateDate;
  /** Основная информация о пользователе */
  5: ClientInfo clientInfo;
}

/** Бонусная программа, зарегистрированная с системе */
struct BonusProgram {
  /** Идентификатор */
  1: ID id;
  /** Название */
  2: string name;
  /** Дата регистрации */
  3: vgbDate createDate;
  /** Дата до которой программа действует */
  4: vgbDate activeToDate;
  /** Дата удаления */
  5: vgbDate deleteDate;
  /** Атрибуты для хранения дополнительной информации */
  6: map<string,string> attrs;
  /** псевдоним бонусной программы */
  7: string bonusProgramAlias;
}

/** Расширенная бонусная программа, содержит дополнительные поля, доступные только для сотрудников VGB */
struct ExtendedBonusProgram {
  /** Идентификатор */
  1: BonusProgram bonusProgram;
  /** Маска, для скрытия части номера карты(регулярное выражение) */
  2: string hideMask;
  /** Маска для проверки номеров карт(регулярное выражение) */
  3: string eqMask;
}

/** Счет клиента, один для бонусной программы*/
struct Account {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор программы */
  2: ID programId;
  /** Идентификатор сумма*/
  3: i64 amount;
}

/** Карта клиента, на которую начисляются бонусы */
struct Card {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор программы */
  2: ID programId;
  /** Маскированный номер карты, маска берется из бонусной программы */
  3: string number;
  /** Дата удаления */
  4: vgbFullDate registrateDate;
  /** Дата удаления */
  5: vgbFullDate deleteDate;
  /** Атрибуты для хранения дополнительной информации */
  6: map<string,string> attrs;
  /** Описание карты */
  7: string description;
}

/** Статус ордеров пополнения */
enum CardOrderStatus {
  /** Создан */
  CREATED,
  /** Обработан */
  PROCESSED,
  /** Отложен */
  DELAYED,
  /** Отменен */
  CANCELED
}

/** Тип начисления бонусов */
enum CardOrderType{
  /** оборот по карте */
  CARD_TURNOVER,
  /** приветственный */
  GREETING,
  /** активность в соцсетях */
  SOCIAL_NETWORKS,
  /** депозит */
  DEPOSIT
}

/** Ордер на пополнение бонусной карты. Фактически пополняется бонусный счет, но начисление бонусов происходит на карту*/
struct CardOrder {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор карты*/
  2: ID cardId;
  /** хеш от номера карты */
  3: string cardHash;
  /** Количество */
  4: i64 amount;
  /** Тип начисления */
  5: CardOrderType type;
  /** Описание */
  6: string orderDescription;
  /** Дата создания */
  7: vgbFullDate createDate;
  /** Дата зачисления средств */
  8: vgbFullDate processDate;
  /** Статус */
  9: CardOrderStatus status;
  /** Идентификатор внешней системы */
  10: ID externalId;
}

/** Ордер на пополнение счета. Фактически пополняется бонусный счет */
struct ClientOrder {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор карты*/
  2: ID clientId;
  /** Количество  */
  3: i64 amount;
  /** Тип начисления */
  4: CardOrderType type;
  /** Описание */
  5: string orderDescription;
  /** Дата создания */
  6: vgbFullDate createDate;
  /** Дата зачисления средств */
  7: vgbFullDate processDate;
  /** Статус */
  8: CardOrderStatus status;
  /** Идентификатор внешней системы */
  9: ID externalId;
}

/** Используется для пополнения бонусов */
struct Adjunction
{
  1:ID id;
  /** источник */
  2: ID supplierId;
  /** описание */
  3: string adjunctionDescription;
  /** имя файла */
  4: string fileName;
  /** идентификатор бонусной программы */
  5: ID bonusProgramId;
  /** список ордеров на пополнение */
  6: list<CardOrder> orders;
  /** список ордеров на пополнение */
  7: list<ClientOrder> clientOrders;
}

/** Статус оплат */
enum PaymentStatus{
  /** Создан */
  CREATE,
  /** Запрос на подтверждение */
  REQUEST_CODE,
  /** Отменен */
  CANCELLED,
  /** Оплачен */
  PAYED
}

/** Оплата. Количество бонусов, списываемых со счета */
struct Payment {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор бонусной программы */
  2: ID bonusProgramId;
  /** Идентификатор бонусного счета */
  3: ID accountId;
  /** Идентификатор магазина */
  4: ID merchantId;
  /** Идентификатор точки продажи */
  5: ID merchantPointId;
  /** Идентификатор курса обмена бонусов */
  6: ID exchangeRateId;
  /** Списываемое количество бонусов */
  7: i64 amount;
  /** Курс обмена */
  8: double exchangeValue;
  /** Сумма, которая будет зачислена в магазин */
  9: i64 payedValue;
  /** Статус*/
  10: PaymentStatus status;
  /** Идентификатор сертификата */
  11: ID clientCertificateId;
  /** Дата создания */
  12: vgbFullDate createDate;
  /** Дата оплаты */
  13: vgbFullDate payedDate;
}

/** Расширенная оплата. Содержит дополнительную информацию */
struct MerchantPayment {
  /** Оплата */
  1: Payment payment;
  /** Дата бухгалтерского учета */
  2: vgbFullDate accountingDate;
  /** Описание бухгалтерского учета */
  3: string accountingDescription;
}

/** Магазин */
struct Merchant {
  /** Идентификатор */
  1: ID id;
  /** Название */
  2: string name;
  /** Дата регистрации в системе */
  3: vgbDate createDate;
  /** Дата удаления */
  4: vgbDate deleteDate;
  /** Аттрибуты, для хранения дополнительной информации */
  5: map<string,string> attrs;
  /** Ссылка на сайт */
  6: string urlSite;
  /** Средство связи. */
  7: string communications;
}

/** Расширенная информация о магазине, содержит дополнительные поля, доступные только для сотрудников VGB */
struct ExtendedMerchant {
  /** Основная информация о магазине */
  1: Merchant merchant;
  /** URL на сервис сертификатов */
  2: string urlCertificateService;
}

/** Географические данные */
struct GeoData {
  /** Широта */
  1: string latitude;
  /** Долгота */
  2: string longitude;
}

/** Торговая точка */
struct MerchantPoint {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор магазина */
  2: ID merchantId;
  /** Описание */
  3: string pointDescription;
  /** Рабочее время */
  4: string workingHours;
  /** Средство связи. */
  5: string communications;
  /** Географические данные */
  6: GeoData geoData;
  /** Аттрибуты, для хранения дополнительной информации */
  7: map<string, string> attrs;
  /** Дата удаления */
  8: vgbFullDate deleteDate;
}

/** Акция, проходящая в торговой точке или с сети магазинов */
struct MerchantAction {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор магазина */
  2: ID merchantId;
  /** Идентификатор торговой точки */
  3: ID merchantPointId;
  /** Описание */
  4: string actionDescription;
  /** Дата начала */
  5: vgbDate dateFrom;
  /** Дата окончания */
  6: vgbDate dateTo;
  /** Аттрибуты, для хранения дополнительной информации */
  7: map<string, string> attrs
  /** Дата удаления */
  8: vgbFullDate deleteDate;
  /** Идентификатор внутри внешней системы */
  9: ID externalId;
  /** Ссылка на изображение во внешней  системе*/
  10: string externalPicture;
  /** Ссылка на акцию во внешней системе */
  11: string externalLink;
  /** Название */
  12: string actionName;
}

/** Курс обмена бонусов */
struct ExchangeRate {
  /** Идентификатор */
  1: ID id;
  /** Идентификатор бонусной программы */
  2: ID programId;
  /** Идентификатор магазина */
  3: ID merchantId;
  /** Дата начала */
  4: vgbDate dateFrom;
  /** Дата окончания */
  5: vgbDate dateTo;
  /** значение */
  6: double value;
}

/** Разделение сертификатов по спобобу использования */
enum CertificateUseType
{
  /** В магазине или торговой точке */
  THROUGH_MERCHANT,
  /** В личном кабинете */
  THROUGH_CABINET
}

/** Количественное разделение сертификатов */
enum CertificateQuantitativeType
{
  /** Неограниченное кол-во */
  INFINITE,
  /** Ограниченное кол-во */
  LIMITED
}

/** Разделение сертификатов по способу оплаты */
enum CertificatePaymentType
{
  /** При покупке */
  ON_BUY,
  /** При использовании */
  ON_USE
}

/** Функциональное разделение сертификатов */
enum CertificateFunction
{
  /** Скидочные */
  DISCOUNT,
  /** Обычные */
  USUAL
}

/** вид генерируемого (отображаемого) на фронте кода */
enum FrontCodeType
{
  NUMBERS,
  QR,
  EAN13,
  EAN128,
  CODABAR,
  EAN13_EXTENDED
}

/** Сертификат. */
struct Certificate {
  /** Идентификатор */
  1: ID id;
  /** Внешний идентификатор */
  2: ID externalId;
  /** Идентификатор магазина */
  3: ID merchantId;
  /** Идентификатор бонусной программы */
  4: ID bonusProgramId;
  /** Название */
  5: string name;
  /** Описание */
  6: string certificateDescription;
  /** Стоимость в бонусах */
  7: i64 cost;
  /** Покупательная способность в бонусах*/
  8: i64 spendingCost;
  /** Покупательная способность в "специальных единицах"*/
  9: i64 spendingCostInUnits;
  /** Значение "специальных единиц" */
  10: string unit;
  /** Дата создания */
  11: vgbDate createDate;
  /** Дата удаления */
  12: vgbDate deleteDate;
  /** Дата начала */
  13: vgbDate startDate;
  /** Дата окончания */
  14: vgbDate endDate;
  /** Функциональное разделение */
  15: CertificateFunction funct;
  /** Тип сертификата(бесконечный, ограниченный) */
  16: CertificateQuantitativeType type;
  /** Разделение сертификатов по способу оплаты */
  17: CertificatePaymentType paymentType;
  /** Количество(для ограниченого кол-ва) */
  18: i32 quantity;
  /** Аттрибуты, для хранения дополнительной информации */
  19: map<string, string> attrs;
  /** Ссылка на файл с изображением */
  20: string urlImg;
  /** Тип использования */
  21: CertificateUseType useType;
  /** Обязательные аттрибуты */
  22: list<string> requiredAttrs;
  /** (сэт), по которому будет определяться вид генерируемого (отображаемого) на фронте кода. */
  23: set<FrontCodeType> frontCodes;
}

/** Тип контента кода */
enum ClientCertificateCodeType
{
  NONE,
  PDF
}

/** Купленный сертификат */
struct ClientCertificate
{
  /** Основная информация */
  1: Certificate certificate;
  /** Код сертификата */
  2: string code;
  /** Тип контента кода*/
  3: ClientCertificateCodeType codeType;
  /** Дата покупки */
  4: vgbFullDate boughtDate;
  /** Дата использования */
  5: vgbFullDate useDate;
  /** URL на документ */
  6: string linkUrl;
}



/** Специальный код, по которому используется сертификат */
struct ClientCertificateCode
{
  1: Picture picture;
  2: string type;
}

/** Приоритет траты бонусов */
enum SupplierPriority
{
  /** Низкий */
  LOW,
  /** Нормальный */
  NORMAL,
  /** Высокий */
  HIGH
}

/** Организация, которая может начислять бонусы */
struct Supplier {
  /** Идентификатор */
  1: ID id;
  /** Дата регистрации */
  2: vgbDate createDate;
  /** Название */
  3: string name;
  /** Описание */
  4: string supplierDescription;
  /** Приоритет */
  5: SupplierPriority priority;
  /** Флаг, указывающий активен поставщик или нет */
  6: bool isActive;
  /** Дата удаления */
  7: vgbDate deleteDate;
  /** Аттрибуты, для хранения дополнительной информации */
  8:map<string, string> attrs;
}

enum FilterCondition {
  EQUAL,
  NOT_EQUAL,
  CONTAIN,
  NOT_CONTAIN,
  LESS,
  LESS_OR_EQUAL,
  MORE,
  MORE_OR_EQUAL
}

struct FilterItem {
  1: string field;
  2: FilterCondition condition;
  3: string value;
}

/** Фильтр, для улучшения пользовательского интерфейса при получении списков */
struct Filter {
  /** Начальная позиция */
  1: i16 position;
  /** Количество */
  2: i16 count;
  /** Условия фильтрации */
  3: list<FilterItem> items;
  /** Дополнительные параметры для фильтрования */
  4: map<string, string> filterKey;
}

/** Тег */
struct Tag {
  /** Идентификатор */
  1: ID id;
  /** Название */
  2: string name;
  /** Идентификатор родетельского тега */
  3: ID parentID;
}

/** Тип правила использования бонусов */
enum DiscountRuleType
{
  /** Равно */
  EQUAL,
  /** Кратно */
  MULTIPLE,
  /** Остальные случаи */
  OTHER,
  /** Случаи когда скидка не начисляется, нужно для фронта */
  INCALCULABLE
}

/** Тип неначисляемого правила, применяется на фронте */
enum NotCalculatedDiscountRuleType
{
  /** Подарок */
  GIFT,
  /** Бесплатная доставка */
  FREE_SHIPPING,
  /** Возврат денег */
  REFUND,
  /** скидка процент */
  SALE_PERCENT,
  /** скидка сумма */
  SALE_AMOUNT,
  /** выгодная цена */
  BEST_PRICE
}

/** Правило использования бонусов */
struct DiscountRule
{
  /** Идентификатор правила */
  1: ID id;
  /** Идентификатор точки продажи */
  2: ID merchantPointId;
  /** Идентификатор акции */
  3: ID merchantActionId;
  /** Тип */
  4: DiscountRuleType type;
  /** Значение в соответствии с типом(для типа OTHER будет проигнорировано) */
  5: i32 count;
  /** Максимальная скидка */
  6: i32 maxDiscount;
  /** Шаг скидки */
  7: i32 step;
  8: NotCalculatedDiscountRuleType notCalculatedDiscountRuleType;
}

/** Структура, используемая для просчета скидки */
struct Discount
{
  /** Начальная сумма */
  1: i64 initialAmount;
  /** Скидка в процентах */
  2: i32 discountInPercentage;
  /** Скидка в бонусах */
  3: i64 discountInBonuses;
  /** Скидка в начальной валюте */
  4: i64 discount;
  /** Идентификатор точки(из запроса) */
  5:ID merchantPointId;
  /** Идентификатор акции(из запроса) */
  6:ID merchantActionId;
}

/** Фотмат файла */
enum ETLFileFormat
{
  XML
}

/** Обработчик файлов (служба начисления бонусов) */
struct ETL
{
  /** Идентификатор */
  1: ID id;
  /** Папка для исходных файлов */
  2: string folderIn;
  /** Папка для логирования обработанных файлов */
  3: string folderCopy;
  /** Исходящая папка */
  4: string folderOut;
  /** Формат входящего файла */
  5: ETLFileFormat formatIn;
  /** Формат исходящего файла */
  6: ETLFileFormat formatOut;
  /** Флаг, позволяющий временно отключить обработчик */
  7: bool active;
  /** Идентификатор клиента */
  8: ID clientId;
  /** Идентификатор клиента */
  9: ID supplierId;
  /** Дата создания */
  10: vgbDate createDate;
}

/** Уникальный код */
struct UniqueCode
{
    /** Уникальный код */
    1: string code;
    /** Дата до которой код дейсвительный */
    2: vgbDate validTo;
}

/** Сервис аутентификации */
service AuthService {
  /** Запрос на регистрация клиента. При этом на указанный email или телефон будет выслан код для завершения регистрации */
  void requestClientRegistration(1: string login; 2: string password, 3:string confirmation, 4:Communication communication) throws (1:PreconditionException validError, 2:ServerException error);
  /** Окончание регистрации */
  AuthSession finishClientRegistration(1:string login, 2:string verifyCode) throws (1:PreconditionException validError, 2:ServerException error);
  /** Авторизация в системе */
  AuthSession authenticate(1: string login; 2: string password) throws (1:PreconditionException validError, 2:ServerException error);
  /** Обновление сессии */
  AuthSession refreshAuthSession(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:ServerException error);
  /** Смена пароля */
  void changePassword(1:AuthTokenBase64 token, 2:string oldPassword, 3: string password, 4:string confirmation) throws (1:WrongSessionException sessionError, 2:PreconditionException validError, 3:ServerException error);
  /** Запрос на сброс пароля */
  void requestResetPassword(1: string login; 2:Communication communication) throws (1:PreconditionException validError, 2:ServerException error);
  /** Подтверждения сброса пароля, будет сгенерирован новый пароль */
  AuthSession finishResetPassword(1: string login, 2: string confirmationCode, 3: string password, 4:string confirmation) throws (1:PreconditionException validError, 2:ServerException error);
  /** Выход из системы */
  void logout(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:ServerException error);

  /** Запрос на повторную высылку кода для завершения регистрации */
  void requestConfirmationCodeForRegistration(1: string login) throws (1:PreconditionException validError, 2:ServerException error);
  /** Окончание регистрации (расширеный)*/
  AuthSession finishClientRegistrationEx(1:string login, 2:string verifyCode, 3:ClientInfo clientInfo, 4:Communication additionalCommunication, 5:ID cardProgramId, 6:string cardNumber) throws (1:PreconditionException validError, 2:ServerException error);
}

/** Сервис профилей */
service ClientProfileService {
  /** Получение информации о пользователе */
  ClientInfo getClientInfo(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:ServerException error);
  /** Обновление информации о пользователе */
  ClientInfo updateClientInfo(1:AuthTokenBase64 token, 2:ClientInfo clientInfo) throws (1:WrongSessionException sessionError, 2:PreconditionException validError, 3:ServerException error);
  /** Получение аватара */
  Picture getAvatar(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:ServerException error);
  /** Изменение аватара */
  Picture createOrUpdateAvatar(1:AuthTokenBase64 token, 2:Picture avatar) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение аватара */
  void deleteAvatar(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:ServerException error);

  /** Создание или изменение адреса (если идентификатор  заполнен, произойдет изменение) */
  Address createOrUpdateAddress(1:AuthTokenBase64 token, 2:Address address) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Удаление адреса по идентификатору */
  void removeAddressById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Отметка адреса как основного */
  void markAddressAsMainById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение адреса по идентификатору */
  Address getAddressById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение количества адресов */
  count getCountAllAddresses(1:AuthTokenBase64 token, 2:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение списка адресов */
  list<Address> getAllAddresses(1:AuthTokenBase64 token, 2:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);

  /** Создание или изменение средства связи (если идентификатор  заполнен, произойдет изменение) */
  Communication createOrUpdateCommunication(1:AuthTokenBase64 token, 2:Communication communication) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Запрос на подтверждение средства связи, при этом будет выслан код для подтверждения */
  void requestConfirmCommunication(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Подтверждение средства связи */
  void confirmCommunication(1:AuthTokenBase64 token, 2:ID id, 3:string verifyCode) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Удаление средства связи по идентификатору */
  void removeCommunicationById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Отметка средства связи как основного */
  void markCommunicationAsMainById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение средства связи по идентификатору */
  Communication getCommunicationById(1:AuthTokenBase64 token, 2:ID id) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение количества средств связи */
  count getCountAllCommunications(1:AuthTokenBase64 token, 2:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение списка средств связи */
  list<Communication> getAllCommunications(1:AuthTokenBase64 token, 2:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** получение основной коммуникации */
  Communication getMainCommunication(1:AuthTokenBase64 token) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** получение списка уникальных кодов */
  list<UniqueCode> getUniqueCodes(1:AuthTokenBase64 token) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** получение количества уникальных кодов */
  count getCountUniqueCodes(1:AuthTokenBase64 token) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** сгенирировать новый уникальный код */
  string generateUniqueCode(1:AuthTokenBase64 token) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
}

/** Финансовый сервис */
service ClientFinancialService {
  /** Получение количества счетов */
  count getCountAccounts(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка счетов */
  list<Account> getAccounts(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение счета по идентификатору */
  Account getAccountById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение счета по бонусной программе */
  Account getAccountByBonusProgram(1:AuthTokenBase64 token, 2:ID programId)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение счета по карте */
  Account getAccountByCard(1:AuthTokenBase64 token, 2:ID cardId)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение количества карт (не удаленных) */
  count getCountCards(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка карт (не удаленных) */
  list<Card> getCards(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества карт (всех) */
  count getCountAllCards(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка карт (всех) */
  list<Card> getAllCards(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение карты по идентификатору */
  Card getCardById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества карт по счету */
  count getCountCardsByAccount(1:AuthTokenBase64 token, 2:ID accountId, 3:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка карт по счету */
  list<Card> getCardsByAccount(1:AuthTokenBase64 token, 2:ID accountId, 3:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Добавление карты */
  Card addCard(1:AuthTokenBase64 token, 2:ID programId, 3:string number, 4:map<string,string> attrs)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление карты по идентификатору */
  void removeCard(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Изменение карты */
  Card updateCard(1:AuthTokenBase64 token, 2:Card card) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);


  /** Получение ордера на пополнение по идентификатору */
  CardOrder getCardOrderById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества ордеров на пополнение по карте в разрезе дат */
  count getCountCardOrdersWithFromToDate(1:AuthTokenBase64 token, 2:ID cardId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка ордеров на пополнение по карте в разрезе дат */
  list<CardOrder> getCardOrdersWithFromToDate(1:AuthTokenBase64 token, 2:ID cardId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества ордеров на пополнение по карте за последние "lastDays" дней */
  count getCountCardOrdersWithLastDays(1:AuthTokenBase64 token, 2:ID cardId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка ордеров на пополнение по карте за последние "lastDays" дней */
  list<CardOrder> getCardOrdersWithLastDays(1:AuthTokenBase64 token, 2:ID cardId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества ордеров на пополнение по счету за последние "lastDays" дней */
  count getCountAllCardOrdersWithFromToDate(1:AuthTokenBase64 token, 2:ID accountId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка ордеров на пополнение по счету за последние "lastDays" дней */
  list<CardOrder> getAllCardOrdersWithFromToDate(1:AuthTokenBase64 token, 2:ID accountId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества ордеров на пополнение по счету за последние "lastDays" дней */
  count getCountAllCardOrdersWithLastDays(1:AuthTokenBase64 token, 2:ID accountId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка ордеров на пополнение по счету за последние "lastDays" дней */
  list<CardOrder> getAllCardOrdersWithLastDays(1:AuthTokenBase64 token, 2:ID accountId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);


  /** Получение количества сертификатов, идентификатор магазина - необязательный */
  count getCountMyCertificates(1:AuthTokenBase64 token, 2:ID merchantId, 3:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка сертификатов, идентификатор магазина - необязательный */
  list<ClientCertificate> getMyCertificates(1:AuthTokenBase64 token, 2:ID merchantId, 3:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение сертификата по идентификатору */
  ClientCertificate getMyCertificateById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества купленных неиспользованных */
  count getCountUnusedCertificates(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка купленных неиспользованных */
  list<ClientCertificate> getUnusedCertificates(1:AuthTokenBase64 token, 2:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение кода для использования сертификата */
  ClientCertificateCode getUnusedCertificateCode(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Использовать купленный сертификат */
  ClientCertificate useMyCertificateById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение количества оплат в разрезе дат */
  count getCountPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID accountId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка оплат в разрезе дат */
  list<Payment> getPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID accountId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества оплат "lastDays" дней */
  count getCountPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID accountId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка оплат "lastDays" дней */
  list<Payment> getPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID accountId, 3:i16 lastDays, 4:Filter filter)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение оплаты по идентификатору */
  Payment getPaymentById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Обначилить обезличенную оплату.*/
  Payment confirmDepersonalizedPayment(1:AuthTokenBase64 token, 2:ID paymentId)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Купить сертификат */
  Payment buyCertificate(1:AuthTokenBase64 token, 2:ID certificateId, 3: map<string, string> attributes) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Сгенерировать ссылку для перехода на внешнюю акцию извне */
  string generateExternalLink(1:AuthTokenBase64 token, 2:ID merchantActionId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/**Информационный сервис */
service ClientInformationalService {
  /** Получение текущей версии приложения */
  string getVersion();

  /** Получение количества бонусных программ */
  count getCountBonusPrograms(1: Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение списка бонусных программ */
  list<BonusProgram> getBonusPrograms(1: Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение количества поддерживаемых бонусных программ по магазину */
  count getCountSupportedBonusProgramsByMerchant(1:ID merchantId, 2:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение списка поддерживаемых бонусных программ по магазину */
  list<BonusProgram> getSupportedBonusProgramsByMerchant(1:ID merchantId, 2:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение бонусной программы по идентификатору */
  BonusProgram getBonusProgramById(1:ID id) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение бонусной программы по псевдониму */
  BonusProgram getBonusProgramByAlias(1:string programAlias) throws (1:PreconditionException validError, 2:ServerException error);

  /** Получение курса обмена для магазина по бонусной программе и дате */
  ExchangeRate getExchangeRate(1:ID merchantId, 2:ID programId, 3:vgbDate date) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение курса обмена по идентификатору */
  ExchangeRate getExchangeRateById(1:ID id) throws (1:PreconditionException validError, 2:ServerException error);

  /** Получение количества магазинов */
  count getCountMerchants(1:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение списка магазинов */
  list<Merchant> getMerchants(1:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение количества магазинов, работающих с бонусной программой */
  count getCountMerchantsByProgram(1:ID programId, 2:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение списка магазинов, работающих с бонусной программой */
  list<Merchant> getMerchantsByProgram(1:ID programId, 2:Filter filter) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение магазина по идентификатору */
  Merchant getMerchantById(1:ID id) throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение логотипа по магазину */
  Picture getMerchantLogoById(1:ID merchantId) throws (1:PreconditionException validError, 2:ServerException error);

  /** Получение количества торговых точек по магазину */
  count getCountMerchantPoints(1:ID merchantId, 2:Filter filter) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение списка торговых точек по магазину */
  list<MerchantPoint> getMerchantPoints(1:ID merchantId, 2:Filter filter) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение торговой точки по идентификатору */
  MerchantPoint getMerchantPointById(1:ID id) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение количества акции по магазину */
  count getCountAllRegisteredMerchantActions(1:ID merchantId, 2:list<ID> tagIds, 3:Filter filter) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение списка акции по магазину */
  list<MerchantAction> getAllRegisteredMerchantActions(1:ID merchantId, 2:list<ID> tagIds, 3:Filter filter) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение количества акции по торговой точке */
  count getCountMerchantActionsByMerchantPoint(1:ID merchantPointId, 2:Filter filter) throws (1: PreconditionException validError,  2:ServerException error);
  /** Получение списка акции по торговой точке */
  list<MerchantAction> getMerchantActionsByMerchantPoint(1:ID merchantPointId, 2:Filter filter) throws (1: PreconditionException validError,  2:ServerException error);
  /** Получение акции по идентификатору */
  MerchantAction getMerchantActionById(1:ID id) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение логотипа акции по идентификатору */
  Picture getMerchantActionPictureById(1:ID actionId) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:ServerException error);
  /** Получение количества правил использования бонусов */
  count getCountDiscountRulesForAction(1:ID merchantActionId, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:PreconditionException validError, 3:ServerException error);
  /** Получение правил использования бонусов */
  list<DiscountRule> getDiscountRulesForAction(1:ID merchantActionId, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:PreconditionException validError, 3:ServerException error);


  /** Получение количества сертификатов */
  count getCountAllRegisteredCertificates(1:ID merchantId, 2:list<ID> tagIds, 3:Filter filter)  throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение списка сертификатов */
  list<Certificate> getAllRegisteredCertificates(1:ID merchantId, 2:list<ID> tagIds, 3:Filter filter)  throws (1:PreconditionException validError, 2:ServerException error);
  /** Получение сертификата по идентификатору */
  Certificate getRegisteredCertificateById(1:ID id) throws (1: PreconditionException validError, 2:ServerException error);
  /** Получение логотипа сертификата по идентификатору */
  Picture getCertificatePictureById(1:ID id) throws (1: PreconditionException validError, 2:ServerException error);
}

/** Сервис управления магазином */
service MerchantAdminService {
  /** Создание или изменение торговой точки (если идентификатор  заполнен, произойдет изменение) */
  MerchantPoint createOrUpdateMerchantPoint(1:AuthTokenBase64 token, 2:MerchantPoint merchantPoint) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление торговой точки */
  void deleteMerchantPointById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение логотипа магазина */
  Picture createOrUpdateMerchantLogo(1:AuthTokenBase64 token, 2:Picture logo) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление логотипа магазина */
  void deleteMerchantLogo(1:AuthTokenBase64 token) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Создание или изменение акции (если идентификатор  заполнен, произойдет изменение) */
  MerchantAction createOrUpdateMerchantAction(1:AuthTokenBase64 token, 2:MerchantAction merchantAction) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение списка акций
    * (произойдет МАССОВОЕ удаление акций у которых есть externalId и которые отсутствуют в этом списке)
    **/
  list<MerchantAction> createOrUpdateMerchantActions(1:AuthTokenBase64 token, 2:list<MerchantAction> actions) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление акции */
  void deleteMerchantActionById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение картинки акции */
  Picture createOrUpdateMerchantActionPicture(1:AuthTokenBase64 token, 2:ID merchantActionId, 3:Picture logo) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление картинки акции */
  void deleteMerchantActionPicture(1:AuthTokenBase64 token, 2:ID merchantActionId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение картинки сертификата */
  Picture createOrUpdateCertificatePicture(1:AuthTokenBase64 token, 2:ID certificateId, 3:Picture logo) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление картинки сертификата */
  void deleteCertificatePicture(1:AuthTokenBase64 token, 2:ID certificateId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Создание или изменение сертификата */
  Certificate createOrUpdateCertificate(1:AuthTokenBase64 token, 2:Certificate certificate) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение списка сертификатов
  * (произойдет МАССОВОЕ удаление сертификатов у которых есть externalId и которые отсутствуют в этом списке)
  **/
  list<Certificate> createOrUpdateListCertificates(1:AuthTokenBase64 token, 2:list<Certificate> certificates) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление сертификата по идентификатору */
  void deleteCertificateById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Создание или изменение сотрудника магазина (если идентификатор  заполнен, произойдет изменение).
   *  При необходимости изменить пароль надо заполнить поля "newPassword" и "confirmation",
   *  если их не заполнять - изменение пароля не произойдет.
   **/
  User createOrUpdateUser(1:AuthTokenBase64 token, 2:User user, 3:string newPassword, 4: string confirmation) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение сотрудника по идентификатору */
  User getUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление сотрудника по идентификатору */
  void deleteUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Временное отключение сотрудника по идентификатору */
  void deactivateUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Отмена временного отключения сотрудника по идентификатору */
  void activateUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества сотрудников */
  count getCountUsersByMerchant(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка сотрудников */
  list<User> getUsersByMerchant(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества сотрудников по торговой точке */
  count getCountUsersByMerchantPoint(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка сотрудников по торговой точке */
  list<User> getUsersByMerchantPoint(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества торговых точек, к которым прикреплен пользователь */
  count getCountMerchantPointsByUser(1:AuthTokenBase64 token, 2:ID userId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка торговых точек, в которым прикреплен пользователь */
  list<MerchantPoint> getMerchantPointsByUser(1:AuthTokenBase64 token, 2:ID userId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Прикрепление пользователя к торговой точке */
  void attachMerchantPointToUser(1:AuthTokenBase64 token, 2: ID merchantPointId, 3:ID UserId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Открепление пользователя от торговой точке */
  void deattachMerchantPointFromUser(1:AuthTokenBase64 token, 2: ID merchantPointId, 3:ID UserId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Создание или изменение правила использования бонусов (если идентификатор  заполнен, произойдет изменение). **/
  DiscountRule createOrUpdateDiscountRule(1:AuthTokenBase64 token, 2:DiscountRule discountRule) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение правила использования бонусов по идентификатору */
  DiscountRule getDiscountRuleById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества правил использования бонусов */
  count getCountDiscountRules(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:ID merchantActionId, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение правил использования бонусов */
  list<DiscountRule> getDiscountRules(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:ID merchantActionId, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление правила использования бонусов по идентификатору */
  void deleteDiscountRuleById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис продаж */
service MerchantPointService {
  /** Получение информации о клиенте по идентификатору */
  ClientInfo getClientInfoById(1:AuthTokenBase64 token, 2:ID clientId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение информации о клиенте по идентификатору счета */
  ClientInfo getClientInfoByAccountId(1:AuthTokenBase64 token, 2:ID accountId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение информации о клиенте по номеру карты */
  ClientInfo getClientInfoByCardNumber(1:AuthTokenBase64 token, 2:ID bonusProgramId, 3:string cardNumber) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение информации о клиенте по однаразовому паролю */
  ClientInfo getClientInfoByOneTimePassword(1:AuthTokenBase64 token, 2:string oneTimePassword) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение информации о клиенте по подтвержденной коммуникации */
  ClientInfo getClientInfoByCommunication(1:AuthTokenBase64 token, 2:Communication communication) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение количества торговых точек, к которым прикреплен пользователь */
  count getCountAttachedMerchantPoints(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка торговых точек, в которым прикреплен пользователь */
  list<MerchantPoint> getAttachedMerchantPoints(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Проверка: прикреплена точка продажи к пользователю или нет */
  bool isMerchantPointAttached(1:AuthTokenBase64 token, 2:ID merchantPointId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение количества оплат в разрезе дат */
  count getCountProvidedPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка оплат в разрезе дат */
  list<Payment> getProvidedPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества оплат за последние "lastDays" дней */
  count getCountProvidedPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка оплат за последние "lastDays" дней */
  list<Payment> getProvidedPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);


  /** Создание оплаты.
  * Обязательное поле идентификатор клиента; для оплаты по коммуникации - 'средство связи'(подтвержденное),
  * если оба поля заполнены - в приоритете идентификатор клиента.
  * Для создания неперсонифицированной оплаты оба поля оставить пустыми.
  * */
  Payment createPayment(1:AuthTokenBase64 token, 2:Payment payment, 3:ID clientId, 4:Communication communication) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление оплаты */
  void removePaymentById(1:AuthTokenBase64 token, 2:ID id)  throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Запрос на подтверждение счета, при этом клиенту будет выслан код */
  Payment requestConfirmPayment(1:AuthTokenBase64 token, 2:ID paymentId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Обначилить заказ на списание средств, код проверки клиент называет продавцу.*/
  Payment confirmPayment(1:AuthTokenBase64 token, 2:ID paymentId, 3:string verifyCode) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение купленого сертификата по уникальному коду */
  ClientCertificate getCertificateByCode(1:AuthTokenBase64 token, 2:string certificateCode) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Использвать сертификат */
  Payment useCertificate(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:ID clientCertificateId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Метод, позволяющий расчитать размер возможной скидки */
  Discount calculateDiscount(1:AuthTokenBase64 token, 2:ID bonusProgramId, 3:ID clientId, 4:ID merchantPointId, 5:ID merchantActionId, 6:i64 amount) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис для получения бухгалтерских отчетов сотрудниками магазинов */
service MerchantBookService {
  /** Получение расширенной оплаты по идентификатору */
  MerchantPayment getPaymentById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества расширенных оплат в разрезе дат */
  count getCountPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:vgbDate dateFrom, 3:vgbDate dateTo, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат в разрезе дат */
  list<MerchantPayment> getPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:vgbDate dateFrom, 3:vgbDate dateTo, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества расширенных оплат за последние "lastDays" дней */
  count getCountPaymentsWithLastDays(1:AuthTokenBase64 token, 2:i16 lastDays, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат за последние "lastDays" дней */
  list<MerchantPayment> getPaymentsWithLastDays(1:AuthTokenBase64 token, 2:i16 lastDays, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества расширенных оплат по торговой точке в разрезе дат */
  count getCountPaymentsByMerchantPointWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат по торговой точке в разрезе дат */
  list<MerchantPayment> getPaymentsByMerchantPointWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества расширенных оплат по торговой точке за последние "lastDays" дней */
  count getCountPaymentsByMerchantPointWithLastDays(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат по торговой точке за последние "lastDays" дней */
  list<MerchantPayment> getPaymentsByMerchantPointWithLastDays(1:AuthTokenBase64 token, 2:ID merchantPointId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис администрирования системы */
service VGBService {
  /** Создание или изменение бонусной программы (если идентификатор  заполнен, произойдет изменение).*/
  ExtendedBonusProgram createOrUpdateBonusProgram(1:AuthTokenBase64 token, 2:ExtendedBonusProgram bonusProgram) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление бонусной программы */
  void deleteBonusProgramById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение бонусной программы по идентификатору */
  ExtendedBonusProgram getBonusProgramById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества бонусных программ */
  count getCountBonusPrograms(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка бонусных программ */
  list<ExtendedBonusProgram> getBonusPrograms(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание магазина (если идентификатор  заполнен, произойдет изменение).*/
  ExtendedMerchant createOrUpdateMerchant(1:AuthTokenBase64 token, 2:ExtendedMerchant extendedMerchant) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение магазинов */
  list<ExtendedMerchant> getExtendedMerchants(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества магазинов */
  count getCountExtendedMerchant(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление магазина */
  void deleteMerchantById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение курса обмена (если идентификатор  заполнен, произойдет изменение).*/
  ExchangeRate createOrUpdateExchangeRate(1:AuthTokenBase64 token, 2:ExchangeRate exchangeRate) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление курса обмена */
  void deleteExchangeRateById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Создание или изменение сотрудника VGB или магазина (если идентификатор  заполнен, произойдет изменение).
   *  При необходимости изменить пароль надо заполнить поля "newPassword" и "confirmation",
   *  если их не заполнять - изменение пароля не произойдет.
   **/
  User createOrUpdateUser(1:AuthTokenBase64 token, 2:User user, 3:string newPassword, 4: string confirmation) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получени сотрудника VGB или магазина по идентификатору */
  User getUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление сотрудника VGB или магазина по идентификатору */
  void deleteUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Временное отключение сотрудника VGB или магазина по идентификатору */
  void deactivateUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Отмена временного отключения сотрудника VGB или магазина по идентификатору */
  void activateUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление автоблокировки пользователя или сотрудника по идентификатору */
  void deleteAutoBlockUserById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества клиентов, сотрудников магазинов или сотрудников VGB */
  count getCountAllUsers(1:AuthTokenBase64 token, 2:UserType type, 3:ID merchantId, 4:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:AccessDenyException securityError, 4:ServerException error);
  /** Получение списка клиентов, сотрудников магазинов или сотрудников VGB */
  list<User> getAllUsers(1:AuthTokenBase64 token, 2:UserType type, 3:ID merchantId, 4:Filter filter) throws (1:PreconditionException validError, 2:WrongSessionException sessionError, 3:AccessDenyException securityError, 4:ServerException error);

  /** Регистрация или изменение поставщика (если идентификатор  заполнен, произойдет изменение) */
  Supplier createOrUpdateSupplier(1:AuthTokenBase64 token, 2: Supplier supplier) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение поставщика по идентификатору */
  Supplier getSupplierById(1:AuthTokenBase64 token, 2: ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление поставщика по идентификатору */
  void deleteSupplierById(1:AuthTokenBase64 token, 2: ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Временное отключение поставщика по идентификатору */
  void deactivateSupplierById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Отмена временного отключения поставщика по идентификатору */
  void activateSupplierById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества поставщиков */
  count getCountAllSuppliers(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка поставщиков */
  list<Supplier> getAllSuppliers(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Получение количества расширенных оплат в разрезе дат */
  count getCountPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат в разрезе дат */
  list<MerchantPayment> getPaymentsWithFromToDate(1:AuthTokenBase64 token, 2:ID merchantId, 3:vgbDate dateFrom, 4:vgbDate dateTo, 5:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества расширенных оплат за последние "lastDays" дней */
  count getCountPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID merchantId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка расширенных оплат за последние "lastDays" дней */
  list<MerchantPayment> getPaymentsWithLastDays(1:AuthTokenBase64 token, 2:ID merchantId, 3:i16 lastDays, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Подтвердить монетаризацию оплаты */
  MerchantPayment processPaymentAccounting(1:AuthTokenBase64 token, 2:vgbFullDate date, 3:ID paymentId, 4:string paymentDescription) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Подтвердить монетаризацию списка оплат */
  list<MerchantPayment> processPaymentsAccounting(1:AuthTokenBase64 token, 2:vgbFullDate date, 3:list<ID> paymentIds, 4:string paymentDescription) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);

  /** Регистрация или изменение файлового обработчика(службы начисления бонусов) (если идентификатор  заполнен, произойдет изменение) */
  ETL createOrUpdateETL(1:AuthTokenBase64 token, 2: ETL etl) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение файлового обработчика(службы начисления бонусов) по идентификатору */
  ETL getETLById(1:AuthTokenBase64 token, 2: ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удаление файлового обработчика(службы начисления бонусов) по идентификатору */
  void deleteETLById(1:AuthTokenBase64 token, 2: ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Временное отключение файлового обработчика(службы начисления бонусов) по идентификатору */
  void deactivateETLById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Отмена временного отключения файлового обработчика(службы начисления бонусов) по идентификатору */
  void activateETLById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение количества файловых обработчиков(службы начисления бонусов) */
  count getCountAllETLs(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение списка файловых обработчиков(службы начисления бонусов) */
  list<ETL> getAllETLs(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Приоретизация мерчантов, сертификатов, акций */
  void setShowPriority(1:AuthTokenBase64 token, 2:TagObject objType, 3: list<ID> objIds, 4:i32 priority) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Получение приоретизации мерчантов, сертификатов, акций */
  string getShowPriority(1:AuthTokenBase64 token, 2:TagObject objType, 3:ID objId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Удалить приоретизацию мерчантов, сертификатов, акций */
  void removeShowPriority(1:AuthTokenBase64 token, 2:TagObject objType, 3: list<ID> objIds) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** Безвозвратное удаление пользователя из системы */
  void removeClient(1:AuthTokenBase64 token, 2:ID clientId, 3: string login) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис для начисления бонусов */
service ProcessingService {
  Adjunction payBonuses(1:AuthTokenBase64 token, 2:Adjunction adjunction) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
  /** начисление бонусов по клиенту на счет */
  Adjunction payBonusesByClient(1:AuthTokenBase64 token, 2:Adjunction adjunction) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис для тегов */
service TagService {
   /** Создание тега (если идентификатор  заполнен, произойдет изменение).*/
   Tag createOrUpdateTag(1:AuthTokenBase64 token, 2:Tag tag) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Получение тега */
   Tag getTagById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Получение количества тегов */
   count getCountTags(1:AuthTokenBase64 token, 2:ID parentId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Получение тегов */
   list<Tag> getAllTags(1:AuthTokenBase64 token, 2:ID parentId, 3:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Удаление тега */
   void deleteTagById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Прикрипление тега */
   void attachTag(1:AuthTokenBase64 token, 2:TagObject type, 3:ID objId, 4:ID tagId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Открепление тега */
   void deattachTag(1:AuthTokenBase64 token, 2:TagObject type, 3:ID objId, 4:ID tagId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Получение тегов прикрепленных к обьекту */
   list<Tag> getTagsByObject(1:AuthTokenBase64 token, 2:TagObject type, 3:ID objId) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Поиск сходных мерчантов, сертификатов и акций по тегам */
   list<ID> getSimilarObjectIDs(1:AuthTokenBase64 token, 2:TagObject type, 3:ID objId, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
   /** Получение количества сходных мерчантов, сертификатов и акций по тегам */
   count getCountSimilarObjectIDs(1:AuthTokenBase64 token, 2:TagObject type, 3:ID objId, 4:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

/** Сервис для обработки списка желаний клиента */
service WishService {
    /** Найти желание по идентификатору*/
    Wish findWishById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Создать или обновить желание (если идентификатор  заполнен, произойдет изменение).*/
    Wish createOrUpdateWish(1:AuthTokenBase64 token, 2:Wish wish) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Удалить желание по идентификатору */
    void removeWishById(1:AuthTokenBase64 token, 2:ID id) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Удалить желание по объекту */
    void removeWishByObjectId(1:AuthTokenBase64 token, 2:ID wishId, 3:WishType wishType) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Получить список желаний по пользователю и фильтру */
    list<Wish> getAllWishes(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Получить общее количество желаний в списке желаний пользователя */
    count getCountAllWishes(1:AuthTokenBase64 token, 2:Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Проверить есть ли акция или сертификат в списке желаний */
    bool isInWishes(1:AuthTokenBase64 token, 2:ID wishId, 3:WishType wishType) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}

enum ReportType {
    CSV
}

/** Сервис для отчетов */
service ReportService {
    /** Отчет выполненных начислений по supplierID */
    list<CardOrder> getAccruedCardOrders(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Получить количество отчетов выполненных начислений по supplierID */
    count getCountAccruedCardOrders(1:AuthTokenBase64 token, 2: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
    /** Отчет списания бонусов */
    list<string> getDebitPaymentsInfo(1:AuthTokenBase64 token, 2: ReportType type, 3: Filter filter) throws (1:WrongSessionException sessionError, 2:AccessDenyException securityError, 3:PreconditionException validError, 4:ServerException error);
}