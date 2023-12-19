# bezopdet-planning

Ruby on Rails приложение социального проекта **"Безопасное детство"**. Приложение позволяет планомерно изучать активности проекта с Вашим ребенком, формируя уровень подготовленности. На всех этапах работы Вы будете получать уведомления посредством email, а также telegram и google calendar.
<br/>
<br/>
<br/>
>Пользователи приложения могут создавать личные кабинеты для своих детей. В ЛК доступны для изучения активности от социального проекта **"Безопасное детство"**. Изучая активности с ребенком, повышается уровень защиты.
Персональный календарь изучения активностей позволит Вам легко планировать. Также в ЛК доступен сервис по формированию так называемого паспорта безопасности ребенка. Данные паспорта можно предварительно заполнить в ЛК, включая контакты родственников, или сформировать шаблон для рукописного ввода данных. Приложение напомнит Вам о запланированной активности, а также предупредит о необходимости повторения программы.
<br/>

Посмотреть работу приложения на [VPS](https://bezopdet-planning.ru/)
<br/>
<br/>
<br/>
### Версии Ruby и Rails:

```
ruby '3.1.2', rails '7.0.4.3';

JavaScript approach 'webpack', RubyGems '3.3.7', Rack '2.2.6.4', Database 'postgresql'.
```

### Реализовано в приложении:

- Аутентификация `devise >= 4.9.0`;

- Аутентификация через аккаунт Google с помощью `omniauth-google-oauth2`;

- Авторизация с помощью `pundit`;

- Локализация и интернационализация с помощью `rails-i18n`;

- Платформа администрирования `activeadmin`;

- Календари активностей детей с помощью `simple_calendar`;

- Загрузка изображений с помощью `Active Storage` и хранение `AWS S3 Yandex Cloud`;

- Паспорт безопасности - преобразование HTML в PDF с помощью `Google Puppeteer/Chromium` и `grover`;

- Фронтенд с помощью `bootstrap 5`, иконки `bootstrap-icons`, `font-awesome-sass`;

- `ActionMailer`, `Mailjet` для отправки email уведомлений с помощью `ActiveJob` и `Sidekiq`;

- Стилизация email писем с помощью `bootstrap-email`;

- Рассылка уведомлений по расписанию с помощью `whenever`;

- Рассылка уведомлений в telegram c помощью `httparty`;

- Синхронизация событий календаря с API Google Calendar с помощью `google-api-client`;

- Обновление Datepicker при помощи `flatpickr`;

- Мультиплатформенный значок с помощью `rails_real_favicon`;

- Деплой на VPS от `beget.com` с помощью `Capistrano`.
