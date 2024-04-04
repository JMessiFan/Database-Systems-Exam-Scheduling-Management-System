-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2024 at 09:36 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `examschedulingmanagement`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `attendance_pardon` (IN `courseId` VARCHAR(20), IN `id` INT(10))   BEGIN
UPDATE enroll
SET STU_Attendance='99.99'
WHERE COURSE_ID = courseId
AND STU_ID = id;
UPDATE enroll
SET STATUS ='ELIGIBLE'
WHERE COURSE_ID = courseId
AND STU_ID = id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `COURSE_ID` varchar(20) NOT NULL,
  `COURSE_NAME` varchar(30) DEFAULT NULL,
  `COURSE_CREDIT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`COURSE_ID`, `COURSE_NAME`, `COURSE_CREDIT`) VALUES
('TCP1121', 'Computer Programming', 4),
('TDB1131', 'Database Systems', 3),
('TMA1111', 'Mathematical Techniques', 4),
('TOS1141', 'Operating Systems', 3);

-- --------------------------------------------------------

--
-- Table structure for table `enroll`
--

CREATE TABLE `enroll` (
  `COURSE_ID` varchar(20) NOT NULL,
  `STU_ID` int(11) NOT NULL,
  `STU_ATTENDANCE` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enroll`
--

INSERT INTO `enroll` (`COURSE_ID`, `STU_ID`, `STU_ATTENDANCE`) VALUES
('TCP1121', 1200, '80.00'),
('TCP1121', 1201, '89.90'),
('TCP1121', 1203, '84.00'),
('TCP1121', 1205, '88.00'),
('TCP1121', 1208, '81.00'),
('TDB1131', 1200, '82.00'),
('TDB1131', 1201, '99.99'),
('TDB1131', 1202, '88.00'),
('TDB1131', 1203, '97.00'),
('TDB1131', 1204, '99.99'),
('TDB1131', 1205, '94.00'),
('TDB1131', 1206, '83.33'),
('TDB1131', 1207, '76.00'),
('TDB1131', 1208, '66.67'),
('TDB1131', 1209, '90.00'),
('TMA1111', 1200, '60.00'),
('TMA1111', 1201, '83.11'),
('TMA1111', 1202, '78.89'),
('TMA1111', 1203, '85.00'),
('TMA1111', 1205, '45.00'),
('TMA1111', 1206, '80.00'),
('TMA1111', 1208, '88.00'),
('TMA1111', 1209, '80.00'),
('TOS1141', 1201, '78.65'),
('TOS1141', 1202, '90.02'),
('TOS1141', 1204, '84.00'),
('TOS1141', 1205, '99.99'),
('TOS1141', 1206, '56.00'),
('TOS1141', 1208, '80.00'),
('TOS1141', 1209, '94.00');

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `EXAM_ID` varchar(10) NOT NULL,
  `EXAM_TYPE` char(10) DEFAULT NULL,
  `EXAM_DATE` date DEFAULT NULL,
  `EXAM_STIME` time DEFAULT NULL,
  `EXAM_FTIME` time DEFAULT NULL,
  `COURSE_ID` varchar(20) DEFAULT NULL,
  `ROOM_NUM` int(11) DEFAULT NULL,
  `INVIGILATOR_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exam`
--

INSERT INTO `exam` (`EXAM_ID`, `EXAM_TYPE`, `EXAM_DATE`, `EXAM_STIME`, `EXAM_FTIME`, `COURSE_ID`, `ROOM_NUM`, `INVIGILATOR_ID`) VALUES
('CPFI121', 'FINAL', '2023-02-06', '10:00:00', '12:00:00', 'TCP1121', 102, 1005),
('CPMID121', 'LAB', '2023-01-12', '20:00:00', '21:30:00', 'TCP1121', 101, 1005),
('DBFI131', 'FINAL', '2023-02-15', '10:00:00', '12:00:00', 'TDB1131', 104, 1004),
('DBMID131', 'MIDTERM', '0000-00-00', '20:00:00', '21:30:00', 'TDB1131', 102, 1001),
('MAFI112', 'FINAL', '2023-01-30', '10:00:00', '12:00:00', 'TMA1111', 102, 1003),
('MAMID111', 'MIDTERM', '0000-00-00', '20:00:00', '21:30:00', 'TMA1111', 104, 1001),
('OSFI141', 'FINAL', '2023-01-30', '10:00:00', '12:00:00', 'TOS1141', 102, 1002),
('OSMID141', 'MIDTERM', '0000-00-00', '20:00:00', '21:30:00', 'TOS1141', 104, 1003);

-- --------------------------------------------------------

--
-- Table structure for table `invigilator`
--

CREATE TABLE `invigilator` (
  `INVIGILATOR_ID` int(11) NOT NULL,
  `INVIGILATOR_FNAME` varchar(30) DEFAULT NULL,
  `INVIGILATOR_LNAME` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invigilator`
--

INSERT INTO `invigilator` (`INVIGILATOR_ID`, `INVIGILATOR_FNAME`, `INVIGILATOR_LNAME`) VALUES
(0, 'DUMMY', 'DUMMY'),
(1001, 'DAVID', 'WALLACE'),
(1002, 'JAN', 'LEVISON'),
(1003, 'MICHEAL', 'SCOTT'),
(1004, 'ANGELA', 'MARTIN'),
(1005, 'STANLEY', 'HUDSON');

--
-- Triggers `invigilator`
--
DELIMITER $$
CREATE TRIGGER `invg_name` BEFORE INSERT ON `invigilator` FOR EACH ROW BEGIN
SET NEW.INVIGILATOR_LNAME= 
UPPER(NEW.INVIGILATOR_LNAME);
SET NEW.INVIGILATOR_FNAME= 
UPPER(NEW.INVIGILATOR_FNAME);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `ROOM_NUM` int(11) NOT NULL,
  `ROOM_TYPE` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`ROOM_NUM`, `ROOM_TYPE`) VALUES
(101, 'LAB'),
(102, 'EXAM-ROOM'),
(103, 'LAB'),
(104, 'EXAM-ROOM'),
(106, 'LAB');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `STU_ID` int(11) NOT NULL,
  `STU_FNAME` varchar(20) DEFAULT NULL,
  `STU_LNAME` varchar(20) DEFAULT NULL,
  `STU_EMAIL` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`STU_ID`, `STU_FNAME`, `STU_LNAME`, `STU_EMAIL`) VALUES
(1200, 'John', 'News', '1200@student.mmu.edu'),
(1201, 'David', 'Senior', '1201@student.mmu.edu'),
(1202, 'June', 'Arbough', '1202@student.mmu.edu'),
(1203, 'Anne', 'Ramoras', '1203@student.mmu.edu'),
(1204, 'Alice', 'Johnson', '1204@student.mmu.edu'),
(1205, 'William', 'Smithfield', '1205@student.mmu.edu'),
(1206, 'Maria', 'Alonzo', '1206@student.mmu.edu'),
(1207, 'Ralph', 'Washington', '1207@student.mmu.edu'),
(1208, 'Larry', 'Smith', '1208@student.mmu.edu'),
(1209, 'Gerald', 'Olenko', '1209@student.mmu.edu');

-- --------------------------------------------------------

--
-- Table structure for table `tri_test`
--

CREATE TABLE `tri_test` (
  `NEW_UPT` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tri_test`
--

INSERT INTO `tri_test` (`NEW_UPT`) VALUES
('NEW ROOM\r\nADDED');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`COURSE_ID`);

--
-- Indexes for table `enroll`
--
ALTER TABLE `enroll`
  ADD PRIMARY KEY (`COURSE_ID`,`STU_ID`),
  ADD KEY `STU_ID` (`STU_ID`);

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`EXAM_ID`),
  ADD KEY `COURSE_ID` (`COURSE_ID`),
  ADD KEY `ROOM_NUM` (`ROOM_NUM`),
  ADD KEY `INVIGILATOR_ID` (`INVIGILATOR_ID`);

--
-- Indexes for table `invigilator`
--
ALTER TABLE `invigilator`
  ADD PRIMARY KEY (`INVIGILATOR_ID`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`ROOM_NUM`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`STU_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enroll`
--
ALTER TABLE `enroll`
  ADD CONSTRAINT `enroll_ibfk_1` FOREIGN KEY (`COURSE_ID`) REFERENCES `course` (`COURSE_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `enroll_ibfk_2` FOREIGN KEY (`STU_ID`) REFERENCES `student` (`STU_ID`) ON DELETE CASCADE;

--
-- Constraints for table `exam`
--
ALTER TABLE `exam`
  ADD CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`COURSE_ID`) REFERENCES `course` (`COURSE_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_ibfk_2` FOREIGN KEY (`ROOM_NUM`) REFERENCES `room` (`ROOM_NUM`) ON DELETE SET NULL,
  ADD CONSTRAINT `exam_ibfk_3` FOREIGN KEY (`INVIGILATOR_ID`) REFERENCES `invigilator` (`INVIGILATOR_ID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
