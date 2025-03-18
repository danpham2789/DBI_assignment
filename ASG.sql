--1.Query: Danh sách sách có tình trạng "available"
SELECT b.title, bc.copy_id, bc.condition
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
WHERE bc.status = 'available';
--2.Trigger: Ngăn chặn mượn sách bị mất
CREATE TRIGGER trg_PreventLoanLostBook
ON loans
BEFORE INSERT
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
