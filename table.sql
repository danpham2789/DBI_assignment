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
