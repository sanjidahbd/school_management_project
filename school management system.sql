CREATE TABLE `Users` (
  `user_id` integer PRIMARY KEY,
  `username` varchar(50) UNIQUE,
  `password_hash` char(32),
  `role` varchar(15)
);

CREATE TABLE `Students` (
  `student_id` integer PRIMARY KEY,
  `first_name` varchar(50),
  `last_name` varchar(50),
  `email` varchar(100) UNIQUE,
  `user_id` integer
);

CREATE TABLE `Teachers` (
  `teacher_id` integer PRIMARY KEY,
  `first_name` varchar(50),
  `last_name` varchar(50),
  `email` varchar(100) UNIQUE,
  `user_id` integer
);

CREATE TABLE `Parents` (
  `parent_id` integer PRIMARY KEY,
  `first_name` varchar(50),
  `last_name` varchar(50),
  `email` varchar(100) UNIQUE,
  `user_id` integer,
  `student_id` integer
);

CREATE TABLE `Classes` (
  `class_id` integer PRIMARY KEY,
  `class_name` varchar(20)
);

CREATE TABLE `Enrollment` (
  `enrollment_id` integer PRIMARY KEY,
  `student_id` integer,
  `class_id` integer
);

CREATE TABLE `Exams` (
  `exam_id` integer PRIMARY KEY,
  `exam_name` varchar(50),
  `academic_year` varchar(10),
  `exam_month` varchar(20),
  `start_date` date
);

CREATE TABLE `Marks` (
  `mark_id` integer PRIMARY KEY,
  `student_id` integer,
  `class_id` integer,
  `exam_id` integer,
  `subject_name` varchar(50),
  `marks_obtained` integer
);

CREATE TABLE `Attendance` (
  `attendance_id` integer PRIMARY KEY,
  `student_id` integer,
  `class_id` integer,
  `attendance_date` date,
  `status` varchar(10)
);

CREATE TABLE `Routine` (
  `routine_id` integer PRIMARY KEY,
  `class_id` integer,
  `day_of_week` varchar(10),
  `start_time` time,
  `subject_name` varchar(50),
  `teacher_id` integer
);

CREATE TABLE `Notices` (
  `notice_id` integer PRIMARY KEY,
  `title` varchar(100),
  `content` text,
  `published_date` date,
  `published_by_user_id` integer
);

CREATE TABLE `Events` (
  `event_id` integer PRIMARY KEY,
  `title` varchar(100),
  `description` text,
  `event_date` date,
  `location` varchar(100),
  `published_by_user_id` integer
);

CREATE TABLE `Library_Books` (
  `book_id` integer PRIMARY KEY,
  `title` varchar(150),
  `author` varchar(100),
  `isbn` varchar(13) UNIQUE,
  `total_copies` integer
);

CREATE TABLE `Invoices` (
  `invoice_id` integer PRIMARY KEY,
  `student_id` integer,
  `issue_date` date,
  `due_date` date,
  `total_amount` decimal(10,2),
  `status` varchar(20)
);

CREATE TABLE `Invoice_Items` (
  `item_id` integer PRIMARY KEY,
  `invoice_id` integer,
  `item_description` varchar(100),
  `amount` decimal(10,2)
);

CREATE TABLE `Payments` (
  `payment_id` integer PRIMARY KEY,
  `invoice_id` integer,
  `payment_date` datetime,
  `paid_amount` decimal(10,2),
  `payment_method` varchar(50),
  `transaction_id` varchar(100)
);

CREATE TABLE `Messages` (
  `message_id` integer PRIMARY KEY,
  `sender_user_id` integer,
  `receiver_user_id` integer,
  `body` text,
  `sent_date_time` datetime
);

ALTER TABLE `Students` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Teachers` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Parents` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Parents` ADD FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`);

ALTER TABLE `Enrollment` ADD FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`);

ALTER TABLE `Enrollment` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `Marks` ADD FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`);

ALTER TABLE `Marks` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `Marks` ADD FOREIGN KEY (`exam_id`) REFERENCES `Exams` (`exam_id`);

ALTER TABLE `Attendance` ADD FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`);

ALTER TABLE `Attendance` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `Routine` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `Routine` ADD FOREIGN KEY (`teacher_id`) REFERENCES `Teachers` (`teacher_id`);

ALTER TABLE `Notices` ADD FOREIGN KEY (`published_by_user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Events` ADD FOREIGN KEY (`published_by_user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Invoices` ADD FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`);

ALTER TABLE `Invoice_Items` ADD FOREIGN KEY (`invoice_id`) REFERENCES `Invoices` (`invoice_id`);

ALTER TABLE `Payments` ADD FOREIGN KEY (`invoice_id`) REFERENCES `Invoices` (`invoice_id`);

ALTER TABLE `Messages` ADD FOREIGN KEY (`sender_user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Messages` ADD FOREIGN KEY (`receiver_user_id`) REFERENCES `Users` (`user_id`);
