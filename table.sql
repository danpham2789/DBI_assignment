create database librarydb;
go
use librarydb;
go

create table authors (
    author_id varchar(36) primary key,
    name nvarchar(255) not null
);

create table books (
    book_id varchar(36) primary key,
    title nvarchar(255) not null,
    author_id varchar(36),
    isbn varchar(20) unique,
    published_year int check (published_year > 0),
    foreign key (author_id) references authors(author_id)
);

create table book_copies (
    copy_id varchar(36) primary key,
    book_id varchar(36),
    condition varchar(10) check (condition in ('new', 'good', 'damaged')),
    status varchar(10) check (status in ('available', 'borrowed', 'lost')),
    foreign key (book_id) references books(book_id)
);

create table categories (
    category_id varchar(36) primary key,
    category_name nvarchar(100) not null
);

create table book_categories (
    book_id varchar(36),
    category_id varchar(36),
    primary key (book_id, category_id),
    foreign key (book_id) references books(book_id),
    foreign key (category_id) references categories(category_id)
);

create table members (
    member_id varchar(36) primary key,
    name nvarchar(255) not null,
    email nvarchar(100) unique,
    phone nvarchar(15),
    address nvarchar(255)
);

create table staff (
    staff_id varchar(36) primary key,
    name nvarchar(255) not null,
    email nvarchar(100) unique,
    phone nvarchar(15),
    role varchar(20) check (role in ('librarian', 'manager'))
);

create table loans (
    loan_id varchar(36) primary key,
    copy_id varchar(36),
    member_id varchar(36),
    staff_id varchar(36),
    loan_date date not null,
    due_date date not null,
    return_date date null,
    status varchar(10) check (status in ('borrowed', 'returned', 'overdue')),
    foreign key (copy_id) references book_copies(copy_id),
    foreign key (member_id) references members(member_id),
    foreign key (staff_id) references staff(staff_id)
);

create table fines (
    fine_id varchar(36) primary key,
    loan_id varchar(36),
    amount decimal(10,2) not null check (amount >= 0),
    paid bit default 0,
    foreign key (loan_id) references loans(loan_id)
);
go

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
go

-- trigger: kiểm tra trạng thái sách và cập nhật khi mượn/trả
create trigger trg_manage_book_status
on loans
after insert, update
as
begin
    -- kiểm tra không cho mượn sách đã mất hoặc đang mượn
    if exists (
        select 1 from inserted i
        join book_copies bc on i.copy_id = bc.copy_id
        where bc.status in ('lost', 'borrowed')
    )
    begin
        raiserror ('không thể mượn sách', 16, 1);
        rollback transaction;
        return;
    end;

    -- cập nhật trạng thái sách khi mượn
    update book_copies
    set status = 'borrowed'
    from book_copies bc
    join inserted i on bc.copy_id = i.copy_id
    where i.status = 'borrowed';

    -- cập nhật trạng thái sách khi trả
    update book_copies
    set status = 'available'
    from book_copies bc
    join inserted i on bc.copy_id = i.copy_id
    where i.status = 'returned' and i.return_date is not null;
end;
go
	
-- thủ tục thêm sách mới
create procedure add_new_book
    @book_id varchar(36),
    @title nvarchar(255),
    @author_id varchar(36),
    @isbn varchar(20),
    @published_year int
as
begin
    insert into books (book_id, title, author_id, isbn, published_year)
    values (@book_id, @title, @author_id, @isbn, @published_year);
end;
go

-- thủ tục cập nhật thông tin sách
create procedure update_book_info
    @book_id varchar(36),
    @title nvarchar(255),
    @author_id varchar(36),
    @published_year int
as
begin
    update books
    set title = @title, author_id = @author_id, published_year = @published_year
    where book_id = @book_id;
end;
go

-- thủ tục thêm thành viên mới
create procedure add_member
    @member_id varchar(36),
    @name nvarchar(225),
    @email nvarchar(100),
    @phone nvarchar(15),
    @address nvarchar(255)
as
begin
    insert into members (member_id, name, email, phone, address)
    values (@member_id, @name, @email, @phone, @address);
end;
go

-- thủ tục tìm sách theo danh mục
create procedure get_books_by_category
    @category_name nvarchar(100)
as
begin
    select b.book_id, b.title
    from books b
    join book_categories bc on b.book_id = bc.book_id
    join categories c on bc.category_id = c.category_id
    where c.category_name = @category_name;
end;
go
-- thủ tục kiểm tra thành viên có bị khóa không và cập nhật trạng thái sách trước khi mượn.
create procedure borrow_book
    @loan_id varchar(36),
    @copy_id varchar(36),
    @member_id varchar(36),
    @staff_id varchar(36),
    @loan_date date,
    @due_date date
as
begin
    -- kiểm tra thành viên có bị khóa không
    if dbo.fn_is_member_blocked(@member_id) = 1
    begin
        raiserror ('thành viên đang bị khóa do nợ tiền phạt.', 16, 1);
        return;
    end;

    -- thêm khoản mượn
    insert into loans (loan_id, copy_id, member_id, staff_id, loan_date, due_date, status)
    values (@loan_id, @copy_id, @member_id, @staff_id, @loan_date, @due_date, 'borrowed');

    -- cập nhật trạng thái sách
    update book_copies set status = 'borrowed' where copy_id = @copy_id;
end;
go


-- view danh sách sách kèm tình trạng
create view vw_book_status as
select b.book_id, b.title, bc.copy_id, bc.condition, bc.status
from books b
join book_copies bc on b.book_id = bc.book_id;
go

-- view danh sách sách đang được mượn
create view vw_borrowed_books as
select b.title, m.name
from loans l
join book_copies bc on l.copy_id = bc.copy_id
join books b on bc.book_id = b.book_id
join members m on l.member_id = m.member_id
where l.status = 'borrowed';
go

-- view thể loại có nhiều sách nhất
create view vw_top_category as
select top 1 with ties c.category_id, c.category_name, count(b.book_id) as total_books
from categories c
join book_categories bc on c.category_id = bc.category_id
join books b on bc.book_id = b.book_id
group by c.category_id, c.category_name
order by count(b.book_id) desc;
go

-- view danh sách sách đã mất
create view vw_lost_books as
select b.book_id, b.title, bc.copy_id, bc.condition
from books b
join book_copies bc on b.book_id = bc.book_id
where bc.status = 'lost';
go

-- view danh sách thành viên bị khóa do nợ tiền phạt
create view vw_blocked_members as
select m.member_id, m.name, dbo.fn_get_unpaid_fine(m.member_id) as total_fine
from members m
where dbo.fn_is_member_blocked(m.member_id) = 1;
go


-- hàm kiểm tra sách có sẵn không
create function fn_check_book_availability (@book_id varchar(36))
returns bit
as
begin
    declare @available bit;
    set @available = case when exists (
        select 1 from book_copies where book_id = @book_id and status = 'available'
    ) then 1 else 0 end;
    return @available;
end;
go

-- hàm đếm số bản sao của một cuốn sách
create function fn_count_book_copies (@book_id varchar(36))
returns int
as
begin
    declare @count int;
    select @count = count(*) from book_copies where book_id = @book_id;
    return @count;
end;
go

-- hàm tính tổng tiền phạt chưa thanh toán của một thành viên
create function fn_get_unpaid_fine (@member_id varchar(36))
returns decimal(10,2)
as
begin
    declare @total_fine decimal(10,2);
    select @total_fine = coalesce(sum(f.amount), 0)
    from fines f
    join loans l on f.loan_id = l.loan_id
    where l.member_id = @member_id and f.paid = 0;
    return @total_fine;
end;
go

-- hàm đếm số sách của một tác giả
create function fn_count_books_by_author (@author_id varchar(36))
returns int
as
begin
    declare @count int;
    select @count = count(*) from books where author_id = @author_id;
    return @count;
end;
go

--Hàm kiểm tra thành viên có bị khóa không (do nợ tiền phạt quá nhiều)
create function fn_is_member_blocked (@member_id varchar(36))
returns bit
as
begin
    declare @is_blocked bit;
    declare @total_fine decimal(10,2);
    
    select @total_fine = coalesce(sum(amount), 0) 
    from fines f
    join loans l on f.loan_id = l.loan_id
    where l.member_id = @member_id and f.paid = 0;

    set @is_blocked = case when @total_fine > 500000 then 1 else 0 end;
    return @is_blocked;
end;
go
