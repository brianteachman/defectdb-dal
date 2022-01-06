USE master
GO

IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'DefectDB'
)
CREATE DATABASE [DefectDB]
GO

USE DefectDB
GO

CREATE TABLE machines (
	MachineId INT IDENTITY PRIMARY KEY,
	MachineName VARCHAR(50) NOT NULL,
	LineNumber INT NOT NULL,
	Manufacturer VARCHAR(50) NULL,
	ModelNumber VARCHAR(50) NULL,
);

CREATE TABLE qa_stations (
	StationId INT IDENTITY PRIMARY KEY,
	StationName VARCHAR(50) NOT NULL,
	StationCode VARCHAR(3) NOT NULL,
);

CREATE TABLE defect_types (
	TypeId INT IDENTITY PRIMARY KEY,
	TypeName VARCHAR(50) NOT NULL,
	TypeCode VARCHAR(3) NOT NULL,
);

CREATE TABLE defects (
	DefectId INT IDENTITY PRIMARY KEY,
	SerialNumber VARCHAR(15) NOT NULL,
	CellLocation VARCHAR(50) NOT NULL,
	Cause VARCHAR(50) NOT NULL,
	DateFound VARCHAR(10) NOT NULL,
	TimeFound VARCHAR(8) NOT NULL,
    OriginId INT NOT NULL REFERENCES machines (MachineId),
    TypeId INT NOT NULL REFERENCES defect_types (TypeId),
	StationId INT NULL REFERENCES qa_stations (StationId)
);
GO

CREATE VIEW defect_details
AS
SELECT
    d.SerialNumber,
    d.CellLocation,
    dt.TypeName AS DefectType,
    s.StationName AS FoundAt,
    d.Cause,
    m.MachineName AS Origin,
    d.DateFound,
    d.TimeFound
FROM defects d
INNER JOIN defect_types dt
        ON d.TypeId = dt.TypeId
INNER JOIN qa_stations s
        ON d.StationId = s.StationId
INNER JOIN machines m
        ON d.OriginId = m.MachineId;
GO

INSERT INTO qa_stations (StationName, StationCode) VALUES (N'Pre-Solder', N'QC1');
INSERT INTO qa_stations (StationName, StationCode) VALUES (N'Post-Solder', N'QC2');
INSERT INTO qa_stations (StationName, StationCode) VALUES (N'EL Pre-Lam', N'QC3'); 
INSERT INTO qa_stations (StationName, StationCode) VALUES (N'Post-Lam', N'QC4');

INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Cell Color', N'CC');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Cell Crack', N'C');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Missed Solder', N'MS');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Tab Drop', N'TD');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Misaligned Longitudinal Ribbon', N'M');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Misaligned Transversal Ribbon', N'T');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Inclusion', N'I');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Bus Distance', N'D');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Ribbon Angle', N'RA');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Backsheet Insulation', N'B');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Class Scratches', N'G');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Vacuum Bubbles', N'VB');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Lamination', N'L');
INSERT INTO defect_types (TypeName, TypeCode) VALUES (N'Broken Laminate', N'Q');

INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Stringer 1', N'Team Teknic', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Stringer 2', N'Team Teknic', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Stringer 3', N'Team Teknic', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'SolderBot', N'ATN', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Laminator 1', N'3S', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Laminator 2', N'3S', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Laminator 3', N'3S', 1);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Laminator 4', N'Boost', 1);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Laminator 5', N'Boost', 1);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Framer', N'Rimas', 3);
INSERT INTO machines (MachineName, Manufacturer, LineNumber) VALUES (N'Framer', N'Rimas', 2);
GO
