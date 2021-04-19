create table dbo.UserQuestions(
Seq	Int identity,
PlayerID	INT,
QuestionSeq	INT,
Question	varchar(1000),
Response	INT
)

--    select * from dbo.UserQuestions