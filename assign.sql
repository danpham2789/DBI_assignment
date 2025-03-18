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

-- Query: Viết truy vấn lấy danh sách tất cả các sách cùng tên tác giả.
select book_id, a.name, title as N'Tên sách'
from books b join authors a on b.author_id = a.author_id


-- Trigger: Tạo trigger để tự động xóa danh mục sách nếu không còn sách nào thuộc danh mục đó.
create trigger xoaDanhMuc
on book_categories
after delete 
as
	begin 
		delete from categories 
		where category_id in (select distinct d.category_id
							  from book_categories b left join deleted d on b.category_id = d.category_id
							  where b.book_id is null) -- lọc ra các danh mục không còn sách
	end
	
	select * from book_categories

	select c.category_id, c.category_name, COUNT(bc.book_id) as so_luong_sach
	from categories c
	left join book_categories bc on c.category_id = bc.category_id
	group by c.category_id, c.category_name;

	delete from book_categories where category_id = 'CAT0010';

-- Procedure: Tạo procedure để cập nhật thông tin của một cuốn sách (tên, năm xuất bản, tác giả).
create procedure capNhatThongTinSach
	@maSach varchar(50),
	@ten nvarchar(255),
	@namXuatBan int,
	@tacGia varchar(50) 
as 
	begin 
		update books
		set author_id = @tacGia,
			title = @ten,
			published_year = @namXuatBan
		where book_id = @maSach -- giữ cho data được chính xác và ko bị thay đổi giống nhau
	end

	exec capNhatThongTinSach @maSach = 'B001', @ten = 'SQL1', @namXuatBan = '2023', @tacGia = 'A001'
	 select * from books where book_id = 'B001'

-- Function: Viết function trả về số lượng bản sao của một cuốn sách theo book_id.
create function soLuongBanSao(@bookID varchar(50))
returns varchar(50)
as
	begin 
		declare @soLuong int
		select @soLuong = count(*) from book_copies where book_id = @bookID
		return @soLuong
	end
		
	select dbo.soLuongBanSao(1) as [Số lượng bản sao của một cuốn sách];

-- View : Tạo view hiển thị danh sách các thể loại sách có nhiều sách nhất.
create view danhSachCacTheLoaiSach as
select top 1 with ties c.category_id, c.category_name, count(b.book_id) as 'soLuongSach'
from categories c join book_categories bc on c.category_id = bc.category_id
join books b on b.book_id = bc.book_id
group by c.category_id, c.category_name
order by count(b.book_id) desc;

select * from danhSachCacTheLoaiSach order by soLuongSach desc;
