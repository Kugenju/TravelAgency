USE TravelAgency;

CREATE TABLE dbo.Line (
  LineID int IDENTITY(1, 1) NOT NULL,
  LineName varchar(50) NOT NULL,
  StartTime Date Not NULL,
  EndTime Date NOT NULL,
  Transportaion varchar(50) NOT NULL,
  TransFee varchar(50) NOT NULL,
  Price int NOT NULL,
  AllDay int NOT NULL,
  Status int NOT NULL,
  PRIMARY KEY (LineID)
);

CREATE TABLE dbo.Hotel (
  HotelID int IDENTITY(1, 1) NOT NULL,
  HotelName varchar(50) NOT NULL,
  Address varchar(max) NOT NULL,
  Price int NOT NULL,
  PRIMARY KEY (HotelID)
);

CREATE TABLE dbo.Spot (
  SpotID int IDENTITY(1, 1) NOT NULL,
  SpotName varchar(50) NOT NULL,
  Address varchar(max) NOT NULL,
  Price int NOT NULL,
  PRIMARY KEY (SpotID)
);

CREATE TABLE dbo.Customer (
  CustomerID int IDENTITY(1, 1) NOT NULL,
  CustomerName varchar(50) NOT NULL,
  Phone varchar(50) NOT NULL,
  Address varchar(max) NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE dbo.Orders (
  OrderID int IDENTITY(1,1) NOT NULL,
  CustomerID int NOT NULL,
  LineID int NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (LineID) REFERENCES dbo.Line (LineID) ON DELETE CASCADE,
  FOREiGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE dbo.Guide(
  GuideID int IDENTITY(1,1) NOT NULL,
  GuideName varchar(50) NOT NULL,
  Contact varchar(50) NOT NULL,
  PRIMARY KEY (GuideID)
);

CREATE TABLE dbo.Leadings (
  GuideID int NOT NULL,
  LineID int NOT NULL,
  PRIMARY KEY (GuideID, LineID),
  FOREIGN KEY (GuideID) REFERENCES dbo.Guide(GuideID) ON DELETE CASCADE,
  FOREIGN KEY (LineID) REFERENCES dbo.Line(LineID) ON DELETE CASCADE
);

CREATE TABLE dbo.Reserve (
  LineID int NOT NULL,
  HotelID int NOT NULL,
  Day int NOT NULL,
  PRIMARY KEY (LineID, HotelID),
  FOREIGN KEY (LineID) REFERENCES dbo.Line(LineID) ON DELETE CASCADE,
  FOREIGN KEY (HotelID) REFERENCES dbo.Hotel(HotelID) ON DELETE CASCADE
);

CREATE TABLE dbo.Visit (
  LineID int NOT NULL,
  SpotID int NOT NULL,
  Day int NOT NULL,
  PRIMARY KEY (LineID, SpotID),
  FOREIGN KEY (LineID) REFERENCES dbo.Line(LineID) ON DELETE CASCADE,
  FOREIGN KEY (SpotID) REFERENCES dbo.Spot(SpotID) ON DELETE CASCADE
);

