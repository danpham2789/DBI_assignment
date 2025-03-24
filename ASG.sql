create database librarydb
go
use librarydb
go


create table authors (
    author_id varchar(50) primary key,
    name nvarchar(255) not null
)

create table books (
    book_id varchar(50) primary key,
    title nvarchar(255) not null,
    author_id varchar(50),
    isbn varchar(20) unique,
    published_year int,
    foreign key (author_id) references authors(author_id)
)

create table book_copies (
    copy_id varchar(50) primary key,
    book_id varchar(50),
    condition varchar(10) check (condition in ('new', 'good', 'damaged')),
    status varchar(10) check (status in ('available', 'borrowed', 'lost')),
    foreign key (book_id) references books(book_id)
)

create table categories (
    category_id varchar(50) primary key,
    category_name nvarchar(100) not null
)

create table book_categories (
    book_id varchar(50),
    category_id varchar(50),
    primary key (book_id, category_id),
    foreign key (book_id) references books(book_id),
    foreign key (category_id) references categories(category_id)
)

create table members (
    member_id varchar(50) primary key,
    name nvarchar(255) not null,
    email nvarchar(100) unique,
    phone nvarchar(15),
    address nvarchar(255)
)

create table staff (
    staff_id varchar(50) primary key,
    name nvarchar(255) not null,
    email nvarchar(100) unique,
    phone nvarchar(15),
    role varchar(20) check (role in ('librarian', 'manager'))
)

create table loans (
    loan_id varchar(50) primary key,
    copy_id varchar(50),
    member_id varchar(50),
    staff_id varchar(50),
    loan_date date not null,
    due_date date not null,
    return_date date null,
    status varchar(10) check (status in ('borrowed', 'returned', 'overdue')),
    foreign key (copy_id) references book_copies(copy_id),
    foreign key (member_id) references members(member_id),
    foreign key (staff_id) references staff(staff_id)
)

create table fines (
    fine_id varchar(50) primary key,
    loan_id varchar(50),
    amount decimal(10,2) not null,
    paid bit default 0,
    foreign key (loan_id) references loans(loan_id)
)

insert into authors (author_id, name) values
('A001', 'J.K. Rowling'),
('A002', 'George Orwell'),
('A003', 'Haruki Murakami'),
('A004', 'Stephen King'),
('A005', 'Agatha Christie'),
('A006', 'J.R.R. Tolkien'),
('A007', 'Dan Brown'),
('A008', 'Isaac Asimov'),
('A009', 'Leo Tolstoy'),
('A010', 'Mark Twain')

insert into books (book_id, title, author_id, isbn, published_year) values
('B001', 'Harry Potter and the Sorcerer''s Stone', 'A001', '978-0439708180', 1997),
('B002', '1984', 'A002', '978-0451524935', 1949),
('B003', 'Norwegian Wood', 'A003', '978-0375704024', 1987),
('B004', 'The Shining', 'A004', '978-0307743657', 1977),
('B005', 'Murder on the Orient Express', 'A005', '978-0062693662', 1934),
('B006', 'The Hobbit', 'A006', '978-0261103344', 1937),
('B007', 'The Da Vinci Code', 'A007', '978-0307474278', 2003),
('B008', 'Foundation', 'A008', '978-0553293357', 1951),
('B009', 'War and Peace', 'A009', '978-1400079988', 1869),
('B010', 'The Adventures of Tom Sawyer', 'A010', '978-0486400778', 1876)

insert into book_copies (copy_id, book_id, condition, status) values
('C001', 'B001', 'new', 'available'),
('C002', 'B001', 'good', 'borrowed'),
('C003', 'B002', 'good', 'available'),
('C004', 'B002', 'damaged', 'lost'),
('C005', 'B003', 'new', 'available'),
('C006', 'B004', 'good', 'available'),
('C007', 'B005', 'new', 'borrowed'),
('C008', 'B006', 'good', 'available'),
('C009', 'B007', 'good', 'available'),
('C010', 'B008', 'new', 'borrowed')

insert into categories (category_id, category_name) values
('CAT001', 'Fantasy'),
('CAT002', 'Science Fiction'),
('CAT003', 'Horror'),
('CAT004', 'Mystery'),
('CAT005', 'Historical'),
('CAT006', 'Classic'),
('CAT007', 'Philosophy'),
('CAT008', 'Biography'),
('CAT009', 'Adventure'),
('CAT010', 'Thriller')

insert into book_categories (book_id, category_id) values
('B001', 'CAT001'), ('B001', 'CAT009'),
('B002', 'CAT002'),
('B003', 'CAT006'),
('B004', 'CAT003'),
('B005', 'CAT004'),
('B006', 'CAT001'),
('B006', 'CAT009'),
('B007', 'CAT010'),
('B008', 'CAT002'),
('B009', 'CAT005'), ('B009', 'CAT006'),
('B010', 'CAT009')

insert into members (member_id, name, email, phone, address) values
('M001', 'Nguyen Van A', 'a@gmail.com', '0901234567', 'Hanoi, Vietnam'),
('M002', 'Tran Thi B', 'b@gmail.com', '0902345678', 'Da Nang, Vietnam'),
('M003', 'Le Van C', 'c@gmail.com', '0903456789', 'Ho Chi Minh City, Vietnam'),
('M004', 'Pham Hong D', 'd@gmail.com', '0904567890', 'Hue, Vietnam'),
('M005', 'Bui Minh E', 'e@gmail.com', '0905678901', 'Hai Phong, Vietnam')

insert into staff (staff_id, name, email, phone, role) values
('S001', 'Admin 1', 'admin1@library.com', '0911234567', 'librarian'),
('S002', 'Admin 2', 'admin2@library.com', '0912345678', 'manager')

insert into loans (loan_id, copy_id, member_id, staff_id, loan_date, due_date, return_date, status) values
('L001', 'C002', 'M001', 'S001', '2024-03-01', '2024-03-15', null, 'borrowed'),
('L002', 'C007', 'M002', 'S001', '2024-03-02', '2024-03-16', '2024-03-10', 'returned'),
('L003', 'C010', 'M003', 'S002', '2024-03-03', '2024-03-17', null, 'borrowed')

insert into fines (fine_id, loan_id, amount, paid) values
('F001', 'L002', 50000, 1),
('F002', 'L003', 75000, 0)
--1.Query: Danh sách sách có tình trạng "available"
SELECT b.title, bc.copy_id, bc.condition
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
WHERE bc.status = 'available';
--2.Trigger: Ngăn chặn mượn sách bị mất
CREATE TRIGGER trg_PreventLoanLostBook
ON loans
instead of INSERT
AS
BEGIN
    -- Kiểm tra nếu có cuốn sách nào bị mất thì ngăn chặn việc mượn
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN book_copies bc ON i.copy_id = bc.copy_id
        WHERE bc.status = 'lost'
    )
    BEGIN
        -- Hiển thị lỗi và rollback transaction
        RAISERROR ('Không thể mượn sách vì sách đã bị mất!', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

--3.Procedure: Tìm sách theo danh mục
CREATE PROCEDURE GetBooksByCategory
    @category_name NVARCHAR(100)
AS
BEGIN
    SELECT b.book_id, b.title
    FROM books b
    JOIN book_categories bc ON b.book_id = bc.book_id
    JOIN categories c ON bc.category_id = c.category_id
    WHERE c.category_name = @category_name;
END;

EXEC GetBooksByCategory 'Fantasy';

--4.View: Tạo view danh sách sách kèm tình trạng của chúng
DROP VIEW IF EXISTS vw_BookStatus;

CREATE VIEW vw_BookStatus AS
SELECT b.book_id, b.title, bc.copy_id, bc.condition, bc.status
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id;

SELECT * FROM vw_BookStatus;
--5.Function: Hàm tính tổng số sách theo tác giả
CREATE FUNCTION fn_BookCountByAuthor (@author_id VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*) FROM books WHERE author_id = @author_id;
    RETURN @count;
END;


SELECT dbo.fn_BookCountByAuthor('A001') AS TotalBooks;
