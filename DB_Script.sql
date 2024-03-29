USE [master]
GO
/****** Object:  Database [kursovoi]    Script Date: 11.02.2024 16:42:22 ******/
CREATE DATABASE [kursovoi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kursovoi', FILENAME = N'D:\SqlServer\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\kursovoi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'kursovoi_log', FILENAME = N'D:\SqlServer\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\kursovoi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [kursovoi] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kursovoi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kursovoi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kursovoi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kursovoi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kursovoi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kursovoi] SET ARITHABORT OFF 
GO
ALTER DATABASE [kursovoi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kursovoi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kursovoi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kursovoi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kursovoi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kursovoi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kursovoi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kursovoi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kursovoi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kursovoi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kursovoi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kursovoi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kursovoi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kursovoi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kursovoi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kursovoi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kursovoi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kursovoi] SET RECOVERY FULL 
GO
ALTER DATABASE [kursovoi] SET  MULTI_USER 
GO
ALTER DATABASE [kursovoi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kursovoi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kursovoi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kursovoi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [kursovoi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [kursovoi] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'kursovoi', N'ON'
GO
ALTER DATABASE [kursovoi] SET QUERY_STORE = ON
GO
ALTER DATABASE [kursovoi] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [kursovoi]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[Properties] [nvarchar](150) NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
	[LeftInStorage] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Providers]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Providers](
	[ProviderID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Providers] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetails](
	[PurchaseID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[Products_number] [int] NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_PurchaseDetails] PRIMARY KEY CLUSTERED 
(
	[PurchaseID] ASC,
	[ProductID] ASC,
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseDetailsStatistic]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetailsStatistic](
	[ProductID] [int] NOT NULL,
	[ProductTypeID] [int] NOT NULL,
 CONSTRAINT [PK_PurchaseDetailsStatistic] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[PurchaseID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Products_number] [int] NOT NULL,
	[Cost] [decimal](18, 0) NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Purchases] PRIMARY KEY CLUSTERED 
(
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesStatistics]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesStatistics](
	[ProductID] [int] NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Earnings] [decimal](18, 0) NOT NULL,
	[ProductsNumber] [int] NOT NULL,
 CONSTRAINT [PK_PurchasesStatistics] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[ProductTypeID] ASC,
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplies]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplies](
	[ProductTypeID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProviderID] [int] NOT NULL,
	[Cost] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Supplies] PRIMARY KEY CLUSTERED 
(
	[ProductTypeID] ASC,
	[ProductID] ASC,
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11.02.2024 16:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[UserRole] [nvarchar](50) NULL,
	[Balance] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (13, 1, N'картон', N'Крепкий2', N'кол-во слоев:3, длина: 5.5, площадь: 2.5', CAST(20.99 AS Decimal(18, 2)), 33)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (16, 2, N'клей', N'Моментальный', N'объем:2.5', CAST(8.99 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (17, 2, N'клей', N'Монтажный', N'объем:1.5', CAST(13.99 AS Decimal(18, 2)), 0)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (22, 5, N'лента', N'уплотнительная', N'длина:30.0,ширина:0.09', CAST(16.99 AS Decimal(18, 2)), 15)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (23, 3, N'пленка', N'Пузырьковая', N'длина:10.0,ширина:2.5,вес:2.5', CAST(16.99 AS Decimal(18, 2)), 5)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (25, 1, N'картон', N'Для стекла', N'кол-во слоев:2,длина:4.0,площадь:4.5', CAST(25.00 AS Decimal(18, 2)), 0)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (26, 1, N'картон', N'Укрывочный', N'кол-во слоев:1,длина:3.0,площадь:4.0', CAST(30.99 AS Decimal(18, 2)), 30)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (27, 1, N'картон', N'Гофрированный', N'кол-во слоев:5,длина:0.8,площадь:0.8', CAST(15.25 AS Decimal(18, 2)), 200)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (28, 1, N'картон', N'Микровогофрированный', N'кол-во слоев:7,длина:1.0,площадь:1.0', CAST(20.75 AS Decimal(18, 2)), 65)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (29, 1, N'картон', N'Двухслойный', N'кол-во слоев:2,длина:0.3,площадь:0.3', CAST(5.80 AS Decimal(18, 2)), 40)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (30, 1, N'картон', N'Трехслойный', N'кол-во слоев:3,длина:0.4,площадь:0.4', CAST(8.60 AS Decimal(18, 2)), 80)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (31, 1, N'картон', N'Крафтовый', N'кол-во слоев:1,длина:0.2,площадь:0.2', CAST(3.25 AS Decimal(18, 2)), 20)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (32, 1, N'картон', N'Ламинированный', N'кол-во слоев:4,длина:0.6,площадь:0.6', CAST(12.40 AS Decimal(18, 2)), 120)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (33, 1, N'картон', N'Усиленный', N'кол-во слоев:3,длина:0.5,площадь:0.5', CAST(11.75 AS Decimal(18, 2)), 90)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (35, 2, N'клей', N'ПВА', N'объем:0.5', CAST(7.50 AS Decimal(18, 2)), 100)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (36, 2, N'клей', N'Момент', N'объем:0.25', CAST(5.25 AS Decimal(18, 2)), 80)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (37, 2, N'клей', N'Эпоксидный', N'объем:0.1', CAST(9.75 AS Decimal(18, 2)), 100)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (38, 2, N'клей', N'Контактный', N'объем:0.05', CAST(3.50 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (39, 2, N'клей', N'Универсальный', N'объем:0.2', CAST(6.80 AS Decimal(18, 2)), 90)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (40, 2, N'клей', N'Суперклей', N'объем:0.1', CAST(2.25 AS Decimal(18, 2)), 30)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (41, 2, N'клей', N'Акриловый', N'объем:0.15', CAST(4.90 AS Decimal(18, 2)), 70)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (42, 2, N'клей', N'Жидкий', N'объем:0.3', CAST(8.20 AS Decimal(18, 2)), 110)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (43, 2, N'клей', N'Силиконовый', N'объем:0.08', CAST(5.90 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (44, 4, N'гипсокартон', N'Стандартный', N'длина:2.4,ширина:1.2,толщина:1.2', CAST(12.50 AS Decimal(18, 2)), 89)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (45, 4, N'гипсокартон', N'Звукоизоляционный', N'длина:2.4,ширина:1.2,толщина:1.5', CAST(15.80 AS Decimal(18, 2)), 69)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (46, 4, N'гипсокартон', N'Влагостойкий', N'длина:2.4,ширина:1.2,толщина:1.2', CAST(14.25 AS Decimal(18, 2)), 119)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (47, 4, N'гипсокартон', N'Огнестойкий', N'длина:2.4,ширина:1.2,толщина:1.5', CAST(18.60 AS Decimal(18, 2)), 59)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (48, 4, N'гипсокартон', N'Универсальный', N'длина:2.4,ширина:1.2,толщина:1.2', CAST(11.90 AS Decimal(18, 2)), 90)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (49, 4, N'гипсокартон', N'Арочный', N'длина:2.4,ширина:0.6,толщина:1.0', CAST(9.25 AS Decimal(18, 2)), 30)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (50, 4, N'гипсокартон', N'Подвесной', N'длина:2.0,ширина:0.6,толщина:1.2', CAST(10.80 AS Decimal(18, 2)), 70)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (51, 4, N'гипсокартон', N'Акустический', N'длина:2.4,ширина:1.2,толщина:1.5', CAST(16.40 AS Decimal(18, 2)), 110)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (52, 4, N'гипсокартон', N'Термоизоляционный', N'длина:2.4,ширина:1.2,толщина:2.0', CAST(21.25 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (53, 5, N'лента', N'Акриловая', N'длина:50.0,ширина:0.05', CAST(2.50 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (54, 5, N'лента', N'Бумажная', N'длина:100.0,ширина:0.02', CAST(1.80 AS Decimal(18, 2)), 200)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (55, 5, N'лента', N'Полипропиленовая', N'длина:30.0,ширина:0.03', CAST(3.25 AS Decimal(18, 2)), 150)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (56, 5, N'лента', N'Тканевая', N'длина:20.0,ширина:0.04', CAST(4.60 AS Decimal(18, 2)), 80)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (57, 5, N'лента', N'ПВХ', N'длина:200.0,ширина:0.01', CAST(0.90 AS Decimal(18, 2)), 300)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (58, 5, N'лента', N'Стеклотканевая', N'длина:50.0,ширина:0.1', CAST(5.20 AS Decimal(18, 2)), 50)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (59, 5, N'лента', N'Алюминиевая', N'длина:100.0,ширина:0.02', CAST(3.10 AS Decimal(18, 2)), 120)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (60, 5, N'лента', N'Хлопковая', N'длина:30.0,ширина:0.06', CAST(6.80 AS Decimal(18, 2)), 70)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (61, 5, N'лента', N'Металлическая', N'длина:20.0,ширина:0.04', CAST(8.25 AS Decimal(18, 2)), 40)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (62, 5, N'лента', N'Полиэстеровая', N'длина:40.0,ширина:0.03', CAST(3.75 AS Decimal(18, 2)), 90)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (63, 3, N'пленка', N'Полиэтиленовая', N'длина:100.0,ширина:2.0,вес:2.0', CAST(5.50 AS Decimal(18, 2)), 170)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (64, 3, N'пленка', N'ПВХ', N'длина:80.0,ширина:1.5,вес:1.5', CAST(3.20 AS Decimal(18, 2)), 118)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (65, 3, N'пленка', N'Полипропиленовая', N'длина:120.0,ширина:2.2,вес:2.2', CAST(4.75 AS Decimal(18, 2)), 180)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (66, 3, N'пленка', N'Полиэстеровая', N'длина:60.0,ширина:1.0,вес:1.0', CAST(2.80 AS Decimal(18, 2)), 250)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (67, 3, N'пленка', N'Пенополиэтиленовая', N'длина:150.0,ширина:3.5,вес:3.5', CAST(6.90 AS Decimal(18, 2)), 120)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (68, 3, N'пленка', N'Полиуретановая', N'длина:90.0,ширина:1.8,вес:1.8', CAST(3.80 AS Decimal(18, 2)), 170)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (69, 3, N'пленка', N'Акриловая', N'длина:110.0,ширина:2.5,вес:2.5', CAST(5.20 AS Decimal(18, 2)), 140)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (70, 3, N'пленка', N'Полиамидная', N'длина:70.0,ширина:1.2,вес:1.2', CAST(2.50 AS Decimal(18, 2)), 220)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (71, 3, N'пленка', N'Поливиниловая', N'длина:130.0,ширина:2.8,вес:2.8', CAST(6.10 AS Decimal(18, 2)), 160)
INSERT [dbo].[Products] ([ProductID], [ProductTypeID], [Name], [TypeName], [Properties], [Cost], [LeftInStorage]) VALUES (72, 4, N'гипсокартон', N'Монтажный', N'длина:2.0,ширина:1.0,толщина:1.0', CAST(10.00 AS Decimal(18, 2)), 20)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Providers] ON 

INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (4, N'NewProvider')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (5, N'BelStroy')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (6, N'Мамонт')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (7, N'СтройПром')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (8, N'ПромСтройСнабжение')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (9, N'СтройИнвестГруппа')
INSERT [dbo].[Providers] ([ProviderID], [Name]) VALUES (10, N'СтройМастер')
SET IDENTITY_INSERT [dbo].[Providers] OFF
GO
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (47, 13, 1, 1, CAST(20.99 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 13, 1, 1, CAST(20.99 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 16, 2, 1, CAST(8.99 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 17, 2, 1, CAST(13.99 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 20, 4, 2, CAST(45.98 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 44, 4, 1, CAST(12.50 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 45, 4, 1, CAST(15.80 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 46, 4, 1, CAST(14.25 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (48, 47, 4, 1, CAST(18.60 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (49, 13, 1, 50, CAST(1049.50 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (50, 29, 1, 10, CAST(58.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (50, 31, 1, 10, CAST(32.50 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (50, 34, 1, 15, CAST(118.50 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (51, 20, 4, 20, CAST(459.80 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (51, 44, 4, 11, CAST(137.50 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (51, 45, 4, 10, CAST(158.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (52, 13, 1, 3, CAST(62.97 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (52, 16, 2, 20, CAST(179.80 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (52, 17, 2, 5, CAST(69.95 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (52, 20, 4, 10, CAST(229.90 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (53, 23, 3, 7, CAST(118.93 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (53, 63, 3, 30, CAST(165.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (53, 64, 3, 32, CAST(102.40 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (54, 25, 1, 20, CAST(500.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (55, 22, 5, 2, CAST(33.98 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseDetails] ([PurchaseID], [ProductID], [ProductTypeID], [Products_number], [Cost]) VALUES (56, 17, 2, 2, CAST(27.98 AS Decimal(18, 2)))
GO
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (13, 1)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (16, 2)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (17, 2)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (20, 4)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (22, 5)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (23, 3)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (25, 1)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (29, 1)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (31, 1)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (34, 1)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (44, 4)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (45, 4)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (46, 4)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (47, 4)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (63, 3)
INSERT [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID]) VALUES (64, 3)
GO
SET IDENTITY_INSERT [dbo].[Purchases] ON 

INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (47, 1, 1, CAST(21 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (48, 1, 9, CAST(151 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (49, 1, 50, CAST(1050 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (50, 1, 35, CAST(209 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (51, 1, 41, CAST(755 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (52, 1, 38, CAST(543 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (53, 1, 69, CAST(386 AS Decimal(18, 0)), CAST(N'2023-12-15' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (54, 1, 20, CAST(500 AS Decimal(18, 0)), CAST(N'2023-12-20' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (55, 1, 2, CAST(34 AS Decimal(18, 0)), CAST(N'2023-12-20' AS Date))
INSERT [dbo].[Purchases] ([PurchaseID], [UserID], [Products_number], [Cost], [Date]) VALUES (56, 1, 2, CAST(28 AS Decimal(18, 0)), CAST(N'2024-02-03' AS Date))
SET IDENTITY_INSERT [dbo].[Purchases] OFF
GO
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (13, 1, CAST(N'2023-12-15' AS Date), CAST(1155 AS Decimal(18, 0)), 55)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (16, 2, CAST(N'2023-12-15' AS Date), CAST(189 AS Decimal(18, 0)), 21)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (17, 2, CAST(N'2023-12-15' AS Date), CAST(84 AS Decimal(18, 0)), 6)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (17, 2, CAST(N'2024-02-03' AS Date), CAST(28 AS Decimal(18, 0)), 2)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (20, 4, CAST(N'2023-12-15' AS Date), CAST(736 AS Decimal(18, 0)), 32)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (22, 5, CAST(N'2023-12-20' AS Date), CAST(34 AS Decimal(18, 0)), 2)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (23, 3, CAST(N'2023-12-15' AS Date), CAST(119 AS Decimal(18, 0)), 7)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (25, 1, CAST(N'2023-12-20' AS Date), CAST(500 AS Decimal(18, 0)), 20)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (29, 1, CAST(N'2023-12-15' AS Date), CAST(58 AS Decimal(18, 0)), 10)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (31, 1, CAST(N'2023-12-15' AS Date), CAST(33 AS Decimal(18, 0)), 10)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (34, 1, CAST(N'2023-12-15' AS Date), CAST(119 AS Decimal(18, 0)), 15)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (44, 4, CAST(N'2023-12-15' AS Date), CAST(151 AS Decimal(18, 0)), 12)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (45, 4, CAST(N'2023-12-15' AS Date), CAST(174 AS Decimal(18, 0)), 11)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (46, 4, CAST(N'2023-12-15' AS Date), CAST(14 AS Decimal(18, 0)), 1)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (47, 4, CAST(N'2023-12-15' AS Date), CAST(19 AS Decimal(18, 0)), 1)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (63, 3, CAST(N'2023-12-15' AS Date), CAST(165 AS Decimal(18, 0)), 30)
INSERT [dbo].[PurchasesStatistics] ([ProductID], [ProductTypeID], [Date], [Earnings], [ProductsNumber]) VALUES (64, 3, CAST(N'2023-12-15' AS Date), CAST(102 AS Decimal(18, 0)), 32)
GO
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 25, 5, N'20.00     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 26, 4, N'23.99     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 27, 6, N'12.50     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 28, 10, N'17.25     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 29, 7, N'4.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 30, 8, N'6.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 31, 9, N'2.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 32, 5, N'9.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (1, 33, 10, N'9.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 35, 5, N'6.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 36, 7, N'4.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 37, 8, N'8.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 38, 9, N'2.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 39, 10, N'5.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 40, 4, N'1.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 41, 5, N'3.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 42, 6, N'6.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (2, 43, 7, N'4.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 63, 4, N'4.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 64, 5, N'2.80      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 65, 6, N'3.90      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 66, 7, N'2.40      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 67, 8, N'5.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 68, 9, N'3.10      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 69, 9, N'4.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 70, 10, N'1.90      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (3, 71, 6, N'5.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 44, 4, N'10.75     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 45, 5, N'13.50     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 46, 7, N'11.75     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 47, 6, N'15.25     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 48, 8, N'9.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 49, 9, N'7.6       ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 50, 9, N'8.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 51, 10, N'13.75     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 52, 4, N'17.50     ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (4, 72, 7, N'7.00      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 53, 4, N'1.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 54, 5, N'1.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 55, 6, N'2.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 56, 7, N'3.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 57, 8, N'0.70      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 58, 9, N'4.25      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 59, 10, N'2.50      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 60, 6, N'5.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 61, 8, N'6.75      ')
INSERT [dbo].[Supplies] ([ProductTypeID], [ProductID], [ProviderID], [Cost]) VALUES (5, 62, 10, N'3.25      ')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (1, N'Dima', N'1234', N'user', CAST(270.66 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (2, N'Andrew', N'2332', N'user', NULL)
INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (3, N'Oleg', N'Oleg1234', N'user', NULL)
INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (4, N'admin', N'admin', N'admin', NULL)
INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (5, N'Vlad', N'2004', N'user', NULL)
INSERT [dbo].[Users] ([UserID], [Login], [Password], [UserRole], [Balance]) VALUES (6, N'Pasha', N'1234', N'user', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Purchases] ADD  CONSTRAINT [DF_Purchases_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[PurchasesStatistics] ADD  CONSTRAINT [DF_PurchasesStatistics_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseDetails_Products] FOREIGN KEY([ProductID], [ProductTypeID])
REFERENCES [dbo].[Products] ([ProductID], [ProductTypeID])
GO
ALTER TABLE [dbo].[PurchaseDetails] NOCHECK CONSTRAINT [FK_PurchaseDetails_Products]
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseDetails_PurchaseDetailsStatistic] FOREIGN KEY([ProductID], [ProductTypeID])
REFERENCES [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID])
GO
ALTER TABLE [dbo].[PurchaseDetails] NOCHECK CONSTRAINT [FK_PurchaseDetails_PurchaseDetailsStatistic]
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseDetails_Purchases] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchases] ([PurchaseID])
GO
ALTER TABLE [dbo].[PurchaseDetails] NOCHECK CONSTRAINT [FK_PurchaseDetails_Purchases]
GO
ALTER TABLE [dbo].[Purchases]  WITH CHECK ADD  CONSTRAINT [FK_Purchases_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Users]
GO
ALTER TABLE [dbo].[PurchasesStatistics]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchasesStatistics_PurchaseDetailsStatistic] FOREIGN KEY([ProductID], [ProductTypeID])
REFERENCES [dbo].[PurchaseDetailsStatistic] ([ProductID], [ProductTypeID])
GO
ALTER TABLE [dbo].[PurchasesStatistics] NOCHECK CONSTRAINT [FK_PurchasesStatistics_PurchaseDetailsStatistic]
GO
ALTER TABLE [dbo].[Supplies]  WITH NOCHECK ADD  CONSTRAINT [FK_Supplies_Providers] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[Providers] ([ProviderID])
GO
ALTER TABLE [dbo].[Supplies] NOCHECK CONSTRAINT [FK_Supplies_Providers]
GO
/****** Object:  StoredProcedure [dbo].[InsertProductProcedure]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProductProcedure] (@Name VARCHAR(50),@TypeName VARCHAR(50), @Properties VARCHAR(150),  @Left INT, @Cost decimal(18,2))
AS
BEGIN
	IF @Name='картон' 
	BEGIN
       INSERT INTO dbo.Products(ProductTypeID,Name, TypeName, Properties, Cost, LeftInStorage)
	   VALUES(1,@Name, @TypeName, @Properties, @Cost, @Left);
	END
	IF @Name='клей' 
	BEGIN
       INSERT INTO dbo.Products(ProductTypeID,Name, TypeName, Properties, Cost, LeftInStorage)
	   VALUES(2,@Name, @TypeName, @Properties, @Cost, @Left);
	END
 
END
GO
/****** Object:  StoredProcedure [dbo].[NewCardboardProcedure]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewCardboardProcedure] (@typeName VARCHAR(50), @layers INT, @length decimal(18,2),
@area decimal(18,2),@cost decimal(18,2), @left int, @providerCost decimal(18,2),
@providerName VARCHAR(50), @out VARCHAR(50) OUTPUT)
AS
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM dbo.Cardboard
        WHERE TypeName = @typeName
			AND LayersNumber = @layers
			AND Length = @length
			AND Area = @area
            AND Cost = @cost
	)
    BEGIN
        -- Вставка данных в таблицу
        INSERT INTO dbo.Cardboard(ProductTypeID,Name,TypeName,LayersNumber,Length,Area,Cost,LeftInStorage)
        VALUES (
            1, -- Значение для столбца ProductTypeID
            'картон', -- Значение для столбца Name
            @typeName,
            @layers,
			@left,
			@area,
            @cost,
            @left
        );

		DECLARE @productIndex INT;
		SET @productIndex=(SELECT MAX(ProductID) FROM dbo.Cardboard);

		DECLARE @providerIndex INT;
		SET @providerIndex=(SELECT ProviderID FROM dbo.Providers WHERE Name=@providerName);

		INSERT dbo.Supplies(ProductTypeID,ProductID,ProviderID,Cost)
		VALUES(1,@productIndex,@providerIndex,@providerCost);

        -- Установка значения выходного параметра
        SET @out = 'Success';
    END
    ELSE
    BEGIN
        -- Установка значения выходного параметра
        SET @out = 'Error';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[NewGlueProcedure]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewGlueProcedure] (@typeName VARCHAR(50), @volume decimal(18,2),
@cost decimal(18,2), @left int, @providerCost decimal(18,2), @providerName VARCHAR(50), @out VARCHAR(50) OUTPUT)
AS
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM dbo.Glue
        WHERE TypeName = @typeName
			AND Volume = @volume
            AND Cost = @cost
	)
    BEGIN
        -- Вставка данных в таблицу
        INSERT INTO dbo.Glue (ProductTypeID, Name, TypeName, Volume, Cost, LeftInStock)
        VALUES (
            2, -- Значение для столбца ProductTypeID
            'клей', -- Значение для столбца Name
            @typeName,
            @volume,
            @cost,
            @left
        );

		DECLARE @productIndex INT;
		SET @productIndex=(SELECT MAX(ProductID) FROM dbo.Glue);

		DECLARE @providerIndex INT;
		SET @providerIndex=(SELECT ProviderID FROM dbo.Providers WHERE Name=@providerName);

		INSERT dbo.Supplies(ProductTypeID,ProductID,ProviderID,Cost)
		VALUES(2,@productIndex,@providerIndex,@providerCost);

        -- Установка значения выходного параметра
        SET @out = 'Success';
    END
    ELSE
    BEGIN
        -- Установка значения выходного параметра
        SET @out = 'Error';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[NewProduct]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewProduct] (@name VARCHAR(50),@typeName VARCHAR(50), @properties VARCHAR(150), 
@cost decimal(18,2), @left int, @providerCost decimal(18,2),
@providerName VARCHAR(50), @out VARCHAR(50) OUTPUT)
AS
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM dbo.Products
        WHERE Name=@name
			AND TypeName = @typeName
			AND Properties=@properties
            AND Cost = @cost
	)
    BEGIN
        -- Вставка данных в таблицу
		IF @name='картон'
		BEGIN
			INSERT INTO dbo.Products(ProductTypeID,Name,TypeName,Properties,Cost,LeftInStorage)
			VALUES (
				1, -- Значение для столбца ProductTypeID
				'картон', -- Значение для столбца Name
				@typeName,
				@properties,
				@cost,
				@left
			);
		END

		IF @name='клей'
		BEGIN
			INSERT INTO dbo.Products(ProductTypeID,Name,TypeName,Properties,Cost,LeftInStorage)
			VALUES (
				2, -- Значение для столбца ProductTypeID
				'клей', -- Значение для столбца Name
				@typeName,
				@properties,
				@cost,
				@left
			);
		END

			IF @name='пленка'
		BEGIN
			INSERT INTO dbo.Products(ProductTypeID,Name,TypeName,Properties,Cost,LeftInStorage)
			VALUES (
				3, -- Значение для столбца ProductTypeID
				@name, -- Значение для столбца Name
				@typeName,
				@properties,
				@cost,
				@left
			);
		END

			IF @name='гипсокартон'
		BEGIN
			INSERT INTO dbo.Products(ProductTypeID,Name,TypeName,Properties,Cost,LeftInStorage)
			VALUES (
				4, -- Значение для столбца ProductTypeID
				@name, -- Значение для столбца Name
				@typeName,
				@properties,
				@cost,
				@left
			);
		END

			IF @name='лента'
		BEGIN
			INSERT INTO dbo.Products(ProductTypeID,Name,TypeName,Properties,Cost,LeftInStorage)
			VALUES (
				5, -- Значение для столбца ProductTypeID
				@name, -- Значение для столбца Name
				@typeName,
				@properties,
				@cost,
				@left
			);
		END

		DECLARE @productIndex INT;
		SET @productIndex=(SELECT MAX(ProductID) FROM dbo.Products);

		DECLARE @productTypeIndex INT;
		SET @productTypeIndex=(SELECT ProductTypeID FROM dbo.Products WHERE ProductID=@productIndex);

		DECLARE @providerIndex INT;
		SET @providerIndex=(SELECT ProviderID FROM dbo.Providers WHERE Name=@providerName);

		INSERT dbo.Supplies(ProductTypeID,ProductID,ProviderID,Cost)
		VALUES(@productTypeIndex,@productIndex,@providerIndex,@providerCost);

        -- Установка значения выходного параметра
        SET @out = 'Success';
    END
    ELSE
    BEGIN
        -- Установка значения выходного параметра
        SET @out = 'Error';
    END
END
GO
/****** Object:  Trigger [dbo].[delete_trigger]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[delete_trigger]
ON [dbo].[Products]
AFTER DELETE
AS
BEGIN
  IF EXISTS (
        SELECT 1 FROM dbo.Supplies
        WHERE ProductID IN (SELECT ProductID FROM deleted)
	)
  BEGIN

	DELETE FROM dbo.Supplies
	WHERE ProductID IN (SELECT ProductID FROM deleted);

  END
END;
GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [delete_trigger]
GO
/****** Object:  Trigger [dbo].[trg_DeleteRow]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_DeleteRow]
ON [dbo].[Providers] -- Замените YourTableName на имя вашей таблицы
FOR DELETE
AS
BEGIN
    -- Ваш код обработки здесь
    -- Например, удаление связанных строк из других таблиц
    DELETE FROM dbo.Supplies
    WHERE ProviderID IN (SELECT ProviderID FROM deleted);
END;
GO
ALTER TABLE [dbo].[Providers] ENABLE TRIGGER [trg_DeleteRow]
GO
/****** Object:  Trigger [dbo].[CollectStatistics]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[CollectStatistics]
ON [dbo].[PurchaseDetails]
AFTER INSERT
AS
BEGIN 
	DECLARE @productID INT;
	DECLARE @productTypeID INT;
	SET @productID=(SELECT ProductID FROM INSERTED);
	SET @productTypeID=(SELECT ProductTypeID FROM INSERTED);

	DECLARE @rows INT;
	SET @rows=(SELECT COUNT(*) FROM dbo.PurchaseDetailsStatistic WHERE ProductID=@productID AND ProductTypeID=@productTypeID);

	IF(@rows=0)
	BEGIN
		INSERT INTO dbo.PurchaseDetailsStatistic(ProductID,ProductTypeID)
		VALUES (@productID,@productTypeID);
	END;

	DECLARE @purchaseID INT;
	DECLARE @date DATE;

	SET @purchaseID=(SELECT MAX(PurchaseID) FROM dbo.Purchases);
	SET @date=(SELECT Date FROM dbo.Purchases WHERE PurchaseID=@purchaseID);

	
	DECLARE @Cost DECIMAL(18,2);
	--SET @Cost=(SELECT Cost FROM dbo.PurchaseDetails WHERE PurchaseID=@purchaseID AND ProductID=@productID AND ProductTypeID=@productTypeID)
	SET @Cost=(SELECT Cost FROM INSERTED);
	DECLARE @Number DECIMAL(18,2);
	--SET @Number=(SELECT Products_number FROM dbo.PurchaseDetails WHERE PurchaseID=@purchaseID AND ProductID=@productID AND ProductTypeID=@productTypeID)
	SET @Number=(SELECT Products_number FROM INSERTED);

	SET @rows = (SELECT COUNT(*) FROM dbo.PurchasesStatistics WHERE ProductID=@productID AND ProductTypeID=@productTypeID AND DATEPART(YEAR,Date)=DATEPART(YEAR,@date) AND DATEPART(MONTH,Date)=DATEPART(MONTH,@date));

	IF(@rows=0)
	 BEGIN
		INSERT INTO dbo.PurchasesStatistics(ProductID,ProductTypeID,Earnings,ProductsNumber)
		VALUES (@productID,@productTypeID,@Cost,@Number);
	 END
	ELSE
	 BEGIN
		UPDATE dbo.PurchasesStatistics
		SET Earnings=Earnings+@Cost,
		    ProductsNumber=ProductsNumber+@Number
		WHERE ProductID=@productID AND ProductTypeID=@productTypeID AND Date=@date;
	 END;

		UPDATE dbo.Products
		SET LeftInStorage=LeftInStorage-@Number
		WHERE ProductID=@productID
			AND ProductTypeID=@productTypeID;
END;

GO
ALTER TABLE [dbo].[PurchaseDetails] ENABLE TRIGGER [CollectStatistics]
GO
/****** Object:  Trigger [dbo].[after_delete_trigger]    Script Date: 11.02.2024 16:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[after_delete_trigger]
ON [dbo].[Purchases]
AFTER DELETE
AS
BEGIN
  -- Удаление связанных строк из related_table
  DELETE FROM dbo.PurchaseDetails
  WHERE PurchaseID IN (SELECT PurchaseID FROM deleted);
END;
GO
ALTER TABLE [dbo].[Purchases] ENABLE TRIGGER [after_delete_trigger]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Login'
GO
USE [master]
GO
ALTER DATABASE [kursovoi] SET  READ_WRITE 
GO
