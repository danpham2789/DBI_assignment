--1.Query: Danh sách sách có tình trạng "available"
SELECT b.title, bc.copy_id, bc.condition
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
WHERE bc.status = 'available';
--2.Trigger: Tự động cập nhật trạng thái sách khi sách được trả
CREATE TRIGGER trg_update_book_status
ON loans
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE status = 'returned')
    BEGIN
        UPDATE book_copies
        SET status = 'available'
        WHERE copy_id IN (SELECT copy_id FROM inserted WHERE status = 'returned');
    END
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
