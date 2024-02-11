1. Описание проекта

Проект представляет собой веб-приложение для онлайн-магазина.

2. Как запустить

2.1 Инструменты

В проекте использются: jdk 21, среда eclipse(EE, Enterpraise Edition), сервер для веб-прилоения Apachi Tomcat, jdbс-driver для базы данных Microsoft SQL SERVER, сторонние библиотеки.

2.2 Установка сервера Apachi Tomcat версии 8.5.92 и подключение

При установке следует учесть версию Apachi Tomcat 8.5.92, использемую в проекте. Установка и подключение сервера рассмотрены в видио - https://www.youtube.com/watch?v=CyJi6iwFJgY. 

2.3 JDBC-драйвер и сторонние библиотеки

Все .jar файлы находятся в по пути  src/main/webapp/WEB-INF/lib данного репозитория. Необходимо чтобы они находились по этому же пути и у вас чтобы сервер мог их читать. Эти файлы должны находится в buildpath проекта в eclipse.
Чтобы это проверить проделайте следующее: ПКМ на проект-> Build Path -> Configure Build Path->Libraries в появившемя окне должен быть список библиотек, если они отсутствуют установите их в добавьте с помощью кнопки Add Jars.

2.4 БД

В проекте используется СУБД SQL SERVER 2016 для работы с которой используется графическая среда Microsoft SQL SERVER MANAGEMENT STUDIO 19. По сути можно четко не придерживаться этих версий.
После установки предыдущих компонентов используйте файл с sql-скриптом DB_Script.sql из данного репозитория для создания схемы базы данных. Скачайте его, откройте с помощью Microsoft SQL SERVER MANAGEMENT STUDIO и запустите скрипт.

2.5 Комментарии

* Для работы функции создающей отчет необходимо скачать файл List1VP.jasper из данного репозитория, переместить по "схожему" пути указанному ниже и изменить следующие строки кода из класса build/classes/model/Reports.class

  jasperFile = "D:\\JavaWorkSpace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\KursovoiWebAppWithDB\\downloads\\List1VP.jasper"; //Измените на ваш путь и замените одинарные \ на двойные

  Здесь JavaWorkSpace - папка в которой лежит проект, downloads - созданная папка

  nameFile = "D:\\JavaWorkSpace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\KursovoiWebAppWithDB\\downloads\\List1VP.pdf"; //Измените путь аналогично примеру выше

  Здесь List1VP.pdf создасться сам

* Замените текущую строку подключения к БД на вашу в классе build/classes/dao/DataSql.class

String connectionUrl = "jdbc:sqlserver://DESKTOP-OMBNSHK\\MSSQLSERVER2022:5022;encrypt=true;trustServerCertificate=true;databaseName=kursovoi;user=sa;password=123"; // Отредактируйте под свою БД

  


  

